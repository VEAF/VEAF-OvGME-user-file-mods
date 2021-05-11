local cockpit = folder.."../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")
------ down = single instance,  pressed = continuous input
local kneeboard_id = 100
if devices and devices.KNEEBOARD then
   kneeboard_id = devices.KNEEBOARD
end

return {
keyCommands = {

-- Weapons
{combos = {{key = 'Space'}}, down = Keys.PlaneFireOn, up = Keys.PlaneFireOff,	name = _('Guns Fire'), category = _('Weapons')},
{combos = {{key = 'Space', reformers = {'LAlt'}}}, down = Keys.PickleOn, up = Keys.PickleOff, name = _('Weapons Release'), category = _('Weapons')},
{combos = {{key = 'M'}}, down = Keys.MasterArmToggle, name = _('Master Arm Toggle'), category = _('Weapons')},
{combos = {{key = 'W', reformers = {'LCtrl'}}}, down = device_commands.emergencyJettison, up = device_commands.emergencyJettison, cockpit_device_id = devices.WEAPON_SYSTEM,  value_down =  1.0, value_up =  0.0, name = _('Jettison Weapons'), category = _('Weapons')},
{down = device_commands.masterArm, cockpit_device_id = devices.WEAPON_SYSTEM,			value_down =  1.0,	name = _('Master Arm Switch - ARM'),							category = _('Weapons')},
{down = device_commands.masterArm, cockpit_device_id = devices.WEAPON_SYSTEM,			value_down =  0.0,	name = _('Master Arm Switch - SAFE'),							category = _('Weapons')},

--{down = Keys.SmokeOnOff,  name = _('Smoke'), category = _('Weapons')},

-- Systems
{combos = {{key = 'L', reformers = {'RShift'}}}, down = Keys.Battery1Toggle, name = _('Battery 1 Switch - ON/OFF'), category = _('Systems')},
{down = EFM_commands.BatterySwitch1, cockpit_device_id = devices.EFM,	value_down =  1.0,		name = _('Battery 1 Switch - ON'),	category = _('Systems')},
{down = EFM_commands.BatterySwitch1, cockpit_device_id = devices.EFM,	value_down =  0.0,		name = _('Battery 1 Switch - OFF'),	category = _('Systems')},
{down = Keys.Battery2Toggle, 																name = _('Battery 2 Switch - ON/OFF'), category = _('Systems')},
{down = EFM_commands.BatterySwitch2, cockpit_device_id = devices.EFM,	value_down =  1.0,		name = _('Battery 2 Switch - ON'),	category = _('Systems')},
{down = EFM_commands.BatterySwitch2, cockpit_device_id = devices.EFM,	value_down =  0.0,		name = _('Battery 2 Switch - OFF'),	category = _('Systems')},
{down = EFM_commands.GeneratorSwitch, cockpit_device_id = devices.EFM,	value_down =  0.5,		name = _('Generator Switch - ON'),	category = _('Systems')},
{down = EFM_commands.GeneratorSwitch, cockpit_device_id = devices.EFM,	value_down =  0.0,		name = _('Generator Switch - OFF'),	category = _('Systems')},

{combos = {{key = 'C'}},	down = Keys.cageButton,	name = _('Cage/Uncage Button'),	category = _('Systems')},
{combos = {{key = 'F'}}, down = EFM_commands.FlapSwitch, cockpit_device_id = devices.EFM, value_down =  0.0,	name = _('Flap Switch UP'),	category = _('Systems')},
{combos = {{key = 'F', reformers = {'LShift'}}}, down = EFM_commands.FlapSwitch, cockpit_device_id = devices.EFM, value_down =  0.5, name = _('Flap Switch HALF'), category = _('Systems')},
{combos = {{key = 'F', reformers = {'LCtrl'}}},	down = EFM_commands.FlapSwitch,	cockpit_device_id = devices.EFM, value_down =  1.0,	name = _('Flap Switch DOWN'), category = _('Systems')},
{down = Keys.FlapStepDown, name = _('Flap Increment Down'), category = _('Systems')},
{down = Keys.FlapStepUp,	name = _('Flap Increment Up'), category = _('Systems')},
{down = EFM_commands.FlapSwitch, up = EFM_commands.FlapSwitch,cockpit_device_id = devices.EFM, value_down =  0.0, value_up =  0.5, name = _('Flap Switch UP else HALF'), category = _('Systems')},
{down = EFM_commands.FlapSwitch, up = EFM_commands.FlapSwitch,cockpit_device_id = devices.EFM, value_down =  1.0, value_up =  0.5, name = _('Flap Switch DOWN else HALF'), category = _('Systems')},

-- Gear
{combos = {{key = 'G'}}, down = Keys.GearLever,														name = _('Landing Gear - UP/DOWN'), 				category = {_('Landing Gear'), _('Systems')}},
{combos = {{key = 'G', reformers = {'LCtrl'}}}, down = EFM_commands.GearLever, cockpit_device_id = devices.EFM,			value_down =  1.0,	name = _('Landing Gear - DOWN'),						category = {_('Landing Gear'), _('Systems')}},
{combos = {{key = 'G', reformers = {'LShift'}}}, down = EFM_commands.GearLever, cockpit_device_id = devices.EFM,			value_down =  0.0,	name = _('Landing Gear - UP'),						category = {_('Landing Gear'), _('Systems')}},
{down = EFM_commands.AntiSkidSwitch, cockpit_device_id = devices.EFM,	value_down =  1.0,				name = _('Anti-Skid Switch - ON'),								category = {_('Landing Gear'), _('Systems')}},
{down = EFM_commands.AntiSkidSwitch, cockpit_device_id = devices.EFM,	value_down =  0.0,				name = _('Anti-Skid Switch - OFF'),							category = {_('Landing Gear'), _('Systems')}},
{combos = {{key = 'W'}}, down = iCommandPlaneWheelBrakeOn, up = iCommandPlaneWheelBrakeOff, 			name = _('Wheel Brake On'),									category = {_('Landing Gear'), _('Systems')}},
{combos = {{key = 'S'}}, down = EFM_commands.NWSButton, up = EFM_commands.NWSButton, 	value_down =  1.0, value_up =  0.0, name = _('Nose Wheel Steering Button'),	category = {_('Landing Gear'), _('Systems')}},
{down = EFM_commands.parkBrake, cockpit_device_id = devices.EFM,	value_down =  1.0,		name = _('Parking Brake - ON'),			category = {_('Landing Gear'), _('Systems')}},
{down = EFM_commands.parkBrake, cockpit_device_id = devices.EFM,	value_down =  0.0,		name = _('Parking Brake - OFF'),		category = {_('Landing Gear'), _('Systems')}},

{combos = {{key = 'C', reformers = {'LCtrl'}}},	down = Keys.canopy,	name = _('Canopy - OPEN/CLOSE'), category = _('Systems')},
{down = EFM_commands.CanopyLever, cockpit_device_id = devices.EFM,	value_down =  1.0,		name = _('Canopy - OPEN'),			category = _('Systems')},
{down = EFM_commands.CanopyLever, cockpit_device_id = devices.EFM,	value_down =  0.0,		name = _('Canopy - CLOSE'),			category = _('Systems')},
{combos = {{key = 'E', reformers = {'LCtrl'}}},	down = EFM_commands.Eject, name = _('Eject (3 times)'),	category = _('Systems')},
{combos = {{key = 'Home', reformers = {'RCtrl','RShift'}}}, down = EFM_commands.EngineSwitch, cockpit_device_id = devices.EFM, value_down =  0.0, name = _('Engine Switch OFF'), category = _('Systems')},
{combos = {{key = 'Home', reformers = {'LCtrl','RShift'}}}, down = EFM_commands.EngineSwitch, cockpit_device_id = devices.EFM, value_down =  0.5, name = _('Engine Switch ON'),	category = _('Systems')},
{combos = {{key = 'Home', reformers = {'RCtrl','LShift'}}}, down = EFM_commands.EngineSwitch, up = EFM_commands.EngineSwitch, cockpit_device_id = devices.EFM, value_down =  1.0, value_up =  0.5, name = _('Engine Switch START'), category = _('Systems')},

{down = EFM_commands.HYD2reset, up = EFM_commands.HYD2reset,  cockpit_device_id = devices.EFM,  value_down = 1.0,   value_up=0.0, name = ('HYD 2 Reset Button'), category = ('Systems')},


--- Control ---
{combos = {{key = '.', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimUp,			up = iCommandPlaneTrimStop, name = _('Trim: Nose Up'),			category = _('Flight Control')},
{combos = {{key = ';', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimDown,		up = iCommandPlaneTrimStop, name = _('Trim: Nose Down'),		category = _('Flight Control')},
{combos = {{key = ',', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimLeft,		up = iCommandPlaneTrimStop, name = _('Trim: Left Wing Down'),	category = _('Flight Control')},
{combos = {{key = '/', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimRight,		up = iCommandPlaneTrimStop, name = _('Trim: Right Wing Down'),	category = _('Flight Control')},
--{combos = {{key = 'Z', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimLeftRudder,	up = iCommandPlaneTrimStop, name = _('Trim: Rudder Left'),		category = _('Flight Control')},
--{combos = {{key = 'X', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimRightRudder,	up = iCommandPlaneTrimStop, name = _('Trim: Rudder Right'),		category = _('Flight Control')},
{combos = {{key = 'Z'}}, pressed = EFM_commands.KeyRudderLeft,		up = EFM_commands.KeyRudderStop, name = _('Aircraft Yaw Left'),	category = _('Flight Control')},
{combos = {{key = 'X'}}, pressed = EFM_commands.KeyRudderRight,		up = EFM_commands.KeyRudderStop, name = _('Aircraft Yaw Right'),	category = _('Flight Control')},

{combos = {{key = 'Num+'}}, pressed = EFM_commands.ThrottleIncrease,				name = _('Throttle Smoothly - Increase'),		category = {_('Throttle Grip'), _('Flight Control')}},
{combos = {{key = 'Num-'}}, pressed = EFM_commands.ThrottleDecrease,				name = _('Throttle Smoothly - Decrease'),		category = {_('Throttle Grip'), _('Flight Control')}},


--- Throttle
{combos = {{key = 'Home', reformers = {'RShift'}}}, down = EFM_commands.GTSbutton, up = EFM_commands.GTSbutton, cockpit_device_id = devices.EFM,  value_down = 1.0,	value_up =  0.0, name = _('Gas Turbine Starter Button'), category = _('Throttle Grip')},
{combos = {{key = 'Home'}}, down = Keys.Finger_Lift, name = _('Throttle Finger Lift'), category = _('Throttle Grip')},
{combos = {{key = 'B', reformers = {'LShift'}}}, down = EFM_commands.SpeedBrakeSwitch,	up = EFM_commands.SpeedBrakeSwitch,	value_down =  1.0, value_up =  0.0,	name = _('Speed Brake Switch AFT'), category = _('Throttle Grip')},
{combos = {{key = 'B'}}, down = EFM_commands.SpeedBrakeSwitch,	value_down =  0.0, name = _('Speed Brake Switch CENTER'), category = _('Throttle Grip')},
{combos = {{key = 'B', reformers = {'LCtrl'}}},	down = EFM_commands.SpeedBrakeSwitch, value_down =  -1.0, name = _('Speed Brake Switch FORWARD'),	category = _('Throttle Grip')},

{combos = {{key = 'T', reformers = {'LShift' }}},	down = device_commands.throttleMicSwitch, up = device_commands.throttleMicSwitch,	 cockpit_device_id = devices.COMM1,	value_down =  1, value_up =  0.0, name = _('Microphone Switch COMM 1'),	category = _('Throttle Grip')},
{combos = {{key = 'T', reformers = {'LCtrl' }}},	down = device_commands.throttleMicSwitch, up = device_commands.throttleMicSwitch, 	cockpit_device_id = devices.COMM1,	value_down =  -1, value_up =  0.0, name = _('Microphone Switch COMM 2'),	category = _('Throttle Grip')},
{combos = {{key = 'T'}},							down = Keys.IntercomPTT, up = Keys.IntercomPTT,	value_down =  1, value_up =  0.0, name = _('Microphone Switch Intercom'), category = _('Throttle Grip')},

{down = EFM_commands.lightsMaster,	up = EFM_commands.lightsMaster,	 cockpit_device_id = devices.EFM, value_down =  -1.0, value_up =  0.0,	name = _('Exterior Lights Master Switch AFT'), category = _('Throttle Grip')},
{down = EFM_commands.lightsMaster,	value_down =  0.0,	 cockpit_device_id = devices.EFM,													name = _('Exterior Lights Master CENTER'),	category = _('Throttle Grip')},
{down = EFM_commands.lightsMaster,	value_down =  1.0,	 cockpit_device_id = devices.EFM,													name = _('Exterior Lights Master FORWARD'),	category = _('Throttle Grip')},

-- Carrier
{combos = {{key = 'U'}},									down = iCommandPlaneShipTakeOff,	name = _('Catapult Hook Up'),		category = _('Carrier') },
{combos = {{key = 'U', reformers = {'RShift'}}},			down = Keys.LaunchBarToggle,		name = _('Launch Bar - EXTEND/RETRACT'),	category = _('Carrier') },
{down = EFM_commands.LaunchBarSwitch,	value_down =  1.0,	 cockpit_device_id = devices.EFM,			name = _('Launch Bar - EXTEND'),	category = _('Carrier')},
{down = EFM_commands.LaunchBarSwitch,	value_down =  0.0,	 cockpit_device_id = devices.EFM,			name = _('Launch Bar - RETRACT'),	category = _('Carrier')},
{combos = {{key = 'H'}}, 									down = Keys.HookToggle, 			name = _('Tail Hook - EXTEND/RETRACT'),		category = _('Carrier')},
{down = EFM_commands.HookLever,	value_down =  1.0,	 cockpit_device_id = devices.EFM,			name = _('Tail Hook - EXTEND'),	category = _('Carrier')},
{down = EFM_commands.HookLever,	value_down =  0.0,	 cockpit_device_id = devices.EFM,			name = _('Tail Hook - RETRACT'),	category = _('Carrier')},
{combos = {{key = 'S', reformers = {'LShift','LCtrl'}}},	down = iCommandPilotGestureSalute,	name = _('Pilot Salute'),				category = _('Carrier')},

---- Multicrew -----
{combos = {{key = '1'}},	down = iCommandViewCockpitChangeSeat, value_down = 1, name = _('Occupy Front Seat'),	category = _('Multicrew')},
{combos = {{key = '2'}},	down = iCommandViewCockpitChangeSeat, value_down = 2, name = _('Occupy Rear Seat'),		category = _('Multicrew')},
{combos = {{key = 'J'}},	down = iCommandNetCrewRequestControl,				name = _('Request Aircraft Control'),category = _('Multicrew')},

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



----------------------------------------- From common keyboard bindings lua -------------------------------------------------------------------------
-- Debug
{combos = {{key = '`', reformers = {'LAlt'}}},		down = ICommandToggleConsole,	name = _('Toggle Console'),		category = _('Debug')},
{combos = {{key = 'R', reformers = {'LShift'}}},	down = iCommandMissionRestart,	name = _('Restart Mission'),	category = _('Debug')},

-- General (Gameplay)
{combos = {{key = 'Esc'}},										down = iCommandQuit,							name = _('End mission'),							category = _('General')},
{combos = {{key = 'Pause'}},									down = iCommandBrakeGo,							name = _('Pause'),									category = _('General')},
{combos = {{key = 'Z', reformers = {'LCtrl'}}},					down = iCommandAccelerate,						name = _('Time accelerate'),						category = _('General')},
{combos = {{key = 'Z', reformers = {'LAlt'}}},					down = iCommandDecelerate,						name = _('Time decelerate'),						category = _('General')},
{combos = {{key = 'Z', reformers = {'LShift'}}},				down = iCommandNoAcceleration,					name = _('Time normal'),							category = _('General')},
{combos = {{key = '\''}},										down = iCommandScoresWindowToggle,				name = _('Score window'),							category = _('General')},

{combos = {{key = 'Y',	 reformers = {'LCtrl'}}},				down = iCommandInfoOnOff,						name = _('Info bar view toggle'),					category = _('General')},
{combos = {{key = 'Tab', reformers = {'RCtrl', 'RShift'}}},		down = iCommandRecoverHuman,					name = _('Get new plane - respawn'),				category = _('General')},
{combos = {{key = 'J',	 reformers = {'RAlt'}}},				down = iCommandPlaneJump,						name = _('Jump into selected aircraft'),			category = _('General')},
{combos = {{key = 'SysRQ'}},									down = iCommandScreenShot,						name = _('Screenshot'),								category = _('General'), disabled = true},
{combos = {{key = 'Pause', reformers = {'RCtrl'}}},				down = iCommandGraphicsFrameRate,				name = _('Frame rate counter - Service info'),		category = _('General')},
{combos = {{key = 'Y',	 reformers = {'LAlt'}}},				down = iCommandViewCoordinatesInLinearUnits,	name = _('Info bar coordinate units toggle'),		category = _('General')},
{combos = {{key = 'C',	 reformers = {'LAlt'}}},				down = iCommandCockpitClickModeOnOff,			name = _('Clickable mouse cockpit mode On/Off'),	category = _('General')},
{combos = {{key = 'S',	 reformers = {'LCtrl'}}},				down = iCommandSoundOnOff,						name = _('Sound On/Off'),							category = _('General')},
{combos = {{key = '\'',	 reformers = {'LAlt'}}}, 				down = iCommandMissionResourcesManagement,		name = _('Rearming and Refueling Window'),			category = _('General')},
{combos = {{key = 'B',	 reformers = {'LAlt'}}},				down = iCommandViewBriefing,					name = _('View briefing on/off'),					category = _('General')},
{combos = {{key = 'Pause', reformers = {'LShift', 'LWin'}}},	down = iCommandActivePauseOnOff,				name = _('Active Pause'),							category = _('Cheat')},
{combos = {{key = 'Enter', reformers = {'RCtrl'}}},				down = iCommandPlane_ShowControls,				name = _('Show controls indicator'),				category = _('General')},

-- Communications
{combos = {{key = 'T', reformers = {'LWin'}}},					down = iCommandPlaneFormation,					name = _('Toggle Formation'),						category = _('Communications')},
{combos = {{key = 'Y', reformers = {'LWin'}}},					down = iCommandPlaneJoinUp,						name = _('Join Up Formation'),						category = _('Communications')},
{combos = {{key = '\\'}},										down = iCommandToggleCommandMenu,				name = _('Communication menu'),						category = _('Communications')},
{combos = {{key = '\\', reformers = {'LShift'}}},				down = ICommandSwitchDialog,					name = _('Switch dialog'),							category = _('Communications')},
{combos = {{key = '\\', reformers = {'LCtrl'}}},				down = ICommandSwitchToCommonDialog,			name = _('Switch to main menu'),					category = _('Communications')},




-- View
{combos = {{key = 'Num4'}},	pressed = iCommandViewLeftSlow,			up = iCommandViewStopSlow,					name = _('View Left slow'),							category = _('View')},
{combos = {{key = 'Num6'}},	pressed = iCommandViewRightSlow,		up = iCommandViewStopSlow,					name = _('View Right slow'),						category = _('View')},
{combos = {{key = 'Num8'}},	pressed = iCommandViewUpSlow,			up = iCommandViewStopSlow,					name = _('View Up slow'),							category = _('View')},
{combos = {{key = 'Num2'}},	pressed = iCommandViewDownSlow,			up = iCommandViewStopSlow,					name = _('View Down slow'),							category = _('View')},
{combos = {{key = 'Num9'}},	pressed = iCommandViewUpRightSlow,		up = iCommandViewStopSlow,					name = _('View Up Right slow'),						category = _('View')},
{combos = {{key = 'Num3'}},	pressed = iCommandViewDownRightSlow,	up = iCommandViewStopSlow,					name = _('View Down Right slow'),					category = _('View')},
{combos = {{key = 'Num1'}},	pressed = iCommandViewDownLeftSlow,		up = iCommandViewStopSlow,					name = _('View Down Left slow'),					category = _('View')},
{combos = {{key = 'Num7'}},	pressed = iCommandViewUpLeftSlow,		up = iCommandViewStopSlow,					name = _('View Up Left slow'),						category = _('View')},
{combos = {{key = 'Num5'}},	pressed = iCommandViewCenter, 														name = _('View Center'),							category = _('View')},
{combos = {{key = 'Num*'}},	pressed = iCommandViewForwardSlow, up = iCommandViewForwardSlowStop,		name = _('Zoom in slow'),									category = _('View')},
{combos = {{key = 'Num/'}},	pressed = iCommandViewBackSlow,	up = iCommandViewBackSlowStop,			name = _('Zoom out slow'),										category = _('View')},
{combos = {{key = 'NumEnter'}},	down = iCommandViewAngleDefault, name = _('Zoom normal'),										category = _('View')},
{combos = {{key = 'Num*', reformers = {'RCtrl'}}},		pressed = iCommandViewExternalZoomIn,	up = iCommandViewExternalZoomInStop,	name = _('Zoom external in'),									category = _('View')},
{combos = {{key = 'Num/', reformers = {'RCtrl'}}},		pressed = iCommandViewExternalZoomOut,	up = iCommandViewExternalZoomOutStop,	name = _('Zoom external out'),									category = _('View')},
{combos = {{key = 'NumEnter', reformers = {'RCtrl'}}},	down = iCommandViewExternalZoomDefault,											name = _('Zoom external normal'),								category = _('View')},
{combos = {{key = 'Num*', reformers = {'LAlt'}}},		down = iCommandViewSpeedUp,														name = _('F11 Camera moving forward'),							category = _('View')},
{combos = {{key = 'Num/', reformers = {'LAlt'}}},		down = iCommandViewSlowDown,													name = _('F11 Camera moving backward'),							category = _('View')},

{combos = {{key = 'F1'}},								down = iCommandViewCockpit,														name = _('F1 Cockpit view'),									category = _('View')},
{combos = {{key = 'F1', reformers = {'LCtrl'}}},		down = iCommandNaturalViewCockpitIn,											name = _('F1 Natural head movement view'),						category = _('View')},
{combos = {{key = 'F1', reformers = {'LAlt'}}},			down = iCommandViewHUDOnlyOnOff,												name = _('F1 HUD only view switch'),							category = _('View')},
{combos = {{key = 'F2'}},								down = iCommandViewAir,															name = _('F2 Aircraft view'),									category = _('View')},
{combos = {{key = 'F2', reformers = {'LCtrl'}}},		down = iCommandViewMe,															name = _('F2 View own aircraft'),								category = _('View')},
{combos = {{key = 'F2', reformers = {'RAlt'}}},			down = iCommandViewFromTo,														name = _('F2 Toggle camera position'),							category = _('View')},
{combos = {{key = 'F2', reformers = {'LAlt'}}},			down = iCommandViewLocal,														name = _('F2 Toggle local camera control'),						category = _('View')},
{combos = {{key = 'F3'}},								down = iCommandViewTower,														name = _('F3 Fly-By view'),										category = _('View')},
{combos = {{key = 'F3', reformers = {'LCtrl'}}},		down = iCommandViewTowerJump,													name = _('F3 Fly-By jump view'),								category = _('View')},
{combos = {{key = 'F4'}},								down = iCommandViewRear,														name = _('F4 Look back view'),									category = _('View')},
{combos = {{key = 'F4', reformers = {'LCtrl'}}},		down = iCommandViewChase,														name = _('F4 Chase view'),										category = _('View')},
{combos = {{key = 'F4', reformers = {'LShift'}}},		down = iCommandViewChaseArcade,													name = _('F4 Arcade Chase view'),								category = _('View')},
{combos = {{key = 'F5'}},								down = iCommandViewFight,														name = _('F5 nearest AC view'),									category = _('View')},
{combos = {{key = 'F5', reformers = {'LCtrl'}}},		down = iCommandViewFightGround,													name = _('F5 Ground hostile view'),								category = _('View')},
{combos = {{key = 'F6'}},								down = iCommandViewWeapons,														name = _('F6 Released weapon view'),							category = _('View')},
{combos = {{key = 'F6', reformers = {'LCtrl'}}},		down = iCommandViewWeaponAndTarget,												name = _('F6 Weapon to target view'),							category = _('View')},
{combos = {{key = 'F7'}},								down = iCommandViewGround,														name = _('F7 Ground unit view'),								category = _('View')},
{combos = {{key = 'F8'}},								down = iCommandViewTargets,														name = _('F8 Target view'),										category = _('View')},
{combos = {{key = 'F8', reformers = {'RCtrl'}}},		down = iCommandViewTargetType,													name = _('F8 Player targets/All targets filter'),				category = _('View')},
{combos = {{key = 'F9'}},								down = iCommandViewNavy,														name = _('F9 Ship view'),										category = _('View')},
{combos = {{key = 'F9', reformers = {'LAlt'}}},			down = iCommandViewLndgOfficer,													name = _('F9 Landing signal officer view'),						category = _('View')},
{combos = {{key = 'F10'}},								down = iCommandViewAWACS,														name = _('F10 Theater map view'),								category = _('View')},
{combos = {{key = 'F10', reformers = {'LCtrl'}}},		down = iCommandViewAWACSJump,													name = _('F10 Jump to theater map view over current point'),	category = _('View')},
{combos = {{key = 'F11'}},								down = iCommandViewFree,														name = _('F11 Airport free camera'),							category = _('View')},
{combos = {{key = 'F11', reformers = {'LCtrl'}}},		down = iCommandViewFreeJump,													name = _('F11 Jump to free camera'),							category = _('View')},
{combos = {{key = 'F12'}},								down = iCommandViewStatic,														name = _('F12 Static object view'),								category = _('View')},
{combos = {{key = 'F12', reformers = {'LCtrl'}}},		down = iCommandViewMirage,														name = _('F12 Civil traffic view'),								category = _('View')},
{combos = {{key = 'F12', reformers = {'LShift'}}},		down = iCommandViewLocomotivesToggle,											name = _('F12 Trains/cars toggle'),								category = _('View')},
{combos = {{key = 'F1', reformers = {'LWin'}}},			down = iCommandViewPitHeadOnOff,												name = _('F1 Head shift movement on / off'),					category = _('View')},

{combos = {{key = ']', reformers = {'LShift'}}},		down = iCommandViewFastKeyboard,												name = _('Keyboard Rate Fast'),									category = _('View')},
{combos = {{key = ']', reformers = {'LCtrl'}}},			down = iCommandViewSlowKeyboard,												name = _('Keyboard Rate Slow'),									category = _('View')},
{combos = {{key = ']', reformers = {'LAlt'}}},			down = iCommandViewNormalKeyboard,												name = _('Keyboard Rate Normal'),								category = _('View')},
{combos = {{key = '[', reformers = {'LShift'}}},		down = iCommandViewFastMouse,													name = _('Mouse Rate Fast'),									category = _('View')},
{combos = {{key = '[', reformers = {'LCtrl'}}},			down = iCommandViewSlowMouse,													name = _('Mouse Rate Slow'),									category = _('View')},
{combos = {{key = '[', reformers = {'LAlt'}}},			down = iCommandViewNormalMouse,													name = _('Mouse Rate Normal'),									category = _('View')},
{combos = {{key = 'T', reformers = {'LCtrl', 'LShift'}}},	down = iCommandflushTaxiData,												name = _('Flush taxi data'),									category = _('View')},

-- Cockpit view
{combos = {{key = 'L', reformers = {'LAlt'}}},				down = 3256,	cockpit_device_id = 0,	value_down = 1.0,						name = _('Flashlight'),						category = _('View Cockpit')},

{combos = {{key = 'Num0'}},									down = iCommandViewTempCockpitOn,		up = iCommandViewTempCockpitOff,		name = _('Cockpit panel view in'),			category = _('View Cockpit')},
{combos = {{key = 'Num0', reformers = {'RCtrl'}}},			down = iCommandViewTempCockpitToggle,											name = _('Cockpit panel view toggle'),		category = _('View Cockpit')},
--// Save current cockpit camera angles for fast numpad jumps
{combos = {{key = 'Num0', reformers = {'RAlt'}}},			down = iCommandViewSaveAngles,													name = _('Save Cockpit Angles'),			category = _('View Cockpit')},
{combos = {{key = 'Num8', reformers = {'RShift'}}},			pressed = iCommandViewUp,					up = iCommandViewStop,				name = _('View up'),						category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'RShift'}}},			pressed = iCommandViewDown,					up = iCommandViewStop,				name = _('View down'),						category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'RShift'}}},			pressed = iCommandViewLeft,					up = iCommandViewStop,				name = _('View left'),						category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'RShift'}}},			pressed = iCommandViewRight,				up = iCommandViewStop,				name = _('View right'),						category = _('View Cockpit')},
{combos = {{key = 'Num9', reformers = {'RShift'}}},			pressed = iCommandViewUpRight,				up = iCommandViewStop,				name = _('View up right'),					category = _('View Cockpit')},
{combos = {{key = 'Num3', reformers = {'RShift'}}},			pressed = iCommandViewDownRight,			up = iCommandViewStop,				name = _('View down right'),				category = _('View Cockpit')},
{combos = {{key = 'Num1', reformers = {'RShift'}}},			pressed = iCommandViewDownLeft,				up = iCommandViewStop,				name = _('View down left'),					category = _('View Cockpit')},
{combos = {{key = 'Num7', reformers = {'RShift'}}},			pressed = iCommandViewUpLeft,				up = iCommandViewStop,				name = _('View up left'),					category = _('View Cockpit')},

-- Cockpit Camera Motion (Передвижение камеры в кабине)
{combos = {{key = 'Num8', reformers = {'RCtrl','RShift'}}},	pressed = iCommandViewPitCameraMoveUp,		up = iCommandViewPitCameraMoveStop,	name = _('Cockpit Camera Move Up'),			category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'RCtrl','RShift'}}},	pressed = iCommandViewPitCameraMoveDown,	up = iCommandViewPitCameraMoveStop,	name = _('Cockpit Camera Move Down'),		category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'RCtrl','RShift'}}},	pressed = iCommandViewPitCameraMoveLeft,	up = iCommandViewPitCameraMoveStop,	name = _('Cockpit Camera Move Left'),		category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'RCtrl','RShift'}}},	pressed = iCommandViewPitCameraMoveRight,	up = iCommandViewPitCameraMoveStop,	name = _('Cockpit Camera Move Right'),		category = _('View Cockpit')},
{combos = {{key = 'Num*', reformers = {'RCtrl','RShift'}}},	pressed = iCommandViewPitCameraMoveForward,	up = iCommandViewPitCameraMoveStop,	name = _('Cockpit Camera Move Forward'),	category = _('View Cockpit')},
{combos = {{key = 'Num/', reformers = {'RCtrl','RShift'}}, {key = 'Num-', reformers = {'RCtrl','RShift'}}},	pressed = iCommandViewPitCameraMoveBack,	up = iCommandViewPitCameraMoveStop,	name = _('Cockpit Camera Move Back'),	category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'RCtrl','RShift'}}},	down = iCommandViewPitCameraMoveCenter,											name = _('Cockpit Camera Move Center'),		category = _('View Cockpit')},

{combos = {{key = 'Num8', reformers = {'RCtrl'}}},			down = iCommandViewCameraUp,				up = iCommandViewCameraCenter,		name = _('Glance up'),						category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'RCtrl'}}},			down = iCommandViewCameraDown,				up = iCommandViewCameraCenter,		name = _('Glance down'),					category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'RCtrl'}}},			down = iCommandViewCameraLeft,				up = iCommandViewCameraCenter,		name = _('Glance left'),					category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'RCtrl'}}},			down = iCommandViewCameraRight,				up = iCommandViewCameraCenter,		name = _('Glance right'),					category = _('View Cockpit')},
{combos = {{key = 'Num7', reformers = {'RCtrl'}}},			down = iCommandViewCameraUpLeft,			up = iCommandViewCameraCenter,		name = _('Glance up-left'),					category = _('View Cockpit')},
{combos = {{key = 'Num1', reformers = {'RCtrl'}}},			down = iCommandViewCameraDownLeft,			up = iCommandViewCameraCenter,		name = _('Glance down-left'),				category = _('View Cockpit')},
{combos = {{key = 'Num9', reformers = {'RCtrl'}}},			down = iCommandViewCameraUpRight,			up = iCommandViewCameraCenter,		name = _('Glance up-right'),				category = _('View Cockpit')},
{combos = {{key = 'Num3', reformers = {'RCtrl'}}},			down = iCommandViewCameraDownRight,			up = iCommandViewCameraCenter,		name = _('Glance down-right'),				category = _('View Cockpit')},
{combos = {{key = 'Z', reformers = {'LAlt','LShift'}}},		down = iCommandViewPanToggle,													name = _('Camera pan mode toggle'),			category = _('View Cockpit')},

{combos = {{key = 'Num8', reformers = {'RAlt'}}},			down = iCommandViewCameraUpSlow,												name = _('Camera snap view up'),			category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'RAlt'}}},			down = iCommandViewCameraDownSlow,												name = _('Camera snap view down'),			category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'RAlt'}}},			down = iCommandViewCameraLeftSlow,												name = _('Camera snap view left'),			category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'RAlt'}}},			down = iCommandViewCameraRightSlow,												name = _('Camera snap view right'),			category = _('View Cockpit')},
{combos = {{key = 'Num7', reformers = {'RAlt'}}},			down = iCommandViewCameraUpLeftSlow,											name = _('Camera snap view up-left'),		category = _('View Cockpit')},
{combos = {{key = 'Num1', reformers = {'RAlt'}}},			down = iCommandViewCameraDownLeftSlow,											name = _('Camera snap view down-left'),		category = _('View Cockpit')},
{combos = {{key = 'Num9', reformers = {'RAlt'}}},			down = iCommandViewCameraUpRightSlow,											name = _('Camera snap view up-right'),		category = _('View Cockpit')},
{combos = {{key = 'Num3', reformers = {'RAlt'}}},			down = iCommandViewCameraDownRightSlow,											name = _('Camera snap view down-right'),	category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'RShift'}}},			down = iCommandViewCameraCenter,												name = _('Center Camera View'),				category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'RCtrl'}}},			down = iCommandViewCameraReturn,												name = _('Return Camera'),					category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'RAlt'}}},			down = iCommandViewCameraBaseReturn,											name = _('Return Camera Base'),				category = _('View Cockpit')},

{combos = {{key = 'Num0', reformers = {'LWin'}}},			down = iCommandViewSnapView0,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  0'),			category = _('View Cockpit')},
{combos = {{key = 'Num1', reformers = {'LWin'}}},			down = iCommandViewSnapView1,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  1'),			category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'LWin'}}},			down = iCommandViewSnapView2,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  2'),			category = _('View Cockpit')},
{combos = {{key = 'Num3', reformers = {'LWin'}}},			down = iCommandViewSnapView3,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  3'),			category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'LWin'}}},			down = iCommandViewSnapView4,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  4'),			category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'LWin'}}},			down = iCommandViewSnapView5,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  5'),			category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'LWin'}}},			down = iCommandViewSnapView6,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  6'),			category = _('View Cockpit')},
{combos = {{key = 'Num7', reformers = {'LWin'}}},			down = iCommandViewSnapView7,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  7'),			category = _('View Cockpit')},
{combos = {{key = 'Num8', reformers = {'LWin'}}},			down = iCommandViewSnapView8,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  8'),			category = _('View Cockpit')},
{combos = {{key = 'Num9', reformers = {'LWin'}}},			down = iCommandViewSnapView9,				up = iCommandViewSnapViewStop,		name = _('Custom Snap View  9'),			category = _('View Cockpit')},

{combos = {{key = 'Num*', reformers = {'RShift'}}},			pressed = iCommandViewForward,				up = iCommandViewForwardStop,		name = _('Zoom in'),						category = _('View Cockpit')},
{combos = {{key = 'Num/', reformers = {'RShift'}}},			pressed = iCommandViewBack,					up = iCommandViewBackStop,			name = _('Zoom out'),						category = _('View Cockpit')},

-- Extended view
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

-- Padlock
{combos = {{key = 'Num.'}},							down = iCommandViewLock,				name = _('Lock View (cycle padlock)'),	category = _('View Padlock')},
{combos = {{key = 'NumLock'}},						down = iCommandViewUnlock,				name = _('Unlock view (stop padlock)'),	category = _('View Padlock')},
{combos = {{key = 'Num.', reformers = {'RShift'}}},	down = iCommandAllMissilePadlock,		name = _('All missiles padlock'),		category = _('View Padlock')},
{combos = {{key = 'Num.', reformers = {'RAlt'}}},	down = iCommandThreatMissilePadlock,	name = _('Threat missile padlock'),		category = _('View Padlock')},
{combos = {{key = 'Num.', reformers = {'RCtrl'}}},	down = iCommandViewTerrainLock,			name = _('Lock terrain view'),			category = _('View Padlock')},

-- Labels
{combos = {{key = 'F10', reformers = {'LShift'}}},	down = iCommandMarkerState,				name = _('All Labels'),					category = _('Labels')},
{combos = {{key = 'F2', reformers = {'LShift'}}},	down = iCommandMarkerStatePlane,		name = _('Aircraft Labels'),			category = _('Labels')},
{combos = {{key = 'F6', reformers = {'LShift'}}},	down = iCommandMarkerStateRocket,		name = _('Missile Labels'),				category = _('Labels')},
{combos = {{key = 'F9', reformers = {'LShift'}}},	down = iCommandMarkerStateShip,			name = _('Vehicle & Ship Labels'),		category = _('Labels')},

--Kneeboard
{combos = {{key = 'K', reformers = {'RShift'}}},	down = iCommandPlaneShowKneeboard,																				name = _('Kneeboard ON/OFF'),						category = _('Kneeboard')},
{combos = {{key = 'K'}},							down = iCommandPlaneShowKneeboard,	up = iCommandPlaneShowKneeboard,	value_down = 1.0,	value_up = -1.0,	name = _('Kneeboard glance view'),					category = _('Kneeboard')},
{combos = {{key = ']'}},							down = 3001,	cockpit_device_id = kneeboard_id,						value_down = 1.0,						name = _('Kneeboard Next Page'),					category = _('Kneeboard')},
{combos = {{key = '['}},							down = 3002,	cockpit_device_id = kneeboard_id,						value_down = 1.0,						name = _('Kneeboard Previous Page'),				category = _('Kneeboard')},
{combos = {{key = 'K', reformers = {'RCtrl'}}},		down = 3003,	cockpit_device_id = kneeboard_id,						value_down = 1.0,						name = _('Kneeboard current position mark point'),	category = _('Kneeboard')},
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


-- Communications
{combos = {{key = '\\', reformers = {'RShift'}}, {key = 'M', reformers = {'RShift'}}},	down = iCommandToggleReceiveMode,	name = _('Receive Mode'),					category = _('Communications')},

-- Cockpit Camera Motion (Передвижение камеры в кабине)
{combos = {{key = 'N', reformers = {'RAlt'}}},	down = iCommandViewLeftMirrorOn ,	up = iCommandViewLeftMirrorOff ,	name = _('Mirror Left On'),		category = _('View Cockpit') , features = {"Mirrors"}},
{combos = {{key = 'M', reformers = {'RAlt'}}},	down = iCommandViewRightMirrorOn,	up = iCommandViewRightMirrorOff,	name = _('Mirror Right On'),	category = _('View Cockpit') , features = {"Mirrors"}},
{combos = {{key = 'M', reformers = {'RCtrl'} }},						down = iCommandToggleMirrors,											name = _('Toggle Mirrors'),		category = _('View Cockpit') , features = {"Mirrors"}},

-- Auto Lock On 
{combos = {{key = 'F5', reformers = {'RAlt'}}},		down = iCommandAutoLockOnNearestAircraft,		name = _('Auto lock on nearest aircraft'),			category = _('Simplifications')},
{combos = {{key = 'F6', reformers = {'RAlt'}}},		down = iCommandAutoLockOnCenterAircraft,		name = _('Auto lock on center aircraft'),			category = _('Simplifications')},
{combos = {{key = 'F7', reformers = {'RAlt'}}},		down = iCommandAutoLockOnNextAircraft,			name = _('Auto lock on next aircraft'),				category = _('Simplifications')},
{combos = {{key = 'F8', reformers = {'RAlt'}}},		down = iCommandAutoLockOnPreviousAircraft,		name = _('Auto lock on previous aircraft'),			category = _('Simplifications')},
{combos = {{key = 'F9', reformers = {'RAlt'}}},		down = iCommandAutoLockOnNearestSurfaceTarget,	name = _('Auto lock on nearest surface target'),	category = _('Simplifications')},
{combos = {{key = 'F10', reformers = {'RAlt'}}},	down = iCommandAutoLockOnCenterSurfaceTarget,	name = _('Auto lock on center surface target'),		category = _('Simplifications')},
{combos = {{key = 'F11', reformers = {'RAlt'}}},	down = iCommandAutoLockOnNextSurfaceTarget,		name = _('Auto lock on next surface target'),		category = _('Simplifications')},
{combos = {{key = 'F12', reformers = {'RAlt'}}},	down = iCommandAutoLockOnPreviousSurfaceTarget, name = _('Auto lock on previous surface target'),	category = _('Simplifications')},

----------------------------------------- end common keyboard bindings ---------------------------------------------------

},
}