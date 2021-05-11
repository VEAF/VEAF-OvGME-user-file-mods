local cscripts = folder.."../../Cockpit/Scripts/"
dofile(cscripts.."devices.lua")
dofile(cscripts.."command_defs.lua")


-- from: common_joystick_binding.lua


local kneeboard_id = 100
if devices and devices.KNEEBOARD then
   kneeboard_id = devices.KNEEBOARD
end

return {
    forceFeedback = {
    trimmer = 1.0,
    shake = 0.5,
    swapAxes = false,
    invertX = false,
    invertY = false,
},

keyCommands = {


-- Weapons
{down = Keys.PlaneFireOn,	up = Keys.PlaneFireOff,		name = _('Guns Fire'),			category = _('Weapons')},
{down = Keys.PickleOn,	up = Keys.PickleOff,		name = _('Weapons Release'),	category = _('Weapons')},
{down = Keys.MasterArmToggle,							name = _('Master Arm Toggle'),			category = _('Weapons')},
{down = device_commands.emergencyJettison, up = device_commands.emergencyJettison, cockpit_device_id = devices.WEAPON_SYSTEM,  value_down =  1.0, value_up =  0.0, name = _('Jettison Weapons'), 	category = _('Weapons')},
{down = device_commands.masterArm, cockpit_device_id = devices.WEAPON_SYSTEM,			value_down =  1.0,	name = _('Master Arm Switch - ARM'),							category = _('Weapons')},
{down = device_commands.masterArm, cockpit_device_id = devices.WEAPON_SYSTEM,			value_down =  0.0,	name = _('Master Arm Switch - SAFE'),							category = _('Weapons')},

--{down = Keys.SmokeOnOff,  name = _('Smoke'), category = _('Weapons')},

-- Systems
{down = Keys.Battery1Toggle, name = _('Battery 1 Switch - ON/OFF'), category = _('Systems')},
{down = EFM_commands.BatterySwitch1, cockpit_device_id = devices.EFM,	value_down =  1.0,		name = _('Battery 1 Switch - ON'),	category = _('Systems')},
{down = EFM_commands.BatterySwitch1, cockpit_device_id = devices.EFM,	value_down =  0.0,		name = _('Battery 1 Switch - OFF'),	category = _('Systems')},
{down = Keys.Battery2Toggle, name = _('Battery 2 Switch - ON/OFF'), category = _('Systems')},
{down = EFM_commands.BatterySwitch2, cockpit_device_id = devices.EFM,	value_down =  1.0,		name = _('Battery 2 Switch - ON'),	category = _('Systems')},
{down = EFM_commands.BatterySwitch2, cockpit_device_id = devices.EFM,	value_down =  0.0,		name = _('Battery 2 Switch - OFF'),	category = _('Systems')},
{down = EFM_commands.GeneratorSwitch, cockpit_device_id = devices.EFM,	value_down =  0.5,		name = _('Generator Switch - ON'),	category = _('Systems')},
{down = EFM_commands.GeneratorSwitch, cockpit_device_id = devices.EFM,	value_down =  0.0,		name = _('Generator Switch - OFF'),	category = _('Systems')},

{down = Keys.cageButton,						name = _('Cage/Uncage Button'),					category = _('Systems')},
{down = EFM_commands.FlapSwitch, cockpit_device_id = devices.EFM,			value_down =  0.0,	name = _('Flap Switch UP'),							category = _('Systems')},
{down = EFM_commands.FlapSwitch, cockpit_device_id = devices.EFM,			value_down =  0.5,	name = _('Flap Switch HALF'),							category = _('Systems')},
{down = EFM_commands.FlapSwitch, cockpit_device_id = devices.EFM,			value_down =  1.0,	name = _('Flap Switch DOWN'),							category = _('Systems')},
{down = Keys.FlapStepDown,						name = _('Flap Increment Down'),				category = _('Systems')},
{down = Keys.FlapStepUp,							name = _('Flap Increment Up'),					category = _('Systems')},
{down = EFM_commands.FlapSwitch, up = EFM_commands.FlapSwitch,cockpit_device_id = devices.EFM, value_down =  0.0, value_up =  0.5, name = _('Flap Switch UP else HALF'), category = _('Systems')},
{down = EFM_commands.FlapSwitch, up = EFM_commands.FlapSwitch,cockpit_device_id = devices.EFM, value_down =  1.0, value_up =  0.5, name = _('Flap Switch DOWN else HALF'), category = _('Systems')},

-- Gear
{down = Keys.GearLever,																			name = _('Landing Gear - UP/DOWN'),			category = {_('Landing Gear'), _('Systems')}},
{down = EFM_commands.GearLever, cockpit_device_id = devices.EFM,			value_down =  1.0,	name = _('Landing Gear - DOWN'),			category = {_('Landing Gear'), _('Systems')}},
{down = EFM_commands.GearLever, cockpit_device_id = devices.EFM,			value_down =  0.0,	name = _('Landing Gear - UP'),				category = {_('Landing Gear'), _('Systems')}},
{down = EFM_commands.AntiSkidSwitch, cockpit_device_id = devices.EFM,	value_down =  1.0,		name = _('Anti-Skid Switch - ON'),			category = {_('Landing Gear'), _('Systems')}},
{down = EFM_commands.AntiSkidSwitch, cockpit_device_id = devices.EFM,	value_down =  0.0,		name = _('Anti-Skid Switch - OFF'),			category = {_('Landing Gear'), _('Systems')}},
{down = iCommandPlaneWheelBrakeOn, up = iCommandPlaneWheelBrakeOff, 							name = _('Wheel Brake On'),					category = {_('Landing Gear'), _('Systems')}},
{down = EFM_commands.NWSButton, up = EFM_commands.NWSButton, 	value_down =  1.0, value_up =  0.0, name = _('Nose Wheel Steering Button'),	category = {_('Landing Gear'), _('Systems')}},
{down = EFM_commands.parkBrake, cockpit_device_id = devices.EFM,	value_down =  1.0,		name = _('Parking Brake - ON'),			category = {_('Landing Gear'), _('Systems')}},
{down = EFM_commands.parkBrake, cockpit_device_id = devices.EFM,	value_down =  0.0,		name = _('Parking Brake - OFF'),		category = {_('Landing Gear'), _('Systems')}},

{down = Keys.canopy,		name = _('Canopy - OPEN/CLOSE'),						category = _('Systems')},
{down = EFM_commands.CanopyLever, cockpit_device_id = devices.EFM,	value_down =  1.0,		name = _('Canopy - OPEN'),			category = _('Systems')},
{down = EFM_commands.CanopyLever, cockpit_device_id = devices.EFM,	value_down =  0.0,		name = _('Canopy - CLOSE'),			category = _('Systems')},

{down = EFM_commands.Eject,		name = _('Eject (3 times)'),						category = _('Systems')},
{down = EFM_commands.EngineSwitch, cockpit_device_id = devices.EFM, value_down =  0.0, name = _('Engine Switch OFF'), category = _('Systems')},
{down = EFM_commands.EngineSwitch, cockpit_device_id = devices.EFM, value_down =  0.5, name = _('Engine Switch ON'),	category = _('Systems')},
{down = EFM_commands.EngineSwitch, up = EFM_commands.EngineSwitch, cockpit_device_id = devices.EFM, value_down =  1.0, value_up =  0.5, name = _('Engine Switch START'), category = _('Systems')},

{down = EFM_commands.HYD2reset, up = EFM_commands.HYD2reset,  cockpit_device_id = devices.EFM,  value_down = 1.0,   value_up=0.0, name = ('HYD 2 Reset Button'), category = ('Systems')},


-- Controls ---
{pressed = iCommandPlaneTrimUp,			up = iCommandPlaneTrimStop, name = _('Trim: Nose Up'),			category = _('Flight Control')},
{pressed = iCommandPlaneTrimDown,		up = iCommandPlaneTrimStop, name = _('Trim: Nose Down'),		category = _('Flight Control')},
{pressed = iCommandPlaneTrimLeft,		up = iCommandPlaneTrimStop, name = _('Trim: Left Wing Down'),	category = _('Flight Control')},
{pressed = iCommandPlaneTrimRight,		up = iCommandPlaneTrimStop, name = _('Trim: Right Wing Down'),	category = _('Flight Control')},
--{	pressed = iCommandPlaneTrimLeftRudder,	up = iCommandPlaneTrimStop, name = _('Trim: Rudder Left'),		category = _('Flight Control')},
--{	pressed = iCommandPlaneTrimRightRudder,	up = iCommandPlaneTrimStop, name = _('Trim: Rudder Right'),		category = _('Flight Control')},
{pressed = EFM_commands.KeyRudderLeft,		up = EFM_commands.KeyRudderStop, name = _('Aircraft Yaw Left'),	category = _('Flight Control')},
{pressed = EFM_commands.KeyRudderRight,		up = EFM_commands.KeyRudderStop, name = _('Aircraft Yaw Right'),	category = _('Flight Control')},

{pressed = EFM_commands.ThrottleIncrease,				name = _('Throttle Smoothly - Increase'),		category = {_('Throttle Grip'), _('Flight Control')}},
{pressed = EFM_commands.ThrottleDecrease,				name = _('Throttle Smoothly - Decrease'),		category = {_('Throttle Grip'), _('Flight Control')}},

--- Throttle
{down = EFM_commands.GTSbutton,	up = EFM_commands.GTSbutton, cockpit_device_id = devices.EFM,  value_down = 1.0,	value_up =  0.0,	name = _('Gas Turbine Starter Button'),					category = _('Throttle Grip')},
{down = Keys.Finger_Lift,					name = _('Throttle Finger Lift'),							category = _('Throttle Grip')},
{down = EFM_commands.SpeedBrakeSwitch,	up = EFM_commands.SpeedBrakeSwitch,	value_down =  1.0, value_up =  0.0,	name = _('Speed Brake Switch AFT'),		category = _('Throttle Grip')},
{down = EFM_commands.SpeedBrakeSwitch,	value_down =  0.0,														name = _('Speed Brake Switch CENTER'),	category = _('Throttle Grip')},
{down = EFM_commands.SpeedBrakeSwitch,	value_down =  -1.0,														name = _('Speed Brake Switch FORWARD'),	category = _('Throttle Grip')},

{down = device_commands.throttleMicSwitch, up = device_commands.throttleMicSwitch,	 cockpit_device_id = devices.COMM1,	value_down =  1, value_up =  0.0, name = _('Microphone Switch COMM 1'),	category = _('Throttle Grip')},
{down = device_commands.throttleMicSwitch, up = device_commands.throttleMicSwitch, 	cockpit_device_id = devices.COMM1,	value_down =  -1, value_up =  0.0, name = _('Microphone Switch COMM 2'),	category = _('Throttle Grip')},
{down = Keys.IntercomPTT, up = Keys.IntercomPTT,	value_down =  1, value_up =  0.0, name = _('Microphone Switch Intercom'), category = _('Throttle Grip')},

{down = EFM_commands.lightsMaster,	up = EFM_commands.lightsMaster,	 cockpit_device_id = devices.EFM, value_down =  -1.0, value_up =  0.0,	name = _('Exterior Lights Master Switch AFT'), category = _('Throttle Grip')},
{down = EFM_commands.lightsMaster,	value_down =  0.0,	 cockpit_device_id = devices.EFM,													name = _('Exterior Lights Master CENTER'),	category = _('Throttle Grip')},
{down = EFM_commands.lightsMaster,	value_down =  1.0,	 cockpit_device_id = devices.EFM,													name = _('Exterior Lights Master FORWARD'),	category = _('Throttle Grip')},

--- Carrier
{down = iCommandPlaneShipTakeOff,	name = _('Catapult Hook Up'),			category = _('Carrier')},
{down = Keys.LaunchBarToggle,		name = _('Launch Bar - EXTEND/RETRACT'),	category = _('Carrier')},
{down = EFM_commands.LaunchBarSwitch,	value_down =  1.0,	 cockpit_device_id = devices.EFM,			name = _('Launch Bar - EXTEND'),	category = _('Carrier')},
{down = EFM_commands.LaunchBarSwitch,	value_down =  0.0,	 cockpit_device_id = devices.EFM,			name = _('Launch Bar - RETRACT'),	category = _('Carrier')},
{down = Keys.HookToggle,			name = _('Tail Hook - EXTEND/RETRACT'),					category = _('Carrier')},
{down = EFM_commands.HookLever,	value_down =  1.0,	 cockpit_device_id = devices.EFM,			name = _('Tail Hook - EXTEND'),	category = _('Carrier')},
{down = EFM_commands.HookLever,	value_down =  0.0,	 cockpit_device_id = devices.EFM,			name = _('Tail Hook - RETRACT'),	category = _('Carrier')},
{down = iCommandPilotGestureSalute,	name = _('Pilot Salute'),				category = _('Carrier')},
---- Multicrew ------
{down = iCommandViewCockpitChangeSeat, value_down = 1, name = _('Occupy Front Seat'),	category = _('Multicrew')},
{down = iCommandViewCockpitChangeSeat, value_down = 2, name = _('Occupy Rear Seat'),	category = _('Multicrew')},
{down = iCommandNetCrewRequestControl,				name = _('Request Aircraft Control'),category = _('Multicrew')},

-- HUD
{down = device_commands.HUDPowerKnob,	cockpit_device_id = devices.HUD,	value_down =  1.0,					name = _('HUD Power Knob - ON'),	category = {_('Data Entry Panel'), _('HUD')}},
{down = device_commands.HUDPowerKnob,	cockpit_device_id = devices.HUD,	value_down =  0.0,					name = _('HUD Power Knob - OFF'),	category = {_('Data Entry Panel'), _('HUD')}},

-- Data Entry Panel
{down = device_commands.DEP0, up = device_commands.DEP0,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP 0'), category = ('Data Entry Panel')},
{down = device_commands.DEP1, up = device_commands.DEP1,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP 1'), category = ('Data Entry Panel')},
{down = device_commands.DEP2, up = device_commands.DEP2,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP 2'), category = ('Data Entry Panel')},
{down = device_commands.DEP3, up = device_commands.DEP3,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP 3'), category = ('Data Entry Panel')},
{down = device_commands.DEP4, up = device_commands.DEP4,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP 4'), category = ('Data Entry Panel')},
{down = device_commands.DEP5, up = device_commands.DEP5,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP 5'), category = ('Data Entry Panel')},
{down = device_commands.DEP6, up = device_commands.DEP6,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP 6'), category = ('Data Entry Panel')},
{down = device_commands.DEP7, up = device_commands.DEP7,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP 7'), category = ('Data Entry Panel')},
{down = device_commands.DEP8, up = device_commands.DEP8,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP 8'), category = ('Data Entry Panel')},
{down = device_commands.DEP9, up = device_commands.DEP9,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP 9'), category = ('Data Entry Panel')},
{down = device_commands.DEPenter, up = device_commands.DEPenter,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP Enter'), category = ('Data Entry Panel')},
{down = device_commands.DEPclear, up = device_commands.DEPclear,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP Clear'), category = ('Data Entry Panel')},
{down = device_commands.DEPdeclutter, up = device_commands.DEPdeclutter,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP Declutter'), category = ('Data Entry Panel')},
{down = device_commands.DEPlaw, up = device_commands.DEPlaw,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP LAW'), category = ('Data Entry Panel')},
{down = device_commands.DEPcrs, up = device_commands.DEPcrs,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP CRS'), category = ('Data Entry Panel')},
{down = device_commands.DEPhdg, up = device_commands.DEPhdg,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP HDG'), category = ('Data Entry Panel')},
{down = device_commands.DEPbingo, up = device_commands.DEPbingo,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP Bingo'), category = ('Data Entry Panel')},
{down = device_commands.DEPmode, up = device_commands.DEPmode,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP Mode'), category = ('Data Entry Panel')},
{down = device_commands.DEPdepressionUp, up = device_commands.DEPdepressionUp,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP Depression Increase'), category = ('Data Entry Panel')},
{down = device_commands.DEPdepressionDown, up = device_commands.DEPdepressionDown,  cockpit_device_id = devices.DEP,  value_down = 1.0,   value_up=0.0, name = ('DEP Depression Decrease'), category = ('Data Entry Panel')},

-- MFD LEFT
{down = MFDL_commands.PB1, up = MFDL_commands.PB1,  cockpit_device_id = devices.MFDL,  value_down = 1.0,   value_up=0.0, name = ('Left MFD PB 1'), category = ('Left MFD')},
{down = MFDL_commands.PB2, up = MFDL_commands.PB2,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 2'), category = ('Left MFD')},
{down = MFDL_commands.PB3, up = MFDL_commands.PB3,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 3'), category = ('Left MFD')},
{down = MFDL_commands.PB4, up = MFDL_commands.PB4,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 4'), category = ('Left MFD')},
{down = MFDL_commands.PB5, up = MFDL_commands.PB5,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 5'), category = ('Left MFD')},
{down = MFDL_commands.PB6, up = MFDL_commands.PB6,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 6'), category = ('Left MFD')},
{down = MFDL_commands.PB7, up = MFDL_commands.PB7,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 7'), category = ('Left MFD')},
{down = MFDL_commands.PB8, up = MFDL_commands.PB8,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 8'), category = ('Left MFD')},
{down = MFDL_commands.PB9, up = MFDL_commands.PB9,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 9'), category = ('Left MFD')},
{down = MFDL_commands.PB10, up = MFDL_commands.PB10,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 10'), category = ('Left MFD')},
{down = MFDL_commands.PB11, up = MFDL_commands.PB11,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 11'), category = ('Left MFD')},
{down = MFDL_commands.PB12, up = MFDL_commands.PB12,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 12'), category = ('Left MFD')},
{down = MFDL_commands.PB13, up = MFDL_commands.PB13,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 13'), category = ('Left MFD')},
{down = MFDL_commands.PB14, up = MFDL_commands.PB14,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 14'), category = ('Left MFD')},
{down = MFDL_commands.PB15, up = MFDL_commands.PB15,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 15'), category = ('Left MFD')},
{down = MFDL_commands.PB16, up = MFDL_commands.PB16,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 16'), category = ('Left MFD')},
{down = MFDL_commands.PB17, up = MFDL_commands.PB17,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 17'), category = ('Left MFD')},
{down = MFDL_commands.PB18, up = MFDL_commands.PB18,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 18'), category = ('Left MFD')},
{down = MFDL_commands.PB19, up = MFDL_commands.PB19,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 19'), category = ('Left MFD')},
{down = MFDL_commands.PB20, up = MFDL_commands.PB20,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD PB 20'), category = ('Left MFD')},
{down = MFDL_commands.dayPower, up = MFDL_commands.dayPower,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD Day Power'), category = ('Left MFD')},
{down = MFDL_commands.nightPower, up = MFDL_commands.nightPower,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD Night Power'), category = ('Left MFD')},
{down = MFDL_commands.offSwitch, up = MFDL_commands.offSwitch,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD Off Switch'), category = ('Left MFD')},
{down = MFDL_commands.brightnessUp, up = MFDL_commands.brightnessUp,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD Brightness Up'), category = ('Left MFD')},
{down = MFDL_commands.brightnessDown, up = MFDL_commands.brightnessDown,  cockpit_device_id = devices.MFDL,  value_down =  1.0,  value_up=0.0,  name = ('Left MFD Brightness Down'), category = ('Left MFD')},


-- MFD RIGHT
{down = MFDR_commands.PB1, up=MFDR_commands.PB1,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 1'), category = ('Right MFD')},
{down = MFDR_commands.PB2, up=MFDR_commands.PB2,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 2'), category = ('Right MFD')},
{down = MFDR_commands.PB3, up=MFDR_commands.PB3,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 3'), category = ('Right MFD')},
{down = MFDR_commands.PB4, up=MFDR_commands.PB4,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 4'), category = ('Right MFD')},
{down = MFDR_commands.PB5, up=MFDR_commands.PB5,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 5'), category = ('Right MFD')},
{down = MFDR_commands.PB6, up=MFDR_commands.PB6,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 6'), category = ('Right MFD')},
{down = MFDR_commands.PB7, up=MFDR_commands.PB7,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 7'), category = ('Right MFD')},
{down = MFDR_commands.PB8, up=MFDR_commands.PB8,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 8'), category = ('Right MFD')},
{down = MFDR_commands.PB9, up=MFDR_commands.PB9,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 9'), category = ('Right MFD')},
{down = MFDR_commands.PB10, up=MFDR_commands.PB10,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 10'), category = ('Right MFD')},
{down = MFDR_commands.PB11, up=MFDR_commands.PB11,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 11'), category = ('Right MFD')},
{down = MFDR_commands.PB12, up=MFDR_commands.PB12,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 12'), category = ('Right MFD')},
{down = MFDR_commands.PB13, up=MFDR_commands.PB13,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 13'), category = ('Right MFD')},
{down = MFDR_commands.PB14, up=MFDR_commands.PB14,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 14'), category = ('Right MFD')},
{down = MFDR_commands.PB15, up=MFDR_commands.PB15,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 15'), category = ('Right MFD')},
{down = MFDR_commands.PB16, up=MFDR_commands.PB16,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 16'), category = ('Right MFD')},
{down = MFDR_commands.PB17, up=MFDR_commands.PB17,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 17'), category = ('Right MFD')},
{down = MFDR_commands.PB18, up=MFDR_commands.PB18,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 18'), category = ('Right MFD')},
{down = MFDR_commands.PB19, up=MFDR_commands.PB19,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 19'), category = ('Right MFD')},
{down = MFDR_commands.PB20, up=MFDR_commands.PB20,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD PB 20'), category = ('Right MFD')},
{down = MFDR_commands.dayPower, up=MFDR_commands.dayPower,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD Day Power'), category = ('Right MFD')},
{down = MFDR_commands.nightPower, up=MFDR_commands.nightPower,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD Night Power'), category = ('Right MFD')},
{down = MFDR_commands.offSwitch, up=MFDR_commands.offSwitch,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD Off Switch'), category = ('Right MFD')},
{down = MFDR_commands.brightnessUp, up=MFDR_commands.brightnessUp,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD Brightness Up'), category = ('Right MFD')},
{down = MFDR_commands.brightnessDown, up=MFDR_commands.brightnessDown,  cockpit_device_id = devices.MFDR,  value_down =  1.0,  value_up=0.0,  name = ('Right MFD Brightness Down'), category = ('Right MFD')},

----------------------------------------- From common keyboard bindings lua ----------------------------------------------------------------------------------------------------
-- Debug
{	down = ICommandToggleConsole,	name = _('Toggle Console'),		category = _('Debug')},
{	down = iCommandMissionRestart,	name = _('Restart Mission'),	category = _('Debug')},

-- General (Gameplay)
{down = iCommandQuit,							name = _('End mission'),							category = _('General')},
{down = iCommandBrakeGo,							name = _('Pause'),									category = _('General')},
{down = iCommandAccelerate,						name = _('Time accelerate'),						category = _('General')},
{down = iCommandDecelerate,						name = _('Time decelerate'),						category = _('General')},
{down = iCommandNoAcceleration,					name = _('Time normal'),							category = _('General')},
{down = iCommandScoresWindowToggle,				name = _('Score window'),							category = _('General')},

{down = iCommandInfoOnOff,						name = _('Info bar view toggle'),					category = _('General')},
{down = iCommandRecoverHuman,					name = _('Get new plane - respawn'),				category = _('General')},
{down = iCommandPlaneJump,						name = _('Jump into selected aircraft'),			category = _('General')},
{down = iCommandScreenShot,						name = _('Screenshot'),								category = _('General'), disabled = true},
{down = iCommandGraphicsFrameRate,				name = _('Frame rate counter - Service info'),		category = _('General')},
{down = iCommandViewCoordinatesInLinearUnits,	name = _('Info bar coordinate units toggle'),		category = _('General')},
{down = iCommandCockpitClickModeOnOff,			name = _('Clickable mouse cockpit mode On/Off'),	category = _('General')},
{down = iCommandSoundOnOff,						name = _('Sound On/Off'),							category = _('General')},
{down = iCommandMissionResourcesManagement,		name = _('Rearming and Refueling Window'),			category = _('General')},
{down = iCommandViewBriefing,					name = _('View briefing on/off'),					category = _('General')},
{down = iCommandActivePauseOnOff,				name = _('Active Pause'),							category = _('Cheat')},
{down = iCommandPlane_ShowControls,				name = _('Show controls indicator'),				category = _('General')},

-- Communications
{	down = iCommandPlaneFormation,					name = _('Toggle Formation'),						category = _('Communications')},
{	down = iCommandPlaneJoinUp,						name = _('Join Up Formation'),						category = _('Communications')},
{	down = iCommandToggleCommandMenu,				name = _('Communication menu'),						category = _('Communications')},
{	down = ICommandSwitchDialog,					name = _('Switch dialog'),							category = _('Communications')},
{	down = ICommandSwitchToCommonDialog,			name = _('Switch to main menu'),					category = _('Communications')},
{	down = iCommandToggleReceiveMode,	name = _('Receive Mode'),					category = _('Communications')},



-- View
{pressed = iCommandViewLeftSlow,			up = iCommandViewStopSlow,				name = _('View Left slow'),										category = _('View')},
{pressed = iCommandViewRightSlow,		up = iCommandViewStopSlow,				name = _('View Right slow'),									category = _('View')},
{pressed = iCommandViewUpSlow,			up = iCommandViewStopSlow,				name = _('View Up slow'),										category = _('View')},
{pressed = iCommandViewDownSlow,			up = iCommandViewStopSlow,				name = _('View Down slow'),										category = _('View')},
{pressed = iCommandViewUpRightSlow,		up = iCommandViewStopSlow,				name = _('View Up Right slow'),									category = _('View')},
{pressed = iCommandViewDownRightSlow,	up = iCommandViewStopSlow,				name = _('View Down Right slow'),								category = _('View')},
{pressed = iCommandViewDownLeftSlow,		up = iCommandViewStopSlow,				name = _('View Down Left slow'),								category = _('View')},
{pressed = iCommandViewUpLeftSlow,		up = iCommandViewStopSlow,				name = _('View Up Left slow'),									category = _('View')},
{pressed = iCommandViewCenter,													name = _('View Center'),										category = _('View')},

{pressed = iCommandViewForwardSlow,		up = iCommandViewForwardSlowStop,		name = _('Zoom in slow'),										category = _('View')},
{pressed = iCommandViewBackSlow,			up = iCommandViewBackSlowStop,			name = _('Zoom out slow'),										category = _('View')},
{down = iCommandViewAngleDefault,												name = _('Zoom normal'),										category = _('View')},
{pressed = iCommandViewExternalZoomIn,	up = iCommandViewExternalZoomInStop,	name = _('Zoom external in'),									category = _('View')},
{pressed = iCommandViewExternalZoomOut,	up = iCommandViewExternalZoomOutStop,	name = _('Zoom external out'),									category = _('View')},
{down = iCommandViewExternalZoomDefault,											name = _('Zoom external normal'),								category = _('View')},
{down = iCommandViewSpeedUp,														name = _('F11 Camera moving forward'),							category = _('View')},
{down = iCommandViewSlowDown,													name = _('F11 Camera moving backward'),							category = _('View')},

{	down = iCommandViewCockpit,														name = _('F1 Cockpit view'),									category = _('View')},
{	down = iCommandNaturalViewCockpitIn,											name = _('F1 Natural head movement view'),						category = _('View')},
{	down = iCommandViewHUDOnlyOnOff,												name = _('F1 HUD only view switch'),							category = _('View')},
{	down = iCommandViewAir,															name = _('F2 Aircraft view'),									category = _('View')},
{	down = iCommandViewMe,															name = _('F2 View own aircraft'),								category = _('View')},
{		down = iCommandViewFromTo,														name = _('F2 Toggle camera position'),							category = _('View')},
{		down = iCommandViewLocal,														name = _('F2 Toggle local camera control'),						category = _('View')},
{								down = iCommandViewTower,														name = _('F3 Fly-By view'),										category = _('View')},
{		down = iCommandViewTowerJump,													name = _('F3 Fly-By jump view'),								category = _('View')},
{								down = iCommandViewRear,														name = _('F4 Look back view'),									category = _('View')},
{		down = iCommandViewChase,														name = _('F4 Chase view'),										category = _('View')},
{	down = iCommandViewChaseArcade,													name = _('F4 Arcade Chase view'),								category = _('View')},
{							down = iCommandViewFight,														name = _('F5 nearest AC view'),									category = _('View')},
{	down = iCommandViewFightGround,													name = _('F5 Ground hostile view'),								category = _('View')},
{								down = iCommandViewWeapons,														name = _('F6 Released weapon view'),							category = _('View')},
{	down = iCommandViewWeaponAndTarget,												name = _('F6 Weapon to target view'),							category = _('View')},
{								down = iCommandViewGround,														name = _('F7 Ground unit view'),								category = _('View')},
{								down = iCommandViewTargets,														name = _('F8 Target view'),										category = _('View')},
{		down = iCommandViewTargetType,													name = _('F8 Player targets/All targets filter'),				category = _('View')},
{								down = iCommandViewNavy,														name = _('F9 Ship view'),										category = _('View')},
{			down = iCommandViewLndgOfficer,													name = _('F9 Landing signal officer view'),						category = _('View')},
{							down = iCommandViewAWACS,														name = _('F10 Theater map view'),								category = _('View')},
{		down = iCommandViewAWACSJump,													name = _('F10 Jump to theater map view over current point'),	category = _('View')},
{								down = iCommandViewFree,														name = _('F11 Airport free camera'),							category = _('View')},
{		down = iCommandViewFreeJump,													name = _('F11 Jump to free camera'),							category = _('View')},
{							down = iCommandViewStatic,														name = _('F12 Static object view'),								category = _('View')},
{		down = iCommandViewMirage,														name = _('F12 Civil traffic view'),								category = _('View')},
{	down = iCommandViewLocomotivesToggle,											name = _('F12 Trains/cars toggle'),								category = _('View')},
{		down = iCommandViewPitHeadOnOff,												name = _('F1 Head shift movement on / off'),					category = _('View')},

{		down = iCommandViewFastKeyboard,												name = _('Keyboard Rate Fast'),									category = _('View')},
{			down = iCommandViewSlowKeyboard,												name = _('Keyboard Rate Slow'),									category = _('View')},
{			down = iCommandViewNormalKeyboard,												name = _('Keyboard Rate Normal'),								category = _('View')},
{		down = iCommandViewFastMouse,													name = _('Mouse Rate Fast'),									category = _('View')},
{		down = iCommandViewSlowMouse,													name = _('Mouse Rate Slow'),									category = _('View')},
{			down = iCommandViewNormalMouse,													name = _('Mouse Rate Normal'),									category = _('View')},
{	down = iCommandflushTaxiData,												name = _('Flush taxi data'),									category = _('View')},

-- Cockpit view
{			down = 3256,	cockpit_device_id = 0,	value_down = 1.0,						name = _('Flashlight'),						category = _('View Cockpit')},

{		down = iCommandViewTempCockpitOn,		up = iCommandViewTempCockpitOff,		name = _('Cockpit panel view in'),			category = _('View Cockpit')},
{		down = iCommandViewTempCockpitToggle,											name = _('Cockpit panel view toggle'),		category = _('View Cockpit')},
--// Save current cockpit camera angles for fast numpad jumps
{			down = iCommandViewSaveAngles,													name = _('Save Cockpit Angles'),			category = _('View Cockpit')},
{			pressed = iCommandViewUp,					up = iCommandViewStop,				name = _('View up'),						category = _('View Cockpit')},
{		pressed = iCommandViewDown,					up = iCommandViewStop,				name = _('View down'),						category = _('View Cockpit')},
{		pressed = iCommandViewLeft,					up = iCommandViewStop,				name = _('View left'),						category = _('View Cockpit')},
{		pressed = iCommandViewRight,				up = iCommandViewStop,				name = _('View right'),						category = _('View Cockpit')},
{		pressed = iCommandViewUpRight,				up = iCommandViewStop,				name = _('View up right'),					category = _('View Cockpit')},
{		pressed = iCommandViewDownRight,			up = iCommandViewStop,				name = _('View down right'),				category = _('View Cockpit')},
{		pressed = iCommandViewDownLeft,				up = iCommandViewStop,				name = _('View down left'),					category = _('View Cockpit')},
{		pressed = iCommandViewUpLeft,				up = iCommandViewStop,				name = _('View up left'),					category = _('View Cockpit')},

-- Cockpit Camera Motion (Передвижение камеры в кабине)
{	pressed = iCommandViewPitCameraMoveUp,		up = iCommandViewPitCameraMoveStop,	name = _('Cockpit Camera Move Up'),			category = _('View Cockpit')},
{	pressed = iCommandViewPitCameraMoveDown,	up = iCommandViewPitCameraMoveStop,	name = _('Cockpit Camera Move Down'),		category = _('View Cockpit')},
{pressed = iCommandViewPitCameraMoveLeft,	up = iCommandViewPitCameraMoveStop,	name = _('Cockpit Camera Move Left'),		category = _('View Cockpit')},
{pressed = iCommandViewPitCameraMoveRight,	up = iCommandViewPitCameraMoveStop,	name = _('Cockpit Camera Move Right'),		category = _('View Cockpit')},
{pressed = iCommandViewPitCameraMoveForward,	up = iCommandViewPitCameraMoveStop,	name = _('Cockpit Camera Move Forward'),	category = _('View Cockpit')},
{	pressed = iCommandViewPitCameraMoveBack,	up = iCommandViewPitCameraMoveStop,	name = _('Cockpit Camera Move Back'),	category = _('View Cockpit')},
{	down = iCommandViewPitCameraMoveCenter,											name = _('Cockpit Camera Move Center'),		category = _('View Cockpit')},

{		down = iCommandViewCameraUp,				up = iCommandViewCameraCenter,		name = _('Glance up'),						category = _('View Cockpit')},
{			down = iCommandViewCameraDown,				up = iCommandViewCameraCenter,		name = _('Glance down'),					category = _('View Cockpit')},
{		down = iCommandViewCameraLeft,				up = iCommandViewCameraCenter,		name = _('Glance left'),					category = _('View Cockpit')},
{			down = iCommandViewCameraRight,				up = iCommandViewCameraCenter,		name = _('Glance right'),					category = _('View Cockpit')},
{			down = iCommandViewCameraUpLeft,			up = iCommandViewCameraCenter,		name = _('Glance up-left'),					category = _('View Cockpit')},
{			down = iCommandViewCameraDownLeft,			up = iCommandViewCameraCenter,		name = _('Glance down-left'),				category = _('View Cockpit')},
{			down = iCommandViewCameraUpRight,			up = iCommandViewCameraCenter,		name = _('Glance up-right'),				category = _('View Cockpit')},
{		down = iCommandViewCameraDownRight,			up = iCommandViewCameraCenter,		name = _('Glance down-right'),				category = _('View Cockpit')},
{		down = iCommandViewPanToggle,													name = _('Camera pan mode toggle'),			category = _('View Cockpit')},

{			down = iCommandViewCameraUpSlow,												name = _('Camera snap view up'),			category = _('View Cockpit')},
{			down = iCommandViewCameraDownSlow,												name = _('Camera snap view down'),			category = _('View Cockpit')},
{			down = iCommandViewCameraLeftSlow,												name = _('Camera snap view left'),			category = _('View Cockpit')},
{		down = iCommandViewCameraRightSlow,												name = _('Camera snap view right'),			category = _('View Cockpit')},
{		down = iCommandViewCameraUpLeftSlow,											name = _('Camera snap view up-left'),		category = _('View Cockpit')},
{		down = iCommandViewCameraDownLeftSlow,											name = _('Camera snap view down-left'),		category = _('View Cockpit')},
{			down = iCommandViewCameraUpRightSlow,											name = _('Camera snap view up-right'),		category = _('View Cockpit')},
{		down = iCommandViewCameraDownRightSlow,											name = _('Camera snap view down-right'),	category = _('View Cockpit')},
{	down = iCommandViewCameraCenter,												name = _('Center Camera View'),				category = _('View Cockpit')},
{		down = iCommandViewCameraReturn,												name = _('Return Camera'),					category = _('View Cockpit')},
{		down = iCommandViewCameraBaseReturn,											name = _('Return Camera Base'),				category = _('View Cockpit')},

{			down = iCommandViewSnapView0,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  0'),			category = _('View Cockpit')},
{			down = iCommandViewSnapView1,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  1'),			category = _('View Cockpit')},
{			down = iCommandViewSnapView2,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  2'),			category = _('View Cockpit')},
{			down = iCommandViewSnapView3,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  3'),			category = _('View Cockpit')},
{			down = iCommandViewSnapView4,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  4'),			category = _('View Cockpit')},
{		down = iCommandViewSnapView5,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  5'),			category = _('View Cockpit')},
{		down = iCommandViewSnapView6,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  6'),			category = _('View Cockpit')},
{			down = iCommandViewSnapView7,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  7'),			category = _('View Cockpit')},
{			down = iCommandViewSnapView8,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  8'),			category = _('View Cockpit')},
{			down = iCommandViewSnapView9,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  9'),			category = _('View Cockpit')},

{		pressed = iCommandViewForward,				up = iCommandViewForwardStop,		name = _('Zoom in'),						category = _('View Cockpit')},
{	pressed = iCommandViewBack,					up = iCommandViewBackStop,			name = _('Zoom out'),						category = _('View Cockpit')},

--[[ Extended view
{combos = {{key = 'J', reformers = {'LShift'}}},			down = iCommandViewCameraJiggle,	name = _('Camera jiggle toggle'),					category = _('View Extended'), features = {"Camera jiggle"}},
{combos = {{key = 'K', reformers = {'LAlt'}}},				down = iCommandViewKeepTerrain,		name = _('Keep terrain camera altitude'),			category = _('View Extended')},
--{combos = {{key = 'Home', reformers = {'RCtrl','RShift'}}},	down = iCommandViewFriends,			name = _('View friends mode'),						category = _('View Extended')},
{combos = {{key = 'End', reformers = {'RCtrl','RShift'}}},	down = iCommandViewEnemies,			name = _('View enemies mode'),						category = _('View Extended')},
{combos = {{key = 'Delete', reformers = {'RCtrl'}}},		down = iCommandViewAll,				name = _('View all mode'),							category = _('View Extended')},
{combos = {{key = 'Num+', reformers = {'RCtrl'}}},			down = iCommandViewPlus,			name = _('Toggle tracking launched weapon'),		category = _('View Extended')},
{combos = {{key = 'PageDown', reformers = {'LCtrl'}}},		down = iCommandViewSwitchForward,	name = _('Objects switching direction forward '),	category = _('View Extended')},
{combos = {{key = 'PageUp', reformers = {'LCtrl'}}},		down = iCommandViewSwitchReverse,	name = _('Objects switching direction reverse '),	category = _('View Extended')},
{combos = {{key = 'Delete', reformers = {'LAlt'}}},			down = iCommandViewObjectIgnore,	name = _('Object exclude '),						category = _('View Extended')},
{combos = {{key = 'Insert', reformers = {'LAlt'}}},			down = iCommandViewObjectsAll,		name = _('Objects all excluded - include'),			category = _('View Extended')},
]]
{down = iCommandToggleMirrors,											name = _('Toggle Mirrors'),		category = _('View Cockpit') , features = {"Mirrors"}},

-- Padlock
{						down = iCommandViewLock,				name = _('Lock View (cycle padlock)'),	category = _('View Padlock')},
{						down = iCommandViewUnlock,				name = _('Unlock view (stop padlock)'),	category = _('View Padlock')},
{	down = iCommandAllMissilePadlock,		name = _('All missiles padlock'),		category = _('View Padlock')},
{	down = iCommandThreatMissilePadlock,	name = _('Threat missile padlock'),		category = _('View Padlock')},
{	down = iCommandViewTerrainLock,			name = _('Lock terrain view'),			category = _('View Padlock')},


--Kneeboard
{	down = iCommandPlaneShowKneeboard,																				name = _('Kneeboard ON/OFF'),						category = _('Kneeboard')},
{							down = iCommandPlaneShowKneeboard,	up = iCommandPlaneShowKneeboard,	value_down = 1.0,	value_up = -1.0,	name = _('Kneeboard glance view'),					category = _('Kneeboard')},
{							down = 3001,	cockpit_device_id = kneeboard_id,						value_down = 1.0,						name = _('Kneeboard Next Page'),					category = _('Kneeboard')},
{							down = 3002,	cockpit_device_id = kneeboard_id,						value_down = 1.0,						name = _('Kneeboard Previous Page'),				category = _('Kneeboard')},
{		down = 3003,	cockpit_device_id = kneeboard_id,						value_down = 1.0,						name = _('Kneeboard current position mark point'),	category = _('Kneeboard')},
--shortcuts navigation
{													down = 3004,	cockpit_device_id = kneeboard_id,						value_down =  1.0,						name = _('Kneeboard Make Shortcut'),				category = _('Kneeboard')},
{													down = 3005,	cockpit_device_id = kneeboard_id,						value_down =  1.0,						name = _('Kneeboard Next Shortcut'),				category = _('Kneeboard')},
{													down = 3005,	cockpit_device_id = kneeboard_id,						value_down = -1.0,						name = _('Kneeboard Previous Shortcut'),			category = _('Kneeboard')},
{													down = 3006,	cockpit_device_id = kneeboard_id,						value_down = 0,							name = _('Kneeboard Jump To Shortcut  1'),			category = _('Kneeboard')},
{													down = 3006,	cockpit_device_id = kneeboard_id,						value_down = 1,							name = _('Kneeboard Jump To Shortcut  2'),			category = _('Kneeboard')},
{													down = 3006,	cockpit_device_id = kneeboard_id,						value_down = 2,							name = _('Kneeboard Jump To Shortcut  3'),			category = _('Kneeboard')},
{													down = 3006,	cockpit_device_id = kneeboard_id,						value_down = 3,							name = _('Kneeboard Jump To Shortcut  4'),			category = _('Kneeboard')},
{													down = 3006,	cockpit_device_id = kneeboard_id,						value_down = 4,							name = _('Kneeboard Jump To Shortcut  5'),			category = _('Kneeboard')},
{													down = 3006,	cockpit_device_id = kneeboard_id,						value_down = 5,							name = _('Kneeboard Jump To Shortcut  6'),			category = _('Kneeboard')},
{													down = 3006,	cockpit_device_id = kneeboard_id,						value_down = 6,							name = _('Kneeboard Jump To Shortcut  7'),			category = _('Kneeboard')},
{													down = 3006,	cockpit_device_id = kneeboard_id,						value_down = 7,							name = _('Kneeboard Jump To Shortcut  8'),			category = _('Kneeboard')},
{													down = 3006,	cockpit_device_id = kneeboard_id,						value_down = 8,							name = _('Kneeboard Jump To Shortcut  9'),			category = _('Kneeboard')},
{													down = 3006,	cockpit_device_id = kneeboard_id,						value_down = 9,							name = _('Kneeboard Jump To Shortcut 10'),			category = _('Kneeboard')},

	
},

-- joystick axis 
axisCommands = {

    {action = iCommandViewHorizontalAbs			, name = _('Absolute Camera Horizontal View')},
    {action = iCommandViewVerticalAbs			, name = _('Absolute Camera Vertical View')},
    {action = iCommandViewZoomAbs				, name = _('Zoom View')},
    {action = iCommandViewRollAbs 				, name = _('Absolute Roll Shift Camera View')},
    {action = iCommandViewHorTransAbs 			, name = _('Absolute Horizontal Shift Camera View')},
    {action = iCommandViewVertTransAbs 			, name = _('Absolute Vertical Shift Camera View')},
    {action = iCommandViewLongitudeTransAbs 	, name = _('Absolute Longitude Shift Camera View')},

    -- from base_joystick_binding.lua...

    {combos = defaultDeviceAssignmentFor("roll")  ,  action = iCommandPlaneRoll		   , name = _('Roll')},
    {combos = defaultDeviceAssignmentFor("pitch") ,  action = iCommandPlanePitch	   , name = _('Pitch')},
    {combos = defaultDeviceAssignmentFor("rudder"),  action = iCommandPlaneRudder	   , name = _('Rudder')},
    
	{combos = defaultDeviceAssignmentFor("thrust"),  action = iCommandPlaneThrustCommon, name = _('Thrust')},
	
    {action = iCommandWheelBrake,		name = _('Wheel Brake')},
    {action = iCommandLeftWheelBrake,	name = _('Wheel Brake Left')},
    {action = iCommandRightWheelBrake,	name = _('Wheel Brake Right')},
	
	{action = EFM_commands.floodLights,		cockpit_device_id = devices.EFM, name = _('Flood Lights Knob')},
	{action = EFM_commands.consoleLights,	cockpit_device_id = devices.EFM, name = _('Console Lights Knob')},
	{action = EFM_commands.MIPLights,		cockpit_device_id = devices.EFM, name = _('MIP Lights Knob')},
	
	{action = device_commands.HUDBrtKnob,		cockpit_device_id = devices.HUD, name = _('HUD Brightness Knob')},
},
}

