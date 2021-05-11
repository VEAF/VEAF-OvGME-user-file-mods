dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
--dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.common_script_path.."../../../Database/wsTypes.lua")

local update_rate = 0.01
make_default_activity(update_rate)
local dev = GetSelf()

-- weapon state
local master_arm = 0
local pickle = false
local gun_ready = false
local fire_engaged = false

local storeL = get_param_handle("STOREL")
local storeR = get_param_handle("STORER")
local armIndication = get_param_handle("ARMIND")
local station_selected = get_param_handle("STATION_SELECTED") -- 0 none, 1 L RKT, 2 L BOMB, 3 R BOMB, 4 R RKT
local ripple_mode = get_param_handle("RIPPLE_MODE") -- 0 single, 1 ripple
local gun_select = get_param_handle("GUN_SELECT") 

dev:listen_command(Keys.MasterArmToggle)
dev:listen_command(Keys.PickleOn)
dev:listen_command(Keys.PickleOff)
dev:listen_command(Keys.PlaneFireOn)
dev:listen_command(Keys.PlaneFireOff)
dev:listen_command(Keys.SmokeOnOff)

dev:listen_command(device_commands.emergencyJettison)
dev:listen_command(device_commands.masterArm)


dev:listen_event("WeaponRearmSingleStepComplete")

function post_initialize()
    sndhost = create_sound_host("COCKPIT_ARMS","2D",0,0,0)
    bombtone = sndhost:create_sound("T45bombtone") -- refers to sdef file, and sdef file content refers to sound file, see DCSWorld/Sounds/sdef/_example.sdef
	guntone = sndhost:create_sound("T45guntone")
	pickle = false	
    
	dev:performClickableAction(device_commands.masterArm,0,true)
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="AIR_HOT" then --"GROUND_COLD","GROUND_HOT","AIR_HOT"
    elseif birth=="GROUND_COLD" or birth=="GROUND_HOT" then      
    end

end

local release_timer = 0
local release_interval = 0.15
local FiredOnce = 0

local smokeOn = false

function update()

    local gear = get_aircraft_draw_argument_value(0) 
	local StationReady = station_selected:get()
    if master_arm==1 and pickle and gear == 0 and FiredOnce == 0 then
        release_timer = release_timer + update_rate
		if StationReady == 1 then
			local stationInfo = dev:get_station_info(0)
			if stationInfo.weapon.level2 == wsType_NURS and stationInfo.count > 0 and release_timer >= release_interval  then
				dev:launch_station(0)
				release_timer = 0
				if ripple_mode:get()==0 then
				FiredOnce = 1
				end
			end
		elseif	StationReady == 2 then
			local stationInfo = dev:get_station_info(0)
			if stationInfo.weapon.level2 == wsType_Bomb and stationInfo.count > 0 and release_timer >= release_interval  then
				dev:launch_station(0)
				release_timer = 0
			end
		elseif	StationReady == 3 then
			local stationInfo = dev:get_station_info(2)
			if stationInfo.weapon.level2 == wsType_Bomb and stationInfo.count > 0 and release_timer >= release_interval  then
				dev:launch_station(2)
				release_timer = 0
			end
		elseif	StationReady == 4 then
			local stationInfo = dev:get_station_info(2)
			if stationInfo.weapon.level2 == wsType_NURS and stationInfo.count > 0 and release_timer >= release_interval  then
				dev:launch_station(2)
				release_timer = 0
				if ripple_mode:get()==0 then
				FiredOnce = 1
				end
			end
		end
    end
	
	update_stores(StationReady)

	if master_arm==1 and gear == 0 then
		armIndication:set(1)
	else
		armIndication:set(0)
	end
end

function update_stores(stationNum) -- Creates labels for each store in the MFD
local stationL = dev:get_station_info(0)
local stationR = dev:get_station_info(2)
	if stationNum == 1 then
		if stationL.weapon.level2==wsType_NURS and stationL.count > 0 then
			storeL:set('RKT\n'..stationL.count)
		else
			storeL:set('RKT\n0')	
		end
		storeR:set(' ')
	elseif stationNum == 2 then
		if stationL.weapon.level2==wsType_Bomb and stationL.count > 0 then
			storeL:set('BOMB\n'..stationL.count)
		else
			storeL:set('BOMB\n0')	
		end
		storeR:set(' ')
	elseif stationNum == 3 then
		if stationR.weapon.level2==wsType_Bomb and stationR.count > 0 then
			storeR:set('BOMB\n'..stationR.count)
		else
			storeR:set('BOMB\n0')	
		end
		storeL:set(' ')
	elseif stationNum == 4 then
		if stationR.weapon.level2==wsType_NURS and stationR.count > 0 then
			storeR:set('RKT\n'..stationR.count)
		else
			storeR:set('RKT\n0')	
		end
		storeL:set(' ')
	else
		storeL:set(' ')
		storeR:set(' ')
	end
end

function SetCommand(command,value)

	if command == device_commands.masterArm then
		master_arm = value 
    elseif command == device_commands.emergencyJettison then
        dev:emergency_jettison_rack(0)
		dev:emergency_jettison_rack(2)
		update_stores()
	elseif command == Keys.MasterArmToggle then
		dev:performClickableAction(device_commands.masterArm, 1-master_arm,true)
	elseif command == Keys.PickleOn then
        pickle = true
        if master_arm==1 then
            bombtone:play_continue()
        end
		
    elseif command == Keys.PickleOff then
        pickle = false
		FiredOnce = 0
		release_timer = 0
        bombtone:stop() -- TODO also stop after last auto-release interval bomb is dropped
    elseif command == Keys.PlaneFireOn and gun_select:get()==1 then
        fire_engaged = true 
		guntone:play_continue()		
    elseif command == Keys.PlaneFireOff then
        fire_engaged = false
		guntone:stop()
		
	elseif command == Keys.SmokeOnOff then
		smokeOn = not smokeOn
		
		if smokeOn == true then
			dev:launch_station(3)
			print_message_to_user("smoke on")
		else
			dev:launch_station(3)
			print_message_to_user("smoke off")
		end
    end
end

need_to_be_closed = false -- close lua state after initialization

--[[
GetDevice(devices.WEAPON_SYSTEM) metatable:
["get_station_info"] 
["launch_station"] = 
["select_station"] = 
["emergency_jettison"]  
["emergency_jettison_rack"] 
["set_target_range"] = 
["set_target_span"] = 
["get_target_range"] = 
["get_target_span"] = 
["get_flare_count"] = 
["drop_flare"] 
["get_chaff_count"] 
["drop_chaff"] 
["set_ECM_status"] = 
["get_ECM_status"] = 

["listen_event"] = 
["performClickableAction"] 
["SetDamage"] 
["listen_command"] 
["SetCommand"] 


old update stores
local label = {}
	for i = 0,2,2 do
		local station = dev:get_station_info(i)
		if station.count~=0 then
			if station.weapon.level2==wsType_Bomb then --bombs
				label[i]='BOMB\n'..station.count
			elseif station.weapon.level2==wsType_NURS then --rockets
				label[i]='RKT\n'..station.count
			--elseif station.weapon.level3==wsType_FuelTank then
			else
				label[i]='UKWN'
			end
		else
			label[i]=' '	-- this is used for an empty store
		end
	storeL:set(label[0])
	storeR:set(label[2])
	end

--]]