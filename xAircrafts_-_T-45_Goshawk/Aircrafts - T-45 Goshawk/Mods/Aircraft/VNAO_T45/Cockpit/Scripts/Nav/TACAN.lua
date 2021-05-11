dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Nav/MissionData.lua")
--dofile(LockOn_Options.script_path.."utils.lua")

local dev = GetSelf()
local update_time_step = 0.033
make_default_activity(update_time_step)--update will be called 30 times per second
local sensor_data = get_base_data()

local Terrain = require('terrain')

local tacanRange = get_param_handle("TACAN_RANGE")
tacanRange:set(0)
local tacanBearing = get_param_handle("TACAN_BEARING")
tacanBearing:set(0)
local tacanDialOnes= get_param_handle("TACAN_DIAL_ONES") -- output to cockpit dial
tacanDialOnes:set(1)
local tacanDialTens= get_param_handle("TACAN_DIAL_TENS")
tacanDialTens:set(0)
local tacanDialHundreds= get_param_handle("TACAN_DIAL_HUNDREDS")
tacanDialHundreds:set(0)

local meter2mile = 0.000621371
local meter2feet = 3.28084
local knot2meter = 1852
local nm2meter = 1852


local channelOnes = 1
local channelTens = 0
local tacan_channel = 1
local tacan_power = 0
local tacan_volume = 0


local atcn -- "active tacan"

-- beacon_data[] entry table holds {ntype, beaconId, positionGeo {latititude, longitude}, name, channel, direction, position {x, y, z}, callsign, frequency}
local beacon_data = {}


dev:listen_command(device_commands.tacan_volume)

dev:listen_command(device_commands.TACANones)
dev:listen_command(device_commands.TACANtens)
dev:listen_command(device_commands.TACANpower)

function post_initialize()
    sndhost = create_sound_host("COCKPIT_TACAN","HEADPHONES",0,0,0)
    morse_dot_snd = sndhost:create_sound("MorzeDot") -- refers to sdef file, and sdef file content refers to sound file, see DCSWorld/Sounds/sdef/_example.sdef
    morse_dash_snd = sndhost:create_sound("MorzeDash")
  
	
    -- load Nav data
    local navData = loadfile(LockOn_Options.script_path.."Nav/beacon_data.lua")
    beacon_data = navData()
  

    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then
    elseif birth=="GROUND_COLD" then
    end
	
	dev:performClickableAction(device_commands.TACANones, 0.1, false)

	load_tempmission_file()
	miz_carriers = get_carrier_data()
end

--[[
short mark, dot or "dit" (·) : "dot duration" is one time unit long
longer mark, dash or "dah" (–) : three time units long
inter-element gap between the dots and dashes within a character : one dot duration or one unit long
short gap (between letters) : three time units long
medium gap (between words) : seven time units long
--]]

local morse_alphabet={ a=".-~",b="-...~",c="-.-.~",d="-..~",e=".~",f="..-.~",g="--.~",h="....~",
i="..~",j=".---~",k="-.-~",l=".-..~",m="--~",n="-.~",o="---~",p=".--.~",q="--.-~",r=".-.~",
s="...~",t="-~",u="..-~",v="...-~",w=".--~",x="-..-~",y="-.--~",z="--..~",[" "]="|",
["0"]="-----~",["1"]=".----~",["2"]="..---~",["3"]="...--~",["4"]="....-~",["5"]=".....~",
["6"]="-....~",["7"]="--...~",["8"]="---..~",["9"]="----.~"}

function get_morse(str)
     local morse = string.gsub(string.lower(str), "%Z", morse_alphabet)
     local morse = string.gsub(morse, "~|", "      ") -- 6 units, 7th given by preceding dot or dash
     local morse = string.gsub(morse, "|", "       ")
     local morse = string.gsub(morse, "~", "  ") -- 2 units, 3rd given by preceding dot or dash
     return morse
end

local morse_unit_time = 0.1  -- MorzeDot.wav is 0.1s long, MorzeDash.wav is 0.3s
local time_to_next_morse = 0
local current_morse_string=""
local tacan_audio_active = false


function SetCommand(command,value)
	if command == device_commands.TACANones then
		channelOnes = math.floor(value*10+0.1)
		tacan_channel = channelTens + channelOnes	
	elseif command == device_commands.TACANtens then
		channelTens = math.floor(value*20+0.1)*10
		tacan_channel = channelTens + channelOnes
	elseif command == device_commands.TACANpower then
		tacan_power = value
	end

    if command == device_commands.tacan_volume then
        tacan_volume = value
        if tacan_volume < -0.5 then
            dev:performClickableAction(device_commands.tacan_volume, 1, false)  -- bound check to fix wrap
        elseif tacan_volume < 0 and tacan_volume > -0.5 then
            dev:performClickableAction(device_commands.tacan_volume, 0, false)  -- bounds check to fix wrap
        else
            morse_dot_snd:update(nil,tacan_volume,nil)
            morse_dash_snd:update(nil,tacan_volume,nil)
        end
    end
end

--
-- takes channel 'chan' as an argument, searches the beacon database, and returns
-- key parameters about the matching beacon, or 'nil' if there's no tacan on the appropriate frequency
function find_matched_tacan(chan)
	model_time = get_model_time()

    for i = 1,#beacon_data do
        if beacon_data[i].ntype == NAV_TYPE_VOR_TAC or beacon_data[i].ntype == NAV_TYPE_TCN then
            if chan == beacon_data[i].channel or getTACANFrequency(chan, 'X') == beacon_data[i].frequency then

                if beacon_data[i].position.y == nil then
                    beacon_data[i].position.y = Terrain.GetHeight(beacon_data[i].position.x, beacon_data[i].position.z)+10   -- fix caucasus height
                end

                return beacon_data[i]
            end
        end
    end
	
	carrier_tacan = update_carrier_tacan() -- from MissionData.lua
	for i = 1,#carrier_tacan do
        if chan == carrier_tacan[i].channel then
             return carrier_tacan[i]
        end
	end
    return nil
end

function update_tacan()
    local max_tacan_range = 225

    if atcn ~= nil  and tacan_power == 1 then 
        local curx,cury,curz = sensor_data.getSelfCoordinates()

        if Terrain.isVisible(curx,cury,curz,atcn.position.x,atcn.position.y+15,atcn.position.z) then
		
            local range = math.sqrt( (atcn.position.x - curx)^2 + (atcn.position.y - cury)^2 + (atcn.position.z - curz)^2 )/nm2meter
            if range < max_tacan_range then
                tacanRange:set(range)
                tacanBearing:set(math.deg(math.atan2((atcn.position.z-curz),(atcn.position.x-curx))) %360)

                if not tacan_audio_active then
                    local timenow = get_model_time()
                    if (math.floor(timenow) % 8) == 0 then
                        if atcn.callsign ~= nil then
                            current_morse_string = get_morse(atcn.callsign)
                            tacan_audio_active = true
                        end
                    end
                end

            else
                current_morse_string = ""
                tacan_audio_active = false
                tacanRange:set(-1)
                tacanBearing:set(0)
            end
        else
            -- do not change string here, modulated with volume instead
            tacanRange:set(-1)
            tacanBearing:set(0)
        end
    else
        tacanRange:set(-1)
        tacanBearing:set(0)
        current_morse_string = ""
        tacan_audio_active = false
    end
end

function update_morse_playback()
    if #current_morse_string==0 then
        tacan_audio_active = false
        return
    end
    if (time_to_next_morse>0) then
        time_to_next_morse=time_to_next_morse-update_time_step
    end
    if time_to_next_morse <= 0 then
        -- if we fly behind a hill in the middle of a transmission, mute it while it's obscured but keep updating it
        if tacanBearing:get() == 0 then
            morse_dot_snd:update(nil,0,nil)
            morse_dash_snd:update(nil,0,nil)
        else
            morse_dot_snd:update(nil,tacan_volume,nil)
            morse_dash_snd:update(nil,tacan_volume,nil)
        end

        --print_message_to_user(current_morse_string)
        local c = current_morse_string:sub(1,1)
        --[[if morse_dot_snd:is_playing() or morse_dash_snd:is_playing() then
            print_message_to_user("previous sound still playing!")
            log.alert("previous sound still playing!")
        end--]]
        --print(c)
        if (c=='.') then
            time_to_next_morse=2*morse_unit_time  -- dot and pause
            morse_dot_snd:play_once()
        elseif (c=='-') then
            time_to_next_morse=4*morse_unit_time  -- dash and pause
            morse_dash_snd:play_once()
        elseif (c==' ') then
            time_to_next_morse=morse_unit_time
        else
            log.alert("Bad morse character: "..tostring(c))
        end
        current_morse_string=current_morse_string:sub(2,#current_morse_string)
    end
end

function update()
	atcn = find_matched_tacan(tacan_channel) -- needs to be in update() to update carrier tacan pos
    update_tacan()  
    if tacan_audio_active then
        update_morse_playback()
    end
	
	tacanDialOnes:set(channelOnes/10)
	if channelTens >= 100 then
		tacanDialHundreds:set(0.1)
		tacanDialTens:set((channelTens-100)/100)
	else
		tacanDialHundreds:set(0)
		tacanDialTens:set(channelTens/100)
	end
end

need_to_be_closed = false -- close lua state after initialization