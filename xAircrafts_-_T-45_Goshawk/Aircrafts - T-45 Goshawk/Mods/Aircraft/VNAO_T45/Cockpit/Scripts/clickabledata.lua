dofile(LockOn_Options.script_path.."clickable_defs.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."sounds.lua")

local gettext = require("i_18n")
_ = gettext.translate

show_element_boxes = false --connector debug
elements = {}


elements["PNT_007"]	= default_3_position_tumb(_("Flaps Lever, UP/ 1/2 /DOWN"),		devices.EFM, EFM_commands.FlapSwitch,7,nil,nil,nil,0.5,{0,1})
elements["PNT_184"]	= default_2_position_tumb(_("EMER FLAPS Switch, NORM/DOWN"),	devices.EFM, EFM_commands.EmerFlapSwitch, 184)
elements["PNT_117"]	= default_animated_lever(_("Parking Brake Handle, OUT/IN"),		devices.EFM, EFM_commands.parkBrake,	117)
elements["PNT_066"] = default_button(_("HYD 2 Reset Button"), 						devices.EFM, EFM_commands.HYD2reset, 	66)
elements["PNT_180"]	= default_2_position_tumb(_("Pitot Heat Switch, HEAT/OFF"),		devices.EFM, EFM_commands.PitotHeat,	180)
elements["PNT_165"]	= default_axis(_("Altimeter Setting Knob"), 					devices.AVIONICS, device_commands.AltimeterSet, 165, 0.04, 1, false, true)
elements["PNT_001"]	= default_animated_lever(_("Canopy Handle, OPEN/CLOSE"), devices.EFM, EFM_commands.CanopyLever, 116)
--elements["PNT-46"]	= default_button(_("Canopy Jettison, Pull to Jettison"),devices.EXTERNALMECHANICS, device_commands.CanopyJettisonHandle,	46)
elements["PNT_143"] = default_button(_("Master Alert Button - Push To Reset"), 	devices.EFM, EFM_commands.MasterAlertReset, 143)
elements["PNT_092"] = default_3_position_tumb(_("Control Aug Switch, ALL/SBI/RESET"),				devices.FLAPS, device_commands.ContAug,92)
elements["PNT_012"]		= default_axis_limited(_("Rudder Trim Knob"),			devices.EFM,	EFM_commands.rudderTrim,	12, 0, 0.15, false, false, {-1, 1})
--elements["PNT_187"]		= default_axis_limited(_("Clock_Adj"),			devices.EFM,	EFM_commands.rudderTrim,	187, 0, 0.15, false, false, {-1, 1})

elements["PNT_265"]	= default_2_position_tumb(_("Seat Arming Handle, SAFE/ARMED"),	devices.EFM, EFM_commands.SeatArmHandle, 265)
elements["PNT_264"] = default_button(_("Ejection Handle - Pull To Eject"), 	devices.EFM, EFM_commands.EjectionHandle, 264)


-- Electric system
elements["PNT_300"]	= default_2_position_tumb(_("Battery 1 Switch, ON/OFF"),	devices.EFM, EFM_commands.BatterySwitch1,	300)
elements["PNT_301"]	= default_2_position_tumb(_("Battery 2 Switch, ON/OFF"),	devices.EFM, EFM_commands.BatterySwitch2,	301)
elements["PNT_303"]	= switch_button_3pos(_("Generator Switch, ON/OFF/RESET"),	devices.EFM, EFM_commands.GeneratorSwitch,	303)


-- Fuel System
--elements["PNT_096"]		= default_2_position_tumb2(_("Fuel Control Switch, NORMAL/MANUAL"),	devices.FUEL_SYSTEM,	device_commands.FuelControl,			96)

-- Engine
elements["PNT_005"]	= default_2_position_tumb(_("Finger Lift"), devices.EFM, EFM_commands.fingerLift, 0)
elements["PNT_011"]	= switch_button_3pos(_("Engine Switch, OFF/ON/START"), devices.EFM,  EFM_commands.EngineSwitch,  11)
--elements["PNT_094"]		= default_red_cover(_("Ignition Switch Cover, OPEN/CLOSED"),	devices.ENGINE,	device_commands.ignitionSwitchCvr,94)
--elements["PNT_093"]		= default_2_position_tumb(_("Ignition Switch, NORMAL/ISOLATE"),		devices.ENGINE,	device_commands.ignitionSwitch,		93)
elements["PNT_035"] = default_button(_("Gas Turbine Starter Button"), devices.EFM, EFM_commands.GTSbutton, 35)


-- Gear System
elements["PNT_006"]	= default_animated_lever(_("Landing Gear Lever, UP/DOWN"),			devices.EFM, 	EFM_commands.GearLever,		6)
elements["PNT_008"]	= default_animated_lever(_("Tail Hook Lever, UP/DOWN"),				devices.EFM, 	EFM_commands.HookLever,		8)
elements["PNT_010"]	= default_2_position_tumb(_("Anti-Skid Switch, OFF/ON"),			devices.EFM, 	EFM_commands.AntiSkidSwitch,		10)
--elements["PNT_181"]	= default_2_position_tumb(_("Hook Bypass, CARRIER/FIELD"), 		devices.EXT_LIGHTS, device_commands.HookBypass,  181)
elements["PNT_183"]	= default_2_position_tumb(_("Landing Gear Emergency Release Handle"), devices.EFM, EFM_commands.EmerGearRelease,	183)
elements["PNT_067"]	= default_2_position_tumb(_("Launch Bar Switch, UP/DOWN"),					devices.EFM, 	EFM_commands.LaunchBarSwitch ,		67)


-- Weapon System
elements["PNT_182"] = default_button(_("Emergency Jettison Button"), 	devices.WEAPON_SYSTEM, device_commands.emergencyJettison, 182)
elements["PNT_114"]	= default_2_position_tumb(_("Master Arm, ARM/SAFE"), devices.WEAPON_SYSTEM,	device_commands.masterArm,		114)


-- External Lighting
elements["PNT_402"]	= default_3_position_tumb(_("Anti-Collision/Strobe Lights, BOTH/OFF/A-COLL"), devices.EFM, EFM_commands.strobeLight,  402)
elements["PNT_404"]	= default_3_position_tumb(_("Tail Lights, BRIGHT/OFF/DIM"), devices.EFM, EFM_commands.tailLights,  404)
elements["PNT_405"]	= default_3_position_tumb(_("Wing Lights, BRIGHT/OFF/DIM"), devices.EFM, EFM_commands.wingLights,  405)
elements["PNT_406"]	= default_3_position_tumb(_("Formation Lights, BRIGHT/OFF/DIM"), devices.EFM, EFM_commands.formationLights,  406)
elements["PNT_401"]	= default_2_position_tumb(_("Landing/Taxi Light, ON/OFF"), devices.EFM, EFM_commands.landingLight,  401)
elements["PNT_403"]	= default_2_position_tumb(_("Nav Lights, FLASH/STEADY"), devices.EFM, EFM_commands.navLights,  403)
elements["PNT_400"] = default_springloaded_switch(_("Exterior Lights Master Switch"), devices.EFM, EFM_commands.lightsMaster, -1,0,1, 400) 

-- Internal Lighting
elements["PNT_452"] = default_axis(_("Flood Lights Knob"),		devices.EFM, EFM_commands.floodLights,		452)
elements["PNT_451"] = default_axis(_("Console Lights Knob"),	devices.EFM, EFM_commands.consoleLights,	451)
elements["PNT_450"] = default_axis(_("MIP Lights Knob"),		devices.EFM, EFM_commands.MIPLights,		450)

-- HUD
elements["PNT_219"]		= default_2_position_tumb(_("HUD Power Knob, ON/OFF"),			devices.HUD,	device_commands.HUDPowerKnob,		219)
elements["PNT_221"]		= default_axis_limited(_("HUD Brightness Knob"),			devices.HUD,	device_commands.HUDBrtKnob,		221, 1, 0.15, false, false, {0.01, 1})

-- Data Entry Panel (DEP)
elements["PNT_200"]		= default_button(_("0"), 	devices.DEP, device_commands.DEP0, 200)
elements["PNT_201"]		= default_button(_("1"), 	devices.DEP, device_commands.DEP1, 201)
elements["PNT_202"]		= default_button(_("2"), 	devices.DEP, device_commands.DEP2, 202)
elements["PNT_203"]		= default_button(_("3"), 	devices.DEP, device_commands.DEP3, 203)
elements["PNT_204"]		= default_button(_("4"), 	devices.DEP, device_commands.DEP4, 204)
elements["PNT_205"]		= default_button(_("5"), 	devices.DEP, device_commands.DEP5, 205)
elements["PNT_206"]		= default_button(_("6"), 	devices.DEP, device_commands.DEP6, 206)
elements["PNT_207"]		= default_button(_("7"), 	devices.DEP, device_commands.DEP7, 207)
elements["PNT_208"]		= default_button(_("8"), 	devices.DEP, device_commands.DEP8, 208)
elements["PNT_209"]		= default_button(_("9"), 	devices.DEP, device_commands.DEP9, 209)
elements["PNT_211"]		= default_button(_("Enter"),devices.DEP, device_commands.DEPenter, 211)
elements["PNT_212"]		= default_button(_("Clear"), 	devices.DEP, device_commands.DEPclear, 212)
elements["PNT_210"]		= default_button(_("Declutter"), 	devices.DEP, device_commands.DEPdeclutter, 210)
elements["PNT_214"]		= default_button(_("Low Altitude Warning Set"), 	devices.DEP, device_commands.DEPlaw, 214)
elements["PNT_215"]		= default_button(_("Course Set"), 	devices.DEP, device_commands.DEPcrs, 215)
elements["PNT_216"]		= default_button(_("Heading Set"), 	devices.DEP, device_commands.DEPhdg, 216)
elements["PNT_217"]		= default_button(_("Bingo Set"), 	devices.DEP, device_commands.DEPbingo, 217)
elements["PNT_218"]		= default_button(_("Master Mode"), 	devices.DEP, device_commands.DEPmode, 218)
elements["PNT_223"]		= default_button(_("Mil Depression Increase"), 	devices.DEP, device_commands.DEPdepressionUp, 223)
elements["PNT_224"]		= default_button(_("Mil Depression Decrease"), 	devices.DEP, device_commands.DEPdepressionDown, 224)

-- MFD Left ----
elements["PNT_424"]		= default_button(_("MFD On Day"),	devices.MFDL, MFDL_commands.dayPower,424)
elements["PNT_425"]		= default_button(_("MFD On Night"),	devices.MFDL, MFDL_commands.nightPower,425)
elements["PNT_426"]		= default_button(_("MFD Off"),	devices.MFDL, MFDL_commands.offSwitch,426)
elements["PNT_422"] 	= default_button(_("MFD Brightness Increase"),	devices.MFDL, MFDL_commands.brightnessUp,		422)
elements["PNT_423"] 	= default_button(_("MFD Brightness Decrease"),	devices.MFDL, MFDL_commands.brightnessDown,		423)
elements["PNT_034"]		= default_button(_("Push Button 20"),	devices.MFDL, MFDL_commands.PB20,34)
elements["PNT_033"]		= default_button(_("Push Button 19"),	devices.MFDL, MFDL_commands.PB19,33)
elements["PNT_032"]		= default_button(_("Push Button 18"),	devices.MFDL, MFDL_commands.PB18,32)
elements["PNT_031"]		= default_button(_("Push Button 17"),	devices.MFDL, MFDL_commands.PB17,31)
elements["PNT_030"]		= default_button(_("Push Button 16"),	devices.MFDL, MFDL_commands.PB16,30)
elements["PNT_029"]		= default_button(_("Push Button 15"),	devices.MFDL, MFDL_commands.PB15,29)
elements["PNT_028"]		= default_button(_("Push Button 14"),	devices.MFDL, MFDL_commands.PB14,28)
elements["PNT_027"]		= default_button(_("Push Button 13"),	devices.MFDL, MFDL_commands.PB13,27)
elements["PNT_026"]		= default_button(_("Push Button 12"),	devices.MFDL, MFDL_commands.PB12,26)
elements["PNT_025"]		= default_button(_("Push Button 11"),	devices.MFDL, MFDL_commands.PB11,25)
elements["PNT_024"]		= default_button(_("Push Button 10"),	devices.MFDL, MFDL_commands.PB10,24)
elements["PNT_023"]		= default_button(_("Push Button 9"),	devices.MFDL, MFDL_commands.PB9,23)
elements["PNT_022"]		= default_button(_("Push Button 8"),	devices.MFDL, MFDL_commands.PB8,22)
elements["PNT_021"]		= default_button(_("Push Button 7"),	devices.MFDL, MFDL_commands.PB7,21)
elements["PNT_020"]		= default_button(_("Push Button 6"),	devices.MFDL, MFDL_commands.PB6,20)
elements["PNT_019"]		= default_button(_("Push Button 5"),	devices.MFDL, MFDL_commands.PB5,19)
elements["PNT_018"]		= default_button(_("Push Button 4"),	devices.MFDL, MFDL_commands.PB4,18)
elements["PNT_017"]		= default_button(_("Push Button 3"),	devices.MFDL, MFDL_commands.PB3,17)
elements["PNT_016"]		= default_button(_("Push Button 2"),	devices.MFDL, MFDL_commands.PB2,16)
elements["PNT_015"]		= default_button(_("Push Button 1"),	devices.MFDL, MFDL_commands.PB1,15)

-- MFD Right ----
elements["PNT_434"]		= default_button(_("MFD On Day"),	devices.MFDR, MFDR_commands.dayPower,434)
elements["PNT_435"]		= default_button(_("MFD On Night"),	devices.MFDR, MFDR_commands.nightPower,435)
elements["PNT_436"]		= default_button(_("MFD Off"),	devices.MFDR, MFDR_commands.offSwitch,436)
elements["PNT_432"] 	= default_button(_("MFD Brightness Increase"),	devices.MFDR, MFDR_commands.brightnessUp,		432)
elements["PNT_433"] 	= default_button(_("MFD Brightness Decrease"),	devices.MFDR, MFDR_commands.brightnessDown,		433)
elements["PNT_059"]		= default_button(_("Push Button 20"),	devices.MFDR, MFDR_commands.PB20,59)
elements["PNT_058"]		= default_button(_("Push Button 19"),	devices.MFDR, MFDR_commands.PB19,58)
elements["PNT_057"]		= default_button(_("Push Button 18"),	devices.MFDR, MFDR_commands.PB18,57)
elements["PNT_056"]		= default_button(_("Push Button 17"),	devices.MFDR, MFDR_commands.PB17,56)
elements["PNT_055"]		= default_button(_("Push Button 16"),	devices.MFDR, MFDR_commands.PB16,55)
elements["PNT_054"]		= default_button(_("Push Button 15"),	devices.MFDR, MFDR_commands.PB15,54)
elements["PNT_053"]		= default_button(_("Push Button 14"),	devices.MFDR, MFDR_commands.PB14,53)
elements["PNT_052"]		= default_button(_("Push Button 13"),	devices.MFDR, MFDR_commands.PB13,52)
elements["PNT_051"]		= default_button(_("Push Button 12"),	devices.MFDR, MFDR_commands.PB12,51)
elements["PNT_050"]		= default_button(_("Push Button 11"),	devices.MFDR, MFDR_commands.PB11,50)
elements["PNT_049"]		= default_button(_("Push Button 10"),	devices.MFDR, MFDR_commands.PB10,49)
elements["PNT_048"]		= default_button(_("Push Button 9"),	devices.MFDR, MFDR_commands.PB9,48)
elements["PNT_047"]		= default_button(_("Push Button 8"),	devices.MFDR, MFDR_commands.PB8,47)
elements["PNT_046"]		= default_button(_("Push Button 7"),	devices.MFDR, MFDR_commands.PB7,46)
elements["PNT_045"]		= default_button(_("Push Button 6"),	devices.MFDR, MFDR_commands.PB6,45)
elements["PNT_044"]		= default_button(_("Push Button 5"),	devices.MFDR, MFDR_commands.PB5,44)
elements["PNT_043"]		= default_button(_("Push Button 4"),	devices.MFDR, MFDR_commands.PB4,43)
elements["PNT_042"]		= default_button(_("Push Button 3"),	devices.MFDR, MFDR_commands.PB3,42)
elements["PNT_041"]		= default_button(_("Push Button 2"),	devices.MFDR, MFDR_commands.PB2,41)
elements["PNT_040"]		= default_button(_("Push Button 1"),	devices.MFDR, MFDR_commands.PB1,40)


-- COMM control panel
elements["PNT_196"] = default_2_position_tumb(_("MIC Switch, HOT/COLD"),	devices.COMM1, device_commands.micSwitch, 196)
elements["PNT_191"] = default_2_position_tumb(_("COMM 1 Switch"),	devices.COMM1, device_commands.COMM1Switch, 191)
elements["PNT_192"] = default_2_position_tumb(_("COMM 2 Switch"),	devices.COMM1, device_commands.COMM2Switch, 192)
elements["PNT_198"] = default_axis(_("Intercom Volume"),	devices.COMM1, device_commands.ICSvol,		198)
elements["PNT_294"] = springloaded_3_pos_tumb(_("Microphone Button, COMM 1/COMM 2"),	devices.COMM1,	device_commands.throttleMicSwitch, device_commands.throttleMicSwitch, 294)


--- V/UHF control panel 1
elements["PNT_250"] = springloaded_3_pos_tumb(_("COMM 1 Frequency Tens"),	devices.COMM1,	device_commands.COMM1freqTens, device_commands.COMM1freqTens, 250)
elements["PNT_251"] = springloaded_3_pos_tumb(_("COMM 1 Frequency Ones"),	devices.COMM1, device_commands.COMM1freqOnes,	device_commands.COMM1freqOnes, 251)
elements["PNT_252"] = springloaded_3_pos_tumb(_("COMM 1 Frequency Tenths"),	devices.COMM1, device_commands.COMM1freqTenths,	device_commands.COMM1freqTenths,  252)
elements["PNT_253"] = springloaded_3_pos_tumb(_("COMM 1 Frequency Hundredths"),	devices.COMM1, device_commands.COMM1freqHundredths,	device_commands.COMM1freqHundredths, 253)
elements["PNT_254"] = default_2_position_tumb(_("COMM 1 AM/FM Mode Switch, AM/FM"),	devices.COMM1, device_commands.COMM1AMFM,		254)
elements["PNT_246"] = default_axis(_("COMM 1 Volume"),						devices.COMM1, device_commands.COMM1vol,		246)
elements["PNT_256"] = default_3_position_tumb(_("COMM 1 Mode Control Selector, OFF/T+R/T+R&G"),	devices.COMM1, device_commands.COMM1mode,	256, nil, nil, nil, 0.25, {0,0.5})
elements["PNT_255"] = default_axis(_("COMM 1 Brightness"),					devices.COMM1, device_commands.COMM1brightness,		255)

--- V/UHF control panel 2
elements["PNT_274"] = springloaded_3_pos_tumb(_("COMM 2 Frequency Tens"),	devices.COMM2,	device_commands.COMM2freqTens, device_commands.COMM2freqTens, 274)
elements["PNT_275"] = springloaded_3_pos_tumb(_("COMM 2 Frequency Ones"),	devices.COMM2, device_commands.COMM2freqOnes,	device_commands.COMM2freqOnes, 275)
elements["PNT_276"] = springloaded_3_pos_tumb(_("COMM 2 Frequency Tenths"),	devices.COMM2, device_commands.COMM2freqTenths,	device_commands.COMM2freqTenths,  276)
elements["PNT_277"] = springloaded_3_pos_tumb(_("COMM 2 Frequency Hundredths"),	devices.COMM2, device_commands.COMM2freqHundredths,	device_commands.COMM2freqHundredths, 277)
elements["PNT_278"] = default_2_position_tumb(_("COMM 2 AM/FM Mode Switch, AM/FM"),	devices.COMM2, device_commands.COMM2AMFM,		278)
elements["PNT_270"] = default_axis(_("COMM 2 Volume"),						devices.COMM2, device_commands.COMM2vol,		270)
elements["PNT_280"] = default_3_position_tumb(_("COMM 2 Mode Control Selector, OFF/T+R/T+R&G"),	devices.COMM2, device_commands.COMM2mode,	280, nil, nil, nil, 0.25, {0,0.5})
elements["PNT_279"] = default_axis(_("COMM 2 Brightness"),					devices.COMM2, device_commands.COMM2brightness,		279)


-- VOR ILS
elements["PNT_230"]	= multiposition_switch(_("VOR/ILS 1MHz Frequency Knob"),	devices.VOR_ILS, device_commands.VORfreqOnes, 230, 10, 0.10, false, 0, 3, false)
elements["PNT_232"]	= multiposition_switch(_("VOR/ILS 50KHz Frequency Knob"),	devices.VOR_ILS, device_commands.VORfreqDecimal, 232, 20, 0.05, false, 0, 3, false)
elements["PNT_231"]	= multiposition_switch(_("VOR/ILS Power Knob"),				devices.VOR_ILS, device_commands.VORpower, 231, 3, 0.5, false, 0, 3, false)

-- TACAN
elements["PNT_241"]	= default_2_position_tumb(_("TACAN Power Switch, ON/OFF"),	devices.TACAN, device_commands.TACANpower,		241)
elements["PNT_245"]	= multiposition_switch_cl(_("TACAN Channel Selector Ones"),	devices.TACAN, device_commands.TACANones, 245, 10, 0.10, false, 0, 3, true)
elements["PNT_242"]	= multiposition_switch_cl(_("TACAN Channel Selector Tens"),	devices.TACAN, device_commands.TACANtens, 242, 20, 0.05, false, 0, 3, true)

-----------------------------------
-------- REAR Pit Clickables ------

-- Misc Systems REAR
elements["PNT_002"]	= default_animated_lever(_("Canopy Handle, OPEN/CLOSE"), devices.EFM, EFM_commands.CanopyLever, 116)
elements["PNT_003"]	= default_animated_lever(_("Parking Brake Handle, OUT/IN"),		devices.EFM, EFM_commands.parkBrake,	117)
elements["PNT_004"]	= default_animated_lever(_("Tail Hook Lever, UP/DOWN"),				devices.EFM, 	EFM_commands.HookLeverRear,		8)
elements["PNT_060"]	= default_2_position_tumb(_("Finger Lift"), 					devices.EFM, EFM_commands.fingerLift, 0)
elements["PNT_069"]	= switch_button_3pos(_("Engine Switch, OFF/ON/START"),			devices.EFM,  EFM_commands.EngineSwitchRear,  11)
elements["PNT_071"]	= default_axis_limited(_("Rudder Trim Knob"),			devices.EFM,	EFM_commands.rudderTrim,	12, 0, 0.15, false, false, {-1, 1})
elements["PNT_074"] = default_button(_("HYD 2 Reset Button"), 						devices.EFM, EFM_commands.HYD2reset, 	66)
elements["PNT_186"]	= default_2_position_tumb(_("EMER FLAPS Switch, NORM/DOWN"),	devices.EFM, EFM_commands.EmerFlapSwitch, 184)
elements["PNT_038"]	= default_3_position_tumb(_("Flaps Lever, UP/ 1/2 /DOWN"),		devices.EFM, EFM_commands.FlapSwitchRear,7,nil,nil,nil,0.5,{0,1})
elements["PNT_190"]	= default_axis(_("Altimeter Setting Knob"), 					devices.AVIONICS, device_commands.AltimeterSet, 165, 0.04, 1, false, true)
elements["PNT_068"] = default_button(_("Master Alert Button - Push To Reset"), 	devices.EFM, EFM_commands.MasterAlertReset, 143)
elements["PNT_185"]	= default_2_position_tumb(_("Pitot Heat Switch, HEAT/OFF"),		devices.EFM, EFM_commands.PitotHeat,	180)
elements["PNT_065"]	= default_2_position_tumb(_("Hook Bypass, CARRIER/FIELD"), 		devices.EXT_LIGHTS, device_commands.HookBypass,  181)
elements["PNT_093"] = default_3_position_tumb(_("Control Aug Switch, ALL/SBI/RESET"),				devices.FLAPS, device_commands.ContAug,92)

-- Electric system REAR
elements["PNT_310"]	= default_2_position_tumb(_("Battery 1 Switch, ON/OFF"),	devices.EFM, EFM_commands.BatterySwitch1Rear,	300)
elements["PNT_311"]	= default_2_position_tumb(_("Battery 2 Switch, ON/OFF"),	devices.EFM, EFM_commands.BatterySwitch2Rear,	301)
elements["PNT_312"]	= switch_button_3pos(_("Generator Switch, ON/OFF/RESET"),	devices.EFM, EFM_commands.GeneratorSwitchRear,	303)

-- External Lighting REAR
--elements["PNT_402"]	= default_3_position_tumb(_("Anti-Collision/Strobe Lights, BOTH/OFF/A-COLL"), devices.EFM, EFM_commands.strobeLight,  402)
--elements["PNT_404"]	= default_3_position_tumb(_("Tail Lights, BRIGHT/OFF/DIM"), devices.EFM, EFM_commands.tailLights,  404)
--elements["PNT_405"]	= default_3_position_tumb(_("Wing Lights, BRIGHT/OFF/DIM"), devices.EFM, EFM_commands.wingLights,  405)
--elements["PNT_406"]	= default_3_position_tumb(_("Formation Lights, BRIGHT/OFF/DIM"), devices.EFM, EFM_commands.formationLights,  406)
--elements["PNT_401"]	= default_2_position_tumb(_("Landing/Taxi Light, ON/OFF"), devices.EFM, EFM_commands.landingLight,  401)
--elements["PNT_403"]	= default_2_position_tumb(_("Nav Lights, FLASH/STEADY"), devices.EFM, EFM_commands.navLights,  403)

-- Internal Lighting REAR
elements["PNT_453"] = default_axis(_("MIP Lights Knob"),		devices.EFM, EFM_commands.MIPLightsRear,		453)
elements["PNT_454"] = default_axis(_("Console Lights Knob"),	devices.EFM, EFM_commands.consoleLightsRear,	454)
elements["PNT_455"] = default_axis(_("Flood Lights Knob"),		devices.EFM, EFM_commands.floodLightsRear,		455)


-- Weapon System REAR
elements["PNT_116"] = default_button(_("Emergency Jettison Button"), 	devices.WEAPON_SYSTEM, device_commands.emergencyJettison, 182)
elements["PNT_115"]	= default_2_position_tumb(_("Master Arm, ARM/SAFE"), devices.WEAPON_SYSTEM,	device_commands.masterArm,		114)

-- Gear System REAR
elements["PNT_061"]	= default_animated_lever(_("Landing Gear Lever, UP/DOWN"),			devices.EFM, 	EFM_commands.GearLeverRear,		6)
elements["PNT_062"]	= default_2_position_tumb(_("Anti-Skid Switch, OFF/ON"),			devices.EFM, 	EFM_commands.AntiSkidSwitchRear,		10)
--elements["PNT_065"]	= default_2_position_tumb(_("Hook Bypass, CARRIER/FIELD"), 		devices.EXT_LIGHTS, device_commands.HookBypass,  181)
elements["PNT_063"]	= default_2_position_tumb(_("Landing Gear Emergency Release Handle"), devices.EFM, EFM_commands.EmerGearReleaseRear,	183)
elements["PNT_064"]	= default_2_position_tumb(_("Launch Bar Switch, UP/DOWN"),					devices.EFM, 	EFM_commands.LaunchBarSwitchRear ,		67)

-- VOR ILS REAR
elements["PNT_234"]	= multiposition_switch(_("VOR/ILS 1MHz Frequency Knob"),	devices.VOR_ILS, device_commands.VORfreqOnes, 230, 10, 0.10, false, 0, 3, false)
elements["PNT_236"]	= multiposition_switch(_("VOR/ILS 50KHz Frequency Knob"),	devices.VOR_ILS, device_commands.VORfreqDecimal, 232, 20, 0.05, false, 0, 3, false)
elements["PNT_235"]	= multiposition_switch(_("VOR/ILS Power Knob"),				devices.VOR_ILS, device_commands.VORpower, 231, 3, 0.5, false, 0, 3, false)

-- TACAN REAR
elements["PNT_237"]	= default_2_position_tumb(_("TACAN Power Switch, ON/OFF"),	devices.TACAN, device_commands.TACANpower,		241)
elements["PNT_239"]	= multiposition_switch_cl(_("TACAN Channel Selector Ones"),	devices.TACAN, device_commands.TACANones, 245, 10, 0.10, false, 0, 3, true)
elements["PNT_238"]	= multiposition_switch_cl(_("TACAN Channel Selector Tens"),	devices.TACAN, device_commands.TACANtens, 242, 20, 0.05, false, 0, 3, true)

-- COMM control panel REAR
elements["PNT_110"] = default_2_position_tumb(_("MIC Switch, HOT/COLD"),	devices.COMM1, device_commands.micSwitch, 196)
elements["PNT_108"] = default_2_position_tumb(_("COMM 1 Switch"),	devices.COMM1, device_commands.COMM1Switch, 191)
elements["PNT_109"] = default_2_position_tumb(_("COMM 2 Switch"),	devices.COMM1, device_commands.COMM2Switch, 192)
elements["PNT_111"] = default_axis(_("Intercom Volume"),	devices.COMM1, device_commands.ICSvol,		198)
elements["PNT_112"] = springloaded_3_pos_tumb(_("Microphone Button, COMM 1/COMM 2"),	devices.COMM1,	device_commands.throttleMicSwitch, device_commands.throttleMicSwitch, 294)

--- V/UHF control panel 1 REAR
elements["PNT_102"] = springloaded_3_pos_tumb(_("COMM 1 Frequency Tens"),	devices.COMM1,	device_commands.COMM1freqTens, device_commands.COMM1freqTens, 250)
elements["PNT_103"] = springloaded_3_pos_tumb(_("COMM 1 Frequency Ones"),	devices.COMM1, device_commands.COMM1freqOnes,	device_commands.COMM1freqOnes, 251)
elements["PNT_104"] = springloaded_3_pos_tumb(_("COMM 1 Frequency Tenths"),	devices.COMM1, device_commands.COMM1freqTenths,	device_commands.COMM1freqTenths,  252)
elements["PNT_105"] = springloaded_3_pos_tumb(_("COMM 1 Frequency Hundredths"),	devices.COMM1, device_commands.COMM1freqHundredths,	device_commands.COMM1freqHundredths, 253)
elements["PNT_106"] = default_2_position_tumb(_("COMM 1 AM/FM Mode Switch, AM/FM"),	devices.COMM1, device_commands.COMM1AMFM,		254)
elements["PNT_100"] = default_axis(_("COMM 1 Volume"),						devices.COMM1, device_commands.COMM1vol,		246)
elements["PNT_101"] = default_3_position_tumb(_("COMM 1 Mode Control Selector, OFF/T+R/T+R&G"),	devices.COMM1, device_commands.COMM1mode,	256, nil, nil, nil, 0.25, {0,0.5})
elements["PNT_107"] = default_axis(_("COMM 1 Brightness"),					devices.COMM1, device_commands.COMM1brightness,		255)

--- V/UHF control panel 2 REAR
elements["PNT_282"] = springloaded_3_pos_tumb(_("COMM 2 Frequency Tens"),	devices.COMM2,	device_commands.COMM2freqTens, device_commands.COMM2freqTens, 274)
elements["PNT_283"] = springloaded_3_pos_tumb(_("COMM 2 Frequency Ones"),	devices.COMM2, device_commands.COMM2freqOnes,	device_commands.COMM2freqOnes, 275)
elements["PNT_284"] = springloaded_3_pos_tumb(_("COMM 2 Frequency Tenths"),	devices.COMM2, device_commands.COMM2freqTenths,	device_commands.COMM2freqTenths,  276)
elements["PNT_285"] = springloaded_3_pos_tumb(_("COMM 2 Frequency Hundredths"),	devices.COMM2, device_commands.COMM2freqHundredths,	device_commands.COMM2freqHundredths, 277)
elements["PNT_286"] = default_2_position_tumb(_("COMM 2 AM/FM Mode Switch, AM/FM"),	devices.COMM2, device_commands.COMM2AMFM,		278)
elements["PNT_281"] = default_axis(_("COMM 2 Volume"),						devices.COMM2, device_commands.COMM2vol,		270)
elements["PNT_288"] = default_3_position_tumb(_("COMM 2 Mode Control Selector, OFF/T+R/T+R&G"),	devices.COMM2, device_commands.COMM2mode,	280, nil, nil, nil, 0.25, {0,0.5})
elements["PNT_287"] = default_axis(_("COMM 2 Brightness"),					devices.COMM2, device_commands.COMM2brightness,		279)

-- HUD REAR
elements["PNT_345"]	= default_2_position_tumb(_("HUD Power Knob, ON/OFF"),			devices.HUD,	device_commands.HUDPowerKnob,		219)
elements["PNT_346"]	= default_axis_limited(_("HUD Brightness Knob"),			devices.HUD,	device_commands.HUDBrtKnob,		221, 1, 0.15, false, false, {0.01, 1})

-- Data Entry Panel (DEP) REAR
elements["PNT_335"]	= default_button(_("0"), 	devices.DEP, device_commands.DEP0, 200)
elements["PNT_325"]	= default_button(_("1"), 	devices.DEP, device_commands.DEP1, 201)
elements["PNT_326"]	= default_button(_("2"), 	devices.DEP, device_commands.DEP2, 202)
elements["PNT_327"]	= default_button(_("3"), 	devices.DEP, device_commands.DEP3, 203)
elements["PNT_328"]	= default_button(_("4"), 	devices.DEP, device_commands.DEP4, 204)
elements["PNT_329"]	= default_button(_("5"), 	devices.DEP, device_commands.DEP5, 205)
elements["PNT_330"]	= default_button(_("6"), 	devices.DEP, device_commands.DEP6, 206)
elements["PNT_331"]	= default_button(_("7"), 	devices.DEP, device_commands.DEP7, 207)
elements["PNT_332"]	= default_button(_("8"), 	devices.DEP, device_commands.DEP8, 208)
elements["PNT_333"]	= default_button(_("9"), 	devices.DEP, device_commands.DEP9, 209)
elements["PNT_334"]	= default_button(_("Enter"),devices.DEP, device_commands.DEPenter, 211)
elements["PNT_336"]	= default_button(_("Clear"), 	devices.DEP, device_commands.DEPclear, 212)
elements["PNT_337"]	= default_button(_("Declutter"), 	devices.DEP, device_commands.DEPdeclutter, 210)
elements["PNT_338"]	= default_button(_("Low Altitude Warning Set"), 	devices.DEP, device_commands.DEPlaw, 214)
elements["PNT_339"]	= default_button(_("Course Set"), 	devices.DEP, device_commands.DEPcrs, 215)
elements["PNT_340"]	= default_button(_("Heading Set"), 	devices.DEP, device_commands.DEPhdg, 216)
elements["PNT_341"]	= default_button(_("Bingo Set"), 	devices.DEP, device_commands.DEPbingo, 217)
elements["PNT_342"]	= default_button(_("Master Mode"), 	devices.DEP, device_commands.DEPmode, 218)
elements["PNT_343"]	= default_button(_("Mil Depression Increase"), 	devices.DEP, device_commands.DEPdepressionUp, 223)
elements["PNT_344"]	= default_button(_("Mil Depression Decrease"), 	devices.DEP, device_commands.DEPdepressionDown, 224)

-- Rear MFD Left
elements["PNT_372"]	= default_button(_("MFD On Day"),	devices.MFDL, MFDL_commands.dayPower,424)
elements["PNT_442"]	= default_button(_("MFD On Night"),	devices.MFDL, MFDL_commands.nightPower,425)
elements["PNT_443"]	= default_button(_("MFD Off"),	devices.MFDL, MFDL_commands.offSwitch,426)
elements["PNT_371"] = default_button(_("MFD Brightness Increase"),	devices.MFDL, MFDL_commands.brightnessUp,		422)
elements["PNT_441"] = default_button(_("MFD Brightness Decrease"),	devices.MFDL, MFDL_commands.brightnessDown,		423)
elements["PNT_369"]	= default_button(_("Push Button 20"),	devices.MFDL, MFDL_commands.PB20,34)
elements["PNT_368"]	= default_button(_("Push Button 19"),	devices.MFDL, MFDL_commands.PB19,33)
elements["PNT_367"]	= default_button(_("Push Button 18"),	devices.MFDL, MFDL_commands.PB18,32)
elements["PNT_366"]	= default_button(_("Push Button 17"),	devices.MFDL, MFDL_commands.PB17,31)
elements["PNT_365"]	= default_button(_("Push Button 16"),	devices.MFDL, MFDL_commands.PB16,30)
elements["PNT_364"]	= default_button(_("Push Button 15"),	devices.MFDL, MFDL_commands.PB15,29)
elements["PNT_363"]	= default_button(_("Push Button 14"),	devices.MFDL, MFDL_commands.PB14,28)
elements["PNT_362"]	= default_button(_("Push Button 13"),	devices.MFDL, MFDL_commands.PB13,27)
elements["PNT_361"]	= default_button(_("Push Button 12"),	devices.MFDL, MFDL_commands.PB12,26)
elements["PNT_360"]	= default_button(_("Push Button 11"),	devices.MFDL, MFDL_commands.PB11,25)
elements["PNT_359"]	= default_button(_("Push Button 10"),	devices.MFDL, MFDL_commands.PB10,24)
elements["PNT_358"]	= default_button(_("Push Button 9"),	devices.MFDL, MFDL_commands.PB9,23)
elements["PNT_357"]	= default_button(_("Push Button 8"),	devices.MFDL, MFDL_commands.PB8,22)
elements["PNT_356"]	= default_button(_("Push Button 7"),	devices.MFDL, MFDL_commands.PB7,21)
elements["PNT_355"]	= default_button(_("Push Button 6"),	devices.MFDL, MFDL_commands.PB6,20)
elements["PNT_354"]	= default_button(_("Push Button 5"),	devices.MFDL, MFDL_commands.PB5,19)
elements["PNT_353"]	= default_button(_("Push Button 4"),	devices.MFDL, MFDL_commands.PB4,18)
elements["PNT_352"]	= default_button(_("Push Button 3"),	devices.MFDL, MFDL_commands.PB3,17)
elements["PNT_351"]	= default_button(_("Push Button 2"),	devices.MFDL, MFDL_commands.PB2,16)
elements["PNT_350"]	= default_button(_("Push Button 1"),	devices.MFDL, MFDL_commands.PB1,15)

-- Rear MFD Right ----
elements["PNT_397"]	= default_button(_("MFD On Day"),	devices.MFDR, MFDR_commands.dayPower,434)
elements["PNT_417"]	= default_button(_("MFD On Night"),	devices.MFDR, MFDR_commands.nightPower,435)
elements["PNT_418"]	= default_button(_("MFD Off"),	devices.MFDR, MFDR_commands.offSwitch,436)
elements["PNT_396"] = default_button(_("MFD Brightness Increase"),	devices.MFDR, MFDR_commands.brightnessUp,		432)
elements["PNT_399"] = default_button(_("MFD Brightness Decrease"),	devices.MFDR, MFDR_commands.brightnessDown,		433)
elements["PNT_394"]	= default_button(_("Push Button 20"),	devices.MFDR, MFDR_commands.PB20,59)
elements["PNT_393"]	= default_button(_("Push Button 19"),	devices.MFDR, MFDR_commands.PB19,58)
elements["PNT_392"]	= default_button(_("Push Button 18"),	devices.MFDR, MFDR_commands.PB18,57)
elements["PNT_391"]	= default_button(_("Push Button 17"),	devices.MFDR, MFDR_commands.PB17,56)
elements["PNT_390"]	= default_button(_("Push Button 16"),	devices.MFDR, MFDR_commands.PB16,55)
elements["PNT_389"]	= default_button(_("Push Button 15"),	devices.MFDR, MFDR_commands.PB15,54)
elements["PNT_388"]	= default_button(_("Push Button 14"),	devices.MFDR, MFDR_commands.PB14,53)
elements["PNT_387"]	= default_button(_("Push Button 13"),	devices.MFDR, MFDR_commands.PB13,52)
elements["PNT_386"]	= default_button(_("Push Button 12"),	devices.MFDR, MFDR_commands.PB12,51)
elements["PNT_385"]	= default_button(_("Push Button 11"),	devices.MFDR, MFDR_commands.PB11,50)
elements["PNT_384"]	= default_button(_("Push Button 10"),	devices.MFDR, MFDR_commands.PB10,49)
elements["PNT_383"]	= default_button(_("Push Button 9"),	devices.MFDR, MFDR_commands.PB9,48)
elements["PNT_382"]	= default_button(_("Push Button 8"),	devices.MFDR, MFDR_commands.PB8,47)
elements["PNT_381"]	= default_button(_("Push Button 7"),	devices.MFDR, MFDR_commands.PB7,46)
elements["PNT_380"]	= default_button(_("Push Button 6"),	devices.MFDR, MFDR_commands.PB6,45)
elements["PNT_379"]	= default_button(_("Push Button 5"),	devices.MFDR, MFDR_commands.PB5,44)
elements["PNT_378"]	= default_button(_("Push Button 4"),	devices.MFDR, MFDR_commands.PB4,43)
elements["PNT_377"]	= default_button(_("Push Button 3"),	devices.MFDR, MFDR_commands.PB3,42)
elements["PNT_376"]	= default_button(_("Push Button 2"),	devices.MFDR, MFDR_commands.PB2,41)
elements["PNT_375"]	= default_button(_("Push Button 1"),	devices.MFDR, MFDR_commands.PB1,40)