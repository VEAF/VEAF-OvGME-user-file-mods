dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()
local update_time_step = 0.033
make_default_activity(update_time_step)--update will be called 30 times per second
local sensor_data = get_base_data()

local Terrain = require('terrain')

local meter2mile = 0.000621371
local degrees_per_radian = 57.2957795

local ils_gs_bar = get_param_handle("ILS_GS")
ils_gs_bar:set(-1)
local ils_loc_bar = get_param_handle("ILS_LOC")
ils_loc_bar:set(-1)
local vorBearing = get_param_handle("VOR_BEARING")
vorBearing:set(0)
local vorILS_type = get_param_handle("VOR_ILS_TYPE") -- 0:none, 1:VOR, 2:ILS
vorILS_type:set(0)

local vorDialWholeNxx = get_param_handle("VOR_DIAL_WHOLE_Nxx")
vorDialWholeNxx:set(0.1)
local vorDialWholexNx = get_param_handle("VOR_DIAL_WHOLE_xNx")
vorDialWholexNx:set(0)
local vorDialWholexxN = get_param_handle("VOR_DIAL_WHOLE_xxN")
vorDialWholexxN:set(0)
local vorDialDecimalNx = get_param_handle("VOR_DIAL_DEC_Nx")
vorDialDecimalNx:set(0)
local vorDialDecimalxN = get_param_handle("VOR_DIAL_DEC_xN")
vorDialDecimalxN:set(0)

local ils_loc = {}
local ils_gs = {}
local beacon_data = {} -- table holds {ntype, beaconId, positionGeo {latititude, longitude}, name, channel, direction, position {x, y, z}, callsign, frequency}

local ILSVORFrequency = 108.10
local freqWhole = 108
local freqDecimal = 0.10
local power = 0

local beacon 
local isVOR = false
local isILS = false

local glideslope = 3
local gsarc = 5
local locarc = 7.5

dev:listen_command(device_commands.VORfreqOnes)
dev:listen_command(device_commands.VORfreqDecimal)
dev:listen_command(device_commands.VORpower)

function post_initialize()
    local ILSDataIn = loadfile(LockOn_Options.script_path.."Nav/ils_data.lua")
	ils_loc, ils_gs = ILSDataIn()	
	local VORdataIn = loadfile(LockOn_Options.script_path.."Nav/beacon_data.lua")
    beacon_data = VORdataIn()
	
	beacon, GS = match_frequency(ILSVORFrequency*1000000) 
	
	dev:performClickableAction(device_commands.VORfreqDecimal, 0.1, false)
	vorDialWholeNxx:set(0.1)
end

function SetCommand(command,value)
	if command == device_commands.VORfreqOnes then
		freqWhole = math.floor(value*10+0.1)+108
		ILSVORFrequency = freqWhole + freqDecimal
		beacon, GS = match_frequency(ILSVORFrequency*1000000)
	elseif command == device_commands.VORfreqDecimal then
		freqDecimal = math.floor(value*100+0.1)/100
		ILSVORFrequency = freqWhole + freqDecimal
		beacon, GS = match_frequency(ILSVORFrequency*1000000)	
	elseif command == device_commands.VORpower then
		power = value
		beacon, GS = match_frequency(ILSVORFrequency*1000000)
	end
end

function match_frequency(frequency)
    for i = 1,#beacon_data do
        if (beacon_data[i].ntype == NAV_TYPE_VOR or beacon_data[i].ntype == NAV_TYPE_VOR_DME) and frequency == beacon_data[i].frequency then
			isVOR = true
            if beacon_data[i].position.y == nil then
				beacon_data[i].position.y = Terrain.GetHeight(beacon_data[i].position.x, beacon_data[i].position.z)+10   -- fix caucasus height
            end
            return beacon_data[i], nil
		else
			isVOR = false
        end
    end
	for i=1,#ils_loc do
		if ils_loc[i].frequency==frequency then
			isILS = true
			return ils_loc[i], ils_gs[i]
		else
			isILS = false
		end
	end
    return nil, nil
end

function updateVOR()
    if beacon and isVOR and power > 0 then 
        local curx,cury,curz = sensor_data.getSelfCoordinates()
        if Terrain.isVisible(curx,cury,curz,beacon.position.x,beacon.position.y+15,beacon.position.z) then
            vorBearing:set(math.deg(math.atan2((beacon.position.z-curz),(beacon.position.x-curx))) %360)
        else
            vorBearing:set(0)
        end
    else
        vorBearing:set(0)
    end
end

local function evalLoc()
  local tgt_rad = 0
  local rate = -1
  
  if beacon and isILS and power > 0 then
	if beacon.position.x and beacon.position.z then
		local tx = beacon.position.x
		local tz = beacon.position.z
      
		local lx, ly, lz = sensor_data.getSelfCoordinates()
		-- point to self, so need add 180 degree later
		local dx = lx - tx -- vertical
		local dz = lz - tz -- horizontal

		local dist = math.sqrt(dx*dx + dz*dz)
		if dist == 0 then dist = 0.001 end
			local distmile = dist*meter2mile
      
			if distmile <= 15 then
				if dx >= 0 then
				tgt_rad = ((360 + 90 - degrees_per_radian * math.acos(dz/dist)))%360
				else
				tgt_rad = ((90 + degrees_per_radian * math.acos(dz/dist)))%360
				end
      
				if beacon.direction - tgt_rad <= locarc and beacon.direction - tgt_rad >= -locarc then
				rate = (tgt_rad - beacon.direction)/locarc
				else
				rate = -1
				end
			else
				rate = -1
			end
	else
		rate = -1
	end
  else
    rate = -1
  end

  ils_loc_bar:set(rate)  
end

local function evalGS()
  local tgt_rad = 0
  local rate = -1
  
  if GS and isILS and power > 0 then
    if GS.position.x and GS.position.z then
            
		local tx = GS.position.x
		local tz = GS.position.z
		local ty = GS.position.y
		-- print_message_to_user("ndb ".. GS.name .." ".. GS.frequency .." ".. tx .. " " .. tz)
     
		local lx, ly, lz = sensor_data.getSelfCoordinates()
		-- point to self, so need add 180 degree later
		local dx = lx - tx -- vertical
		local dz = lz - tz -- horizontal
		local dy = ly - ty -- altitude

		local disttmp = math.sqrt(dx*dx + dz*dz)
		local dist = math.sqrt(disttmp*disttmp + dy*dy)
		if dist <= 0 then dist = 0.001 end
		local distmile = dist*meter2mile
		local disttmpmile = disttmp*meter2mile
      
		--print_message_to_user("dist: "..disttmp..", self alt: "..ly..", ILS alt: "..ty)
      
		if disttmpmile <= 15 then
			if dy >= 0 then
				tgt_rad = degrees_per_radian * math.asin(dy*meter2mile/distmile)
				--print_message_to_user("gs deg: "..tgt_rad)
         
				local sect_rad = 0
				if dx >= 0 then
					sect_rad = ((360 + 90 - degrees_per_radian * math.acos(dz/disttmp)))%360
				else
					sect_rad = ((90 + degrees_per_radian * math.acos(dz/disttmp)))%360
				end
                
				if (glideslope - tgt_rad <= gsarc and glideslope - tgt_rad >= -gsarc) and (GS.direction - sect_rad <= locarc and GS.direction - sect_rad >= -locarc) then
					rate = (glideslope - tgt_rad)/gsarc
				else
					rate = -1
				end
			else
				rate = -1
			end
		else
			rate = -1
		end
	else
		rate = -1
	end
  else
    rate = -1
  end

  ils_gs_bar:set(rate)
end

function update()
	evalLoc()
	evalGS()
	updateVOR()
	
	if isVOR and power > 0 then
		vorILS_type:set(1)
	elseif isILS and power > 0 then
		vorILS_type:set(2)
	else
		vorILS_type:set(0)
	end
	
	local intW, fracW = math.modf((freqWhole-100)/10)
	vorDialWholexNx:set(intW/10)
	vorDialWholexxN:set(fracW)
	local intDec, fracDec = math.modf(freqDecimal*10)
	vorDialDecimalNx:set(intDec/10)
	vorDialDecimalxN:set(fracDec)
end

need_to_be_closed = false -- close lua state after initialization
