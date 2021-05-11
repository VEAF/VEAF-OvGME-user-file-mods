shape_name   	   = "Cockpit_VNAO_T45C" 


dusk_border					 = 0.5

draw_pilot			= false
render_debug_info	= false
--external_model_canopy_arg	 = 38

day_texture_set_value   = 0.0
night_texture_set_value = 0.1

local controllers = LoRegisterPanelControls()

mirrors_data = 
{
    center_point 	= {0.30,0.12,0}, --F/B,U/D,L/R location of reflection image generation
	width           =  1.0,
    aspect          =  1.0,
 --   width			= math.rad(45), -- horizontal FOV
 --   aspect 		= 1.1, 
	rotation 	 	= math.rad(-15); -- vertical rotation (negative is down into cockpit more)
	near_clip 		= 0.1; -- removes polys within this distance
	--middle_clip		= 10;
	--far_clip		= 60000;
	--arg_value_when_on	= 1.0,
	--animation_speed = 2.0;
}

local lb_to_kg = 0.453592
local ft_to_meter = 0.3048
local mps_to_ftPmin = 196.85
local ftmin_to_mps = 1/mps_to_ftPmin
local knots_to_mps = 1/1.944--1.852
--[[
mirrors_draw                    = CreateGauge()
mirrors_draw.arg_number    		= 0
mirrors_draw.input   			= {0,1}
mirrors_draw.output   			= {1,0}
mirrors_draw.controller         = controllers.mirrors_draw
--]]
CanopyLever    					= CreateGauge()
CanopyLever.arg_number 			= 129
CanopyLever.input   			= {0, 0.1, 0.9}
CanopyLever.output  			= {1, 0.4, 0.0}
CanopyLever.controller 			= controllers.base_gauge_CanopyPos

ADIslip							= CreateGauge()	
ADIslip.arg_number				= 161		-- used for MFD slip ball, if changed here then change arg in DisplayElectronicsUnit.lua
ADIslip.input					= {-0.15, 0.15}
ADIslip.output					= {-0.1, 0.1}
ADIslip.controller				= controllers.base_gauge_AngleOfSlide

AoAGauge						= CreateGauge("parameter")
AoAGauge.arg_number				= 840
AoAGauge.input					= {0, 30}
AoAGauge.output					= {0, 1}
AoAGauge.parameter_name			= "CURRENT_AOA"

SADIPitch                        = CreateGauge()
SADIPitch.arg_number             = 169
SADIPitch.input                  = {math.rad(-90), math.rad(90)}
SADIPitch.output                 = {1, -1}
SADIPitch.controller			 = controllers.base_gauge_Pitch

SADIRoll                         = CreateGauge()
SADIRoll.arg_number              = 170
SADIRoll.input                   = {-math.pi, math.pi}
SADIRoll.output                  = {1, -1}
SADIRoll.controller				 = controllers.base_gauge_Roll

VertVelocity                     = CreateGauge()
VertVelocity.arg_number          = 163
VertVelocity.input               = {-7000*ftmin_to_mps, -6000*ftmin_to_mps, -4000*ftmin_to_mps, -2000*ftmin_to_mps, -1000*ftmin_to_mps, -500*ftmin_to_mps, 0, 500*ftmin_to_mps, 1000*ftmin_to_mps, 2000*ftmin_to_mps, 4000*ftmin_to_mps, 6000*ftmin_to_mps, 7000*ftmin_to_mps}
VertVelocity.output              = {-1, -0.94, -0.79, -0.522, -0.34, -0.16, 0, 0.16, 0.34, 0.522, 0.79, 0.94, 1}
VertVelocity.controller			 = controllers.base_gauge_VerticalVelocity

Airspeed                         = CreateGauge()
Airspeed.arg_number              = 162
Airspeed.input                   = {0, 100*knots_to_mps, 200*knots_to_mps, 300*knots_to_mps, 500*knots_to_mps, 850*knots_to_mps, 900*knots_to_mps}
Airspeed.output                  = {0, 0.149, 0.56, 0.642, 0.78, 0.955, 1}
Airspeed.controller				 = controllers.base_gauge_IndicatedAirSpeed

AltimeterNeedle					= CreateGauge("parameter")
AltimeterNeedle.arg_number		= 164
AltimeterNeedle.input			= {0, 1000}
AltimeterNeedle.output			= {0, 1}
AltimeterNeedle.parameter_name	= "ALTIMETER_NEEDLE"

Alt10k						= CreateGauge("parameter")
Alt10k.arg_number			= 314
Alt10k.input				= {0, 1}
Alt10k.output				= {0, 1}
Alt10k.parameter_name		= "ALT_10K"

Alt1k						= CreateGauge("parameter")
Alt1k.arg_number			= 315
Alt1k.input					= {0, 1}
Alt1k.output				= {0, 1}
Alt1k.parameter_name		= "ALT_1K"

Alt100						= CreateGauge("parameter")
Alt100.arg_number			= 316
Alt100.input				= {0, 1}
Alt100.output				= {0, 1}
Alt100.parameter_name		= "ALT_100"

Alt10						= CreateGauge("parameter")
Alt10.arg_number			= 317
Alt10.input					= {0, 100}
Alt10.output				= {0, 1}
Alt10.parameter_name		= "ALT_10"

Alt1						= CreateGauge("parameter")
Alt1.arg_number				= 318
Alt1.input					= {0, 10}
Alt1.output					= {0, 1}
Alt1.parameter_name			= "ALT_1"

AltBaro10						= CreateGauge("parameter")
AltBaro10.arg_number			= 324
AltBaro10.input					= {0, 10}
AltBaro10.output				= {0, 1}
AltBaro10.parameter_name		= "ALT_ADJ_Nxxx"

AltBaro1						= CreateGauge("parameter")
AltBaro1.arg_number				= 325
AltBaro1.input					= {0, 10}
AltBaro1.output					= {0, 1}
AltBaro1.parameter_name			= "ALT_ADJ_xNxx"

AltBaroTenth						= CreateGauge("parameter")
AltBaroTenth.arg_number				= 326
AltBaroTenth.input					= {0, 10}
AltBaroTenth.output					= {0, 1}
AltBaroTenth.parameter_name			= "ALT_ADJ_xxNx"

AltBaroHundredth					= CreateGauge("parameter")
AltBaroHundredth.arg_number			= 327
AltBaroHundredth.input				= {0, 10}
AltBaroHundredth.output				= {0, 1}
AltBaroHundredth.parameter_name		= "ALT_ADJ_xxxN"

FuelFlowNeedle					= CreateGauge("parameter")
FuelFlowNeedle.arg_number		= 173
FuelFlowNeedle.input			= {0, 7000}
FuelFlowNeedle.output			= {0, 1}
FuelFlowNeedle.parameter_name	= "CURRENT_FF"

TotalFuelNeedle					= CreateGauge("parameter")
TotalFuelNeedle.arg_number		= 174
TotalFuelNeedle.input			= {0, 3300}
TotalFuelNeedle.output			= {0, 1}
TotalFuelNeedle.parameter_name	= "CURRENT_FUELT"
--[[
TotalFuel1000					= CreateGauge("parameter")
TotalFuel1000.arg_number		= 228
TotalFuel1000.input				= {0, 0.99, 1, 1.99, 2,  2.99, 3,  10}--added buffers to avoid long periods of partial rollover
TotalFuel1000.output			= {0, 0,   0.1, 0.1, 0.2, 0.2, 0.3, 1}
TotalFuel1000.parameter_name	= "FUEL_1000s"

TotalFuel100					= CreateGauge("parameter")
TotalFuel100.arg_number			= 227
TotalFuel100.input				= {0, 0.99, 1, 1.99, 2, 2.99, 3, 3.99, 4, 4.99, 5, 5.99, 6, 6.99, 7, 7.99, 8, 8.99, 9, 9.99, 10}
TotalFuel100.output				= {0, 0,   0.1, 0.1, 0.2, 0.2,0.3, 0.3, 0.4, 0.4,0.5, 0.5,0.6,0.6, 0.7,0.7, 0.8,0.8, 0.9,0.9, 1}
TotalFuel100.parameter_name		= "FUEL_100s"

TotalFuel10						= CreateGauge("parameter")
TotalFuel10.arg_number			= 226
TotalFuel10.input				= {0, 0.99, 1, 1.99, 2, 2.99, 3, 3.99, 4, 4.99, 5, 5.99, 6, 6.99, 7, 7.99, 8, 8.99, 9, 9.99, 10}
TotalFuel10.output				= {0, 0,   0.1, 0.1, 0.2, 0.2,0.3, 0.3, 0.4, 0.4,0.5, 0.5,0.6,0.6, 0.7,0.7, 0.8,0.8, 0.9,0.9, 1}
TotalFuel10.parameter_name		= "FUEL_10s"

TotalFuel1						= CreateGauge("parameter")
TotalFuel1.arg_number			= 225
TotalFuel1.input				= {0, 0.99, 1, 1.99, 2, 2.99, 3, 3.99, 4, 4.99, 5, 5.99, 6, 6.99, 7, 7.99, 8, 8.99, 9, 9.99, 10}
TotalFuel1.output				= {0, 0,   0.1, 0.1, 0.2, 0.2,0.3, 0.3, 0.4, 0.4,0.5, 0.5,0.6,0.6, 0.7,0.7, 0.8,0.8, 0.9,0.9, 1}
TotalFuel1.parameter_name		= "FUEL_1s"
]]
RPMNeedle					= CreateGauge("parameter")
RPMNeedle.arg_number		= 175
RPMNeedle.input				= {0, 100}
RPMNeedle.output			= {0, 1}
RPMNeedle.parameter_name	= "CURRENT_RPM"

RPMNeedleSmall					= CreateGauge("parameter")
RPMNeedleSmall.arg_number		= 176
RPMNeedleSmall.input			= {0, 10}
RPMNeedleSmall.output			= {0, 1}
RPMNeedleSmall.parameter_name	= "CURRENT_RPM1s"

intercom_PTT				= CreateGauge("parameter")
intercom_PTT.arg_number		= 295
intercom_PTT.input			= {0, 1}
intercom_PTT.output			= {0, 1}
intercom_PTT.parameter_name	= "INTERCOM_PTT"

AOAIndexerV					= CreateGauge("parameter")
AOAIndexerV.arg_number		= 320
AOAIndexerV.input			= {0, 1}
AOAIndexerV.output			= {0, 1}
AOAIndexerV.parameter_name	= "AOA_INDEXERv"

AOAIndexerO					= CreateGauge("parameter")
AOAIndexerO.arg_number		= 321
AOAIndexerO.input			= {0, 1}
AOAIndexerO.output			= {0, 1}
AOAIndexerO.parameter_name	= "AOA_INDEXERo"

AOAIndexerUp				= CreateGauge("parameter")
AOAIndexerUp.arg_number		= 322
AOAIndexerUp.input			= {0, 1}
AOAIndexerUp.output			= {0, 1}
AOAIndexerUp.parameter_name	= "AOA_INDEXER_UP"

magneticCompasss    			= CreateGauge()
magneticCompasss.arg_number 	= 118
magneticCompasss.input   		= {0, 2*math.pi}
magneticCompasss.output  		= {1, 0}
magneticCompasss.controller 	= controllers.base_gauge_MagneticHeading

TACANdialOnes					= CreateGauge("parameter")
TACANdialOnes.arg_number		= 332
TACANdialOnes.input				= {0, 1}
TACANdialOnes.output			= {0, 1}
TACANdialOnes.parameter_name	= "TACAN_DIAL_ONES"

TACANdialTens					= CreateGauge("parameter")
TACANdialTens.arg_number		= 331
TACANdialTens.input				= {0, 1}
TACANdialTens.output			= {0, 1}
TACANdialTens.parameter_name	= "TACAN_DIAL_TENS"

TACANdialHundreds					= CreateGauge("parameter")
TACANdialHundreds.arg_number		= 330
TACANdialHundreds.input				= {0, 1}
TACANdialHundreds.output			= {0, 1}
TACANdialHundreds.parameter_name	= "TACAN_DIAL_HUNDREDS"

VORdialWholeXxx						= CreateGauge("parameter")
VORdialWholeXxx.arg_number			= 334
VORdialWholeXxx.input				= {0, 1}
VORdialWholeXxx.output				= {0, 1}
VORdialWholeXxx.parameter_name		= "VOR_DIAL_WHOLE_Nxx"

VORdialWholexXx						= CreateGauge("parameter")
VORdialWholexXx.arg_number			= 335
VORdialWholexXx.input				= {0, 1}
VORdialWholexXx.output				= {0, 1}
VORdialWholexXx.parameter_name		= "VOR_DIAL_WHOLE_xNx"

VORdialWholexxX						= CreateGauge("parameter")
VORdialWholexxX.arg_number			= 336
VORdialWholexxX.input				= {0, 1}
VORdialWholexxX.output				= {0, 1}
VORdialWholexxX.parameter_name		= "VOR_DIAL_WHOLE_xxN"

VORdialDecimalXx					= CreateGauge("parameter")
VORdialDecimalXx.arg_number			= 337
VORdialDecimalXx.input				= {0, 1}
VORdialDecimalXx.output				= {0, 1}
VORdialDecimalXx.parameter_name		= "VOR_DIAL_DEC_Nx"

VORdialDecimalxX					= CreateGauge("parameter")
VORdialDecimalxX.arg_number			= 338
VORdialDecimalxX.input				= {0, 1}
VORdialDecimalxX.output				= {0, 1}
VORdialDecimalxX.parameter_name		= "VOR_DIAL_DEC_xN"

EGTgauge							= CreateGauge("parameter")
EGTgauge.arg_number					= 178
EGTgauge.input						= {0, 450, 700, 800}
EGTgauge.output						= {0, 0.365, 0.91, 1}
EGTgauge.parameter_name				= "EGT"

ClockHR					= CreateGauge("parameter")
ClockHR.arg_number		= 185
ClockHR.input			= {0, 12}
ClockHR.output			= {0, 1}
ClockHR.parameter_name	= "CURRTIME_HOURS"

ClockMIN				= CreateGauge("parameter")
ClockMIN.arg_number		= 186
ClockMIN.input			= {0, 60}
ClockMIN.output			= {0, 1}
ClockMIN.parameter_name	= "CURRTIME_MINS"

ClockSEC				= CreateGauge("parameter")
ClockSEC.arg_number		= 187
ClockSEC.input			= {0, 60}
ClockSEC.output			= {0, 1}
ClockSEC.parameter_name	= "CURRTIME_SECS"

need_to_be_closed = true -- close lua state after initialization 


livery = "default"

--[[ available functions 

 --base_gauge_RadarAltitude
 --base_gauge_BarometricAltitude
 --base_gauge_AngleOfAttack
 --base_gauge_AngleOfSlide
 --base_gauge_VerticalVelocity
 --base_gauge_TrueAirSpeed
 --base_gauge_IndicatedAirSpeed
 --base_gauge_MachNumber
 --base_gauge_VerticalAcceleration --Ny
 --base_gauge_HorizontalAcceleration --Nx
 --base_gauge_LateralAcceleration --Nz
 --base_gauge_RateOfRoll
 --base_gauge_RateOfYaw
 --base_gauge_RateOfPitch
 --base_gauge_Roll
 --base_gauge_MagneticHeading
 --base_gauge_Pitch
 --base_gauge_Heading
 --base_gauge_EngineLeftFuelConsumption
 --base_gauge_EngineRightFuelConsumption
 --base_gauge_EngineLeftTemperatureBeforeTurbine
 --base_gauge_EngineRightTemperatureBeforeTurbine
 --base_gauge_EngineLeftRPM
 --base_gauge_EngineRightRPM
 --base_gauge_WOW_RightMainLandingGear
 --base_gauge_WOW_LeftMainLandingGear
 --base_gauge_WOW_NoseLandingGear
 --base_gauge_RightMainLandingGearDown
 --base_gauge_LeftMainLandingGearDown
 --base_gauge_NoseLandingGearDown
 --base_gauge_RightMainLandingGearUp
 --base_gauge_LeftMainLandingGearUp
 --base_gauge_NoseLandingGearUp
 --base_gauge_LandingGearHandlePos
 --base_gauge_StickRollPosition
 --base_gauge_StickPitchPosition
 --base_gauge_RudderPosition
 --base_gauge_ThrottleLeftPosition
 --base_gauge_ThrottleRightPosition
 --base_gauge_HelicopterCollective
 --base_gauge_HelicopterCorrection
 --base_gauge_CanopyPos
 --base_gauge_CanopyState
 --base_gauge_FlapsRetracted
 --base_gauge_SpeedBrakePos
 --base_gauge_FlapsPos
 --base_gauge_TotalFuelWeight

--]]
