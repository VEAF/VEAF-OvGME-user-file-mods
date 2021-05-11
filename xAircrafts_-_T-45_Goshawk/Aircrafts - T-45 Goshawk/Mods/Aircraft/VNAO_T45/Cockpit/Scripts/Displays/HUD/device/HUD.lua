dofile(LockOn_Options.script_path.."command_defs.lua")
local dev 	    = GetSelf()
local update_time_step = 0.03
make_default_activity(update_time_step)
local sensor_data = get_base_data()

--from EFM
local CCIP_v	= get_param_handle("CCIP_V")
local VelVecVert	= get_param_handle("VelVecVert")
local VelVecHorz	= get_param_handle("VelVecHorz")
----- outputs
local HUD_PWR		= get_param_handle("HUD_PWR")
local HUD_BRT		= get_param_handle("HUD_BRT")			
local approach		= get_param_handle("approach")
local VelVec_V		= get_param_handle("VELVEC_V")
local VelVec_H		= get_param_handle("VELVEC_H")
local VelVecGhost_V		= get_param_handle("VELVECGhost_V")
local VelVecGhost_H		= get_param_handle("VELVECGhost_H")
local VELVECCage		= get_param_handle("VELVECCage")
local ladder_pitch	= get_param_handle("LADDER_PITCH")
local CCIP_final	= get_param_handle("CCIP_FINAL")
local E_pos			= get_param_handle("E_POS")
local tacanCommandHeading = get_param_handle("TCN_CMDHDG") 
local waypointCommandHeading = get_param_handle("WYPT_CMDHDG") 
local velocityVectorFlash = get_param_handle("VV_FLASH")

----- input only---
local tacanBearing = get_param_handle("TACAN_BEARING") 
local SelWyptRange = get_param_handle("SELECTED_WAYPOINT_RANGE")
local SelWyptBearing = get_param_handle("SELECTED_WAYPOINT_BEARING")
local current_hdg = get_param_handle("CURRENT_HDG")
----------------------

local feet_per_meter = 3.28084
local feet_per_meter_per_minute = feet_per_meter * 60
local degrees_per_radian = 57.2957795
local ias_conversion_to_knots = 1.9504132  -- guess based on sea level TAS vs. IAS value

HUD_PWR:set(0)
HUD_BRT:set(1)
approach:set(0)


function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then --"GROUND_COLD","GROUND_HOT","AIR_HOT"
        dev:performClickableAction(device_commands.HUDPowerKnob,1,true) 
    elseif birth=="GROUND_COLD" then
        dev:performClickableAction(device_commands.HUDPowerKnob,0,true)
    end
	dev:performClickableAction(device_commands.HUDBrtKnob,1,true) 
end
powerKnob=0
brightness=1
--cageState = 0 -- 1: caged
dev:listen_command(device_commands.HUDPowerKnob)
dev:listen_command(device_commands.HUDBrtKnob)
dev:listen_command(Keys.cageButton)
function SetCommand(command,value)   
    if command == device_commands.HUDPowerKnob then      
		powerKnob = value
	elseif command == device_commands.HUDBrtKnob then
		brightness = value
	elseif command == Keys.cageButton then
		--cageState = 1 - cageState
		VELVECCage:set(1-VELVECCage:get())
    end
end


function updateVelVec()

	if VELVECCage:get() == 1 then
		VelVec_H:set( VelVecHorz:get() - VelVecHorz:get()*math.cos(roll) )
		VelVec_V:set( VelVecVert:get() - VelVecHorz:get()*math.sin(roll) )
	else
		VelVec_H:set(VelVecHorz:get())
		VelVec_V:set(VelVecVert:get()) 
		
		if VelVecHorz:get() > 0.122173 or VelVecHorz:get() < -0.122173 or VelVecVert:get() > 0.0523599 or VelVecVert:get() < -0.191986 then
		if VelVecHorz:get() > 0.122173  then -- VV limited to 7 degrees laterally
			VelVec_H:set(0.122173)
			velocityVectorFlash:set(flash())
		elseif VelVecHorz:get() < -0.122173  then--and cageState == 0
			VelVec_H:set(-0.122173)
			velocityVectorFlash:set(flash())
		elseif VelVecVert:get() > 0.0523599 then -- VV limited to +3 -11 degrees vertically
			VelVec_V:set(0.0523599)
			velocityVectorFlash:set(flash())
		elseif VelVecVert:get() < -0.191986 then
			VelVec_V:set(-0.191986)	
			velocityVectorFlash:set(flash())
		end
		else
		velocityVectorFlash:set(1)
		end
		
	end
	
	

	VelVecGhost_H:set(VelVecHorz:get())
	VelVecGhost_V:set(VelVecVert:get())
	local Vx, Vy, Vz = sensor_data.getSelfVelocity()--- DCS world axis: x is +fwd, y is +up, z is +right
	if sensor_data.getWOW_NoseLandingGear()>0 and Vx<1 and Vz<1 then -- stops jittering when stopped on ground
		VelVec_V:set(0) 
		VelVec_H:set(0)
		velocityVectorFlash:set(1)
	end
	
	--print_message_to_user(velocityVectorFlash:get())
end

function update()
roll = sensor_data.getRoll()
	HUD_PWR:set(powerKnob)	
	HUD_BRT:set(brightness)
	
	updateVelVec()
	E_pos:set(17-(sensor_data.getAngleOfAttack()*degrees_per_radian+10)) 
	
	ladder_pitch:set(sensor_data.getPitch() + VelVec_V:get()*math.cos(roll)- VelVec_H:get()*math.sin(roll)) -- allows the ladder to be be parented to velocity vector
	
	CCIP_final:set(CCIP_v:get() - VelVec_V:get()*math.cos(roll)+ VelVec_H:get()*math.sin(roll))
	
	local gear = get_aircraft_draw_argument_value(0)
	if gear==1 then
		approach:set(1)
	else
		approach:set(0)
	end
	
	local heading = current_hdg:get()-- magnetic not true --360-(sensor_data.getHeading()*degrees_per_radian)
	if heading<15 and tacanBearing:get()>345 then	-- used to fix wrap around issue with heading tape
		tacanCommandHeading:set(tacanBearing:get()-heading-360)
	elseif heading>345 and tacanBearing:get()<15 then
		tacanCommandHeading:set(tacanBearing:get()-heading+360)
	else
		tacanCommandHeading:set(tacanBearing:get()-heading)
	end
	
	local waypointBearing = SelWyptBearing:get()	
	if heading<15 and waypointBearing>345 then	-- used to fix wrap around issue with heading tape
		waypointCommandHeading:set(waypointBearing-heading-360)
	elseif heading>345 and tacanBearing:get()<15 then
		waypointCommandHeading:set(waypointBearing-heading+360)
	else
		waypointCommandHeading:set(waypointBearing-heading)
	end
	
	
--print_message_to_user(""..HUD_BRT:get())
end

local count = 0
local rate = 1/(update_time_step*6) -- 3 times a second
local flashOn = 1
function flash()
	count = count + 1
	if count >= rate and flashOn == 1 then
		flashOn = 0
		count = 0
	elseif count >= rate and flashOn == 0 then
		flashOn = 1
		count = 0
	end
	
	return flashOn
end

need_to_be_closed = false