local dev = GetSelf()
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
--dofile(LockOn_Options.script_path.."utils.lua")

local update_time_step = 0.05
make_default_activity(update_time_step)--update will be called 20 times per second
local sensor_data = get_base_data()

-- Const

--local degrees_per_radian = 57.2957795
--local feet_per_meter_per_minute = 196.8
local meters_to_feet = 3.2808399
local GALLON_TO_KG = 3.785 * 0.8
local KG_TO_POUNDS = 2.20462
local MPS_TO_KNOTS = 1.94384
local RADIANS_TO_DEGREES = 57.2958

-----------------------------------------------------------------------------

local adjusted_alt = get_param_handle("ADJUSTED_ALTITUDE")
local alt_needle = get_param_handle("ALTIMETER_NEEDLE") -- 0 to 1000
local alt_10k = get_param_handle("ALT_10K") -- 0 to 100,000
local alt_1k = get_param_handle("ALT_1K") -- 0 to 10,000
local alt_100s = get_param_handle("ALT_100") -- 0 to 1000
local alt_10 = get_param_handle("ALT_10") -- 0 to 100
local alt_1 = get_param_handle("ALT_1") -- 0 to 10
local alt_adj_Nxxx = get_param_handle("ALT_ADJ_Nxxx") -- 1st digit, 0-10 is input
local alt_adj_xNxx = get_param_handle("ALT_ADJ_xNxx") -- 2nd digit, 0-10 input
local alt_adj_xxNx = get_param_handle("ALT_ADJ_xxNx") -- 3rd digit, 0-10 input
local alt_adj_xxxN = get_param_handle("ALT_ADJ_xxxN") -- 4th digit, 0-10 input

alt_10k:set(0.0)
alt_1k:set(0.0)
alt_100s:set(0.0)
alt_needle:set(0.0)


local ALT_PRESSURE_MAX = 30.99 -- in Hg
local ALT_PRESSURE_MIN = 29.10 -- in Hg
local ALT_PRESSURE_STD = 29.92 -- in Hg

local alt_setting = ALT_PRESSURE_STD



function post_initialize()

end

dev:listen_command(device_commands.AltPressureKnob)
dev:listen_command(Keys.AltPressureInc)
dev:listen_command(Keys.AltPressureDec)
dev:listen_command(device_commands.AltimeterSet)
function SetCommand(command,value)   
    if command == device_commands.AltimeterSet then
		alt_setting = alt_setting + value/10
		if alt_setting > ALT_PRESSURE_MAX then
			alt_setting = ALT_PRESSURE_MAX
		elseif alt_setting < ALT_PRESSURE_MIN then
			alt_setting = ALT_PRESSURE_MIN
		end
	end
end

---
function update()
    update_altimeter()
   
 
end

function update_altimeter()
    -- altimeter
    local alt = sensor_data.getBarometricAltitude()*meters_to_feet

    local altNxxx = math.floor(alt_setting/10)         
	local altxNxx = math.floor(alt_setting) % 10 
    local altxxNx = math.floor(alt_setting*10) % 10
    local altxxxN = math.floor(alt_setting*100) % 10

    -- first update the selected setting value displayed
    alt_adj_Nxxx:set(altNxxx)
	alt_adj_xNxx:set(altxNxx)
    alt_adj_xxNx:set(altxxNx)
    alt_adj_xxxN:set(altxxxN)
	

    -- based on setting, adjust displayed altitude
    local alt_adj = (alt_setting - ALT_PRESSURE_STD)*1000   -- 1000 feet per inHg / 10 feet per .01 inHg -- if we set higher pressure than actual => altimeter reads higher

    alt_10k:set(  ((alt+alt_adj) % 100000)/100000)
    alt_1k:set(   ((alt+alt_adj) % 10000)/10000)
    alt_100s:set( ((alt+alt_adj) % 1000)/1000)
	alt_10:set(   (alt+alt_adj) % 100)
	alt_1:set(    (alt+alt_adj) % 10)
	
    alt_needle:set((alt+alt_adj) % 1000)
	
	adjusted_alt:set(alt + alt_adj)
	
end




need_to_be_closed = false -- close lua state after initialization


-- getAngleOfAttack
-- getAngleOfSlide
-- getBarometricAltitude
-- getCanopyPos
-- getCanopyState
-- getEngineLeftFuelConsumption --
-- getEngineLeftRPM
-- getEngineLeftTemperatureBeforeTurbine
-- getEngineRightFuelConsumption
-- getEngineRightRPM
-- getEngineRightTemperatureBeforeTurbine
-- getFlapsPos
-- getFlapsRetracted
-- getHeading
-- getHelicopterCollective
-- getHelicopterCorrection
-- getHorizontalAcceleration
-- getIndicatedAirSpeed
-- getLandingGearHandlePos
-- getLateralAcceleration
-- getLeftMainLandingGearDown
-- getLeftMainLandingGearUp
-- getMachNumber
-- getMagneticHeading
-- getNoseLandingGearDown
-- getNoseLandingGearUp
-- getPitch
-- getRadarAltitude
-- getRateOfPitch
-- getRateOfRoll
-- getRateOfYaw
-- getRightMainLandingGearDown
-- getRightMainLandingGearUp
-- getRoll
-- getRudderPosition
-- getSelfAirspeed
-- getSelfCoordinates
-- getSelfVelocity
-- getSpeedBrakePos
-- getStickPitchPosition
-- getStickRollPosition
-- getThrottleLeftPosition
-- getThrottleRightPosition
-- getTotalFuelWeight  
-- getTrueAirSpeed
-- getVerticalAcceleration
-- getVerticalVelocity
-- getWOW_LeftMainLandingGear
-- getWOW_NoseLandingGear
-- getWOW_RightMainLandingGear
