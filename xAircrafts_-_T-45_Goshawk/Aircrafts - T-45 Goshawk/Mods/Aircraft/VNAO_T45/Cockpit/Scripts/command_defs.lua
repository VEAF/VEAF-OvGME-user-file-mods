local function counter()
	count = count + 1
	return count
end

count   = 10000

Keys =
{
	canopy 				= counter(),

	GearLever 			= counter(),
	LaunchBarToggle 	= counter(),
	HookToggle			= counter(),

	PlaneFireOn			= counter(), 
	PlaneFireOff		= counter(), 
    PickleOn 			= counter(),  
    PickleOff 			= counter(), 
    MasterArmToggle 	= counter(),
	
	cageButton			= counter(),
	
	Finger_Lift			= counter(),
    ToggleStick			= counter(),
	
	IntercomPTT			= counter(),
	
	FlapStepDown		= counter(),
	FlapStepUp			= counter(),
	
	Battery1Toggle		= counter(),
	Battery2Toggle		= counter(),
	
	SmokeOnOff			= counter(),

}

count   = 3010
EFM_commands = 	-- commands for use in EFM, DO NOT CHANGE unless changed in EFM too
{
	HookLever 			= counter(),
	SpeedBrakeSwitch	= counter(),
	FlapSwitch 			= counter(),
	NWSButton			= counter(),
	LaunchBarSwitch		= counter(),
	GearLever			= counter(),
	AntiSkidSwitch		= counter(),
	EmerGearRelease		= counter(),
	EngineSwitch		= counter(),
	BatterySwitch1		= counter(),
	BatterySwitch2		= counter(),
	GeneratorSwitch		= counter(),
	GTSbutton			= counter(),
	fingerLift			= counter(),
	HYD2reset			= counter(),
	PitotHeat			= counter(),
	EmerFlapSwitch		= counter(),
	strobeLight			= counter(),
	tailLights			= counter(),
	wingLights			= counter(),
	formationLights		= counter(),
	landingLight		= counter(),
	navLights			= counter(),
	floodLights			= counter(),
	consoleLights		= counter(),
	MIPLights			= counter(),
	lightsMaster		= counter(),
	parkBrake			= counter(),
	AltimeterSet		= counter(),
	MasterAlertReset	= counter(),
	rudderTrim			= counter(),
	CanopyLever			= counter(),
-- rear commands
	HookLeverRear 		= counter(),	
	FlapSwitchRear 		= counter(),
	LaunchBarSwitchRear		= counter(),	
	GearLeverRear			= counter(),
	AntiSkidSwitchRear		= counter(),
	EmerGearReleaseRear		= counter(),
	EngineSwitchRear		= counter(),	
	BatterySwitch1Rear		= counter(),
	BatterySwitch2Rear		= counter(),
	GeneratorSwitchRear		= counter(),
	
	floodLightsRear		= counter(),
	consoleLightsRear	= counter(),
	MIPLightsRear		= counter(),
	
	KeyRudderLeft		= counter(),
	KeyRudderRight		= counter(),
	KeyRudderStop		= counter(),
	
	ThrottleIncrease	= counter(),
	ThrottleDecrease	= counter(),
	
	SeatArmHandle 		= counter(),
	Eject				= counter(),
	EjectionHandle		= counter(),
}


count = 3500

device_commands = -- lua commands 
{
	emergencyJettison = counter(),
	masterArm = counter(),
	
	ignitionSwitch = counter(),
	ignitionSwitchCvr = counter(),
	FuelControl = counter(),

	HookBypass = counter(),

	TACANones = counter(),
	TACANtens = counter(),
	TACANpower = counter(),
	
	VORvolume = counter(),
	VORfreqOnes = counter(),
	VORfreqDecimal = counter(),
	VORpower = counter(),
	
	COMM1freqTens = counter(),
	COMM1freqOnes = counter(),
	COMM1freqTenths = counter(),
	COMM1freqHundredths = counter(),
	COMM1AMFM = counter(),
	COMM1vol = counter(),
	COMM1mode = counter(),
	COMM1brightness = counter(),
	
	COMM2freqTens = counter(),
	COMM2freqOnes = counter(),
	COMM2freqTenths = counter(),
	COMM2freqHundredths = counter(),
	COMM2AMFM = counter(),
	COMM2vol = counter(),
	COMM2mode = counter(),
	COMM2brightness = counter(),
	
	micSwitch = counter(),
	ICSvol = counter(),
	COMM1Switch = counter(),
	COMM2Switch = counter(),
	throttleMicSwitch = counter(),
	
	HUDPowerKnob = counter(),
	HUDBrtKnob = counter(),
	
	DEP1 = counter(),
	DEP2 = counter(),
	DEP3 = counter(),
	DEP4 = counter(),
	DEP5 = counter(),
	DEP6 = counter(),
	DEP7 = counter(),
	DEP8 = counter(),
	DEP9 = counter(),
	DEP0 = counter(),
	DEPenter = counter(),
	DEPclear = counter(),
	DEPdeclutter = counter(),
	DEPlaw = counter(),
	DEPcrs = counter(),
	DEPhdg = counter(),
	DEPbingo = counter(),
	DEPmode = counter(),
	DEPdepressionUp = counter(),
	DEPdepressionDown = counter(),
	
	AltimeterSet = counter(),
}

MFDL_commands = {
dayPower		= counter(),
nightPower		= counter(),
offSwitch		= counter(),
brightnessUp	= counter(),
brightnessDown	= counter(),
PB1 			= counter(),
PB2 			= counter(),
PB3 			= counter(),
PB4 			= counter(),
PB5 			= counter(),
PB6 			= counter(),
PB7 			= counter(),
PB8 			= counter(),
PB9 			= counter(),
PB10 			= counter(),
PB11 			= counter(),
PB12 			= counter(),
PB13 			= counter(),
PB14 			= counter(),
PB15 			= counter(),
PB16 			= counter(),
PB17 			= counter(),
PB18 			= counter(),
PB19 			= counter(),
PB20 			= counter(),
}

MFDR_commands = {
dayPower		= counter(),
nightPower		= counter(),
offSwitch		= counter(),
brightnessUp	= counter(),
brightnessDown	= counter(),
PB1 			= counter(),
PB2 			= counter(),
PB3 			= counter(),
PB4 			= counter(),
PB5 			= counter(),
PB6 			= counter(),
PB7 			= counter(),
PB8 			= counter(),
PB9 			= counter(),
PB10 			= counter(),
PB11 			= counter(),
PB12 			= counter(),
PB13 			= counter(),
PB14 			= counter(),
PB15 			= counter(),
PB16 			= counter(),
PB17 			= counter(),
PB18 			= counter(),
PB19 			= counter(),
PB20 			= counter(),
}