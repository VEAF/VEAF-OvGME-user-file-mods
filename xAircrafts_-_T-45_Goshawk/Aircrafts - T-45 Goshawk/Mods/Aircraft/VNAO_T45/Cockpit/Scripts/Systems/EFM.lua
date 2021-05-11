dofile(LockOn_Options.script_path.."command_defs.lua")
-- helper file to control cockpit switches with keyboard presses and to initialize switches
-- note: performClickableAction doesn't seems to trigger the command so that must be done with dispatch_action()
local dev = GetSelf()
local update_time_step = 0.1
make_default_activity(update_time_step) -- enables call to update
local sensor_data = get_base_data()

local gts = get_param_handle("GTS_RPM")
local previousGts = 0
local GtsOn = false
local ESbus = get_param_handle("ESS_SERV_BUS")
local genBus = get_param_handle("GEN_BUS")

dev:listen_command(Keys.HookToggle)
dev:listen_command(Keys.GearLever)
dev:listen_command(Keys.LaunchBarToggle)
dev:listen_command(Keys.Finger_Lift)
dev:listen_command(Keys.canopy)
dev:listen_command(Keys.FlapStepUp)
dev:listen_command(Keys.FlapStepDown)
dev:listen_command(Keys.Battery1Toggle)
dev:listen_command(Keys.Battery2Toggle)


function post_initialize()   
	sndhost = create_sound_host("APU_sound","3D",0,0,0)
    GTSstartSound = sndhost:create_sound("T45GTSstart")
	GTSrunSound = sndhost:create_sound("T45GTSrunning")
	GTSshutdownSound = sndhost:create_sound("T45GTSend")
	
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="AIR_HOT" then
        dev:performClickableAction(EFM_commands.GearLever,0,true)
		dev:performClickableAction(EFM_commands.EngineSwitch, 0.5,true)
		dev:performClickableAction(EFM_commands.BatterySwitch1, 1,true)
		dev:performClickableAction(EFM_commands.BatterySwitch2, 1,true)
		dev:performClickableAction(EFM_commands.GeneratorSwitch, 0.5,true)		
		dev:performClickableAction(EFM_commands.SeatArmHandle,1,true)
		
    elseif birth=="GROUND_HOT" then
        dev:performClickableAction(EFM_commands.GearLever,1,true)
		dispatch_action(nil,EFM_commands.GearLever,1)
		dev:performClickableAction(EFM_commands.EngineSwitch, 0.5,true)
		dev:performClickableAction(EFM_commands.BatterySwitch1, 1,true)
		dev:performClickableAction(EFM_commands.BatterySwitch2, 1,true)
		dev:performClickableAction(EFM_commands.GeneratorSwitch, 0.5,true)
		dev:performClickableAction(EFM_commands.SeatArmHandle,1,true)
		
	elseif birth=="GROUND_COLD" then
		dev:performClickableAction(EFM_commands.GearLever,1,true)
		dispatch_action(nil,EFM_commands.GearLever,1)
		dev:performClickableAction(EFM_commands.EngineSwitch, 0,true)
		dev:performClickableAction(EFM_commands.BatterySwitch1, 0,true)
		dev:performClickableAction(EFM_commands.BatterySwitch2, 0,true)
		dev:performClickableAction(EFM_commands.GeneratorSwitch, 0,true)
		dev:performClickableAction(EFM_commands.CanopyLever, 1,true)
		dev:performClickableAction(EFM_commands.SeatArmHandle,0,true)
		
    end
	dev:performClickableAction(EFM_commands.EmerFlapSwitch, 1,true)
end


function SetCommand(command,value)
	if command == Keys.HookToggle then
		Hook_handle_pos = get_cockpit_draw_argument_value(8)
		dev:performClickableAction(EFM_commands.HookLever,1-Hook_handle_pos,true)
		dispatch_action(nil,EFM_commands.HookLever,1-Hook_handle_pos)
	elseif command == Keys.GearLever then
		gear_handle_pos = get_cockpit_draw_argument_value(6)
		dev:performClickableAction(EFM_commands.GearLever,1-gear_handle_pos,true)
		dispatch_action(nil,EFM_commands.GearLever,1-gear_handle_pos)
	elseif command == Keys.LaunchBarToggle then
		LB_switch_pos = get_cockpit_draw_argument_value(67)
		dev:performClickableAction(EFM_commands.LaunchBarSwitch,1-LB_switch_pos,true)
		dispatch_action(nil,EFM_commands.LaunchBarSwitch,1-LB_switch_pos)
		
	elseif command == Keys.Finger_Lift then
		dev:performClickableAction(EFM_commands.fingerLift,0,true)
		dispatch_action(nil,EFM_commands.fingerLift,0)
	elseif command == Keys.canopy then
		canopyLever_pos = get_cockpit_draw_argument_value(116)
		dev:performClickableAction(EFM_commands.CanopyLever,1-canopyLever_pos,true)
		dispatch_action(nil,EFM_commands.CanopyLever,1-canopyLever_pos)
		
	elseif command == Keys.FlapStepDown then
		flapSw_pos = get_cockpit_draw_argument_value(7)
		if flapSw_pos < 1.0 then
			dev:performClickableAction(EFM_commands.FlapSwitch, flapSw_pos + 0.5,true)
			dispatch_action(nil,EFM_commands.FlapSwitch, flapSw_pos + 0.5)
		end
	elseif command == Keys.FlapStepUp then
		flapSw_pos = get_cockpit_draw_argument_value(7)
		if flapSw_pos > 0.0 then
			dev:performClickableAction(EFM_commands.FlapSwitch, flapSw_pos - 0.5,true)
			dispatch_action(nil,EFM_commands.FlapSwitch, flapSw_pos - 0.5)
		end
		
	elseif command == Keys.Battery1Toggle then
	print_message_to_user("click")
		bat1SwPos = get_cockpit_draw_argument_value(300)
		dev:performClickableAction(EFM_commands.BatterySwitch1,1-bat1SwPos,true)
		dispatch_action(nil,EFM_commands.BatterySwitch1,1-bat1SwPos)
	elseif command == Keys.Battery2Toggle then
	print_message_to_user("click 2")
		bat2SwPos = get_cockpit_draw_argument_value(301)
		dev:performClickableAction(EFM_commands.BatterySwitch2,1-bat2SwPos,true)
		dispatch_action(nil,EFM_commands.BatterySwitch2,1-bat2SwPos)
		
	end
end

function update()
 --local canopy_clickable_ref = get_clickable_element_reference("PNT_001")
 --      canopy_clickable_ref:update()
			
nosePos = get_aircraft_draw_argument_value(0)
gear_handle_pos = get_cockpit_draw_argument_value(6)
--print_message_to_user(nosePos)
if gear_handle_pos ~= nosePos then
---print_message_to_user("not equal")
end
	if gts:get()>0 and previousGts==0 then
		GTSstartSound:play_once()
		GtsOn = true
	elseif gts:get()<previousGts and previousGts==100 then
		GTSshutdownSound:play_once()
		GTSrunSound:stop()
		GtsOn = false
	elseif gts:get()>=65 and GtsOn == true then
		GTSrunSound:play_continue()
		GTSstartSound:stop()
	end
	previousGts=gts:get()
	
	local noseWOW = sensor_data.getWOW_NoseLandingGear()
	if noseWOW == 0 then -- the LB is magnetically held to extend only when there is Weight on Wheels
		dev:performClickableAction(EFM_commands.LaunchBarSwitch, 0,true)
		dispatch_action(nil,EFM_commands.LaunchBarSwitch,0)
	end
	-- print_message_to_user(ESbus:get()..", "..genBus:get())
	
end

need_to_be_closed = false -- close lua state after initialization
