-- Display Electronics Unit handles all data to MFDs and HUD
local dev = GetSelf()
local update_time_step = 0.02 --update will be called 50 times per second
make_default_activity(update_time_step)
local sensor_data = get_base_data()
local Terrain = require('terrain')

--- input from EFM ---
--local pitot_iced  = get_param_handle("PITOT_ICED") --  0:normal, 1:iced
local WIND_X = get_param_handle("WIND_X")
local WIND_Y = get_param_handle("WIND_Y")
local ESbus = get_param_handle("ESS_SERV_BUS")

local adjusted_alt = get_param_handle("ADJUSTED_ALTITUDE")--from Avionics

-- make global param handles to be called in indicator scripts
local current_mach  = get_param_handle("CURRENT_MACH") 
local current_alt = get_param_handle("CURRENT_ALT")
local alt_100s = get_param_handle("ALT_100s")
local alt_1000s = get_param_handle("ALT_1000s")
local current_Ralt = get_param_handle("CURRENT_RALT")
local current_hdg = get_param_handle("CURRENT_HDG")
local current_ias = get_param_handle("CURRENT_IAS")
local current_Tas = get_param_handle("CURRENT_TAS")
local current_AoA = get_param_handle("CURRENT_AOA")
local AOA_INDEXER_UP = get_param_handle("AOA_INDEXER_UP")
local AOA_INDEXERo = get_param_handle("AOA_INDEXERo")
local AOA_INDEXERv = get_param_handle("AOA_INDEXERv")
local current_pitch = get_param_handle("CURRENT_PITCH")
local current_pitch2 = get_param_handle("CURRENT_PITCH2")
local current_roll = get_param_handle("CURRENT_ROLL")
local current_vv = get_param_handle("CURRENT_VV")
local current_vv_pointer = get_param_handle("CURRENT_VV_POINTER")
local current_vv_pointer_visibility = get_param_handle("CURRENT_VV_POINTER_VISIBILITY")
local current_G = get_param_handle("CURRENT_G")
local MAX_G = get_param_handle("MAX_G")
local current_RPM = get_param_handle("CURRENT_RPM")
local current_RPM1s = get_param_handle("CURRENT_RPM1s")
local current_fuelT  = get_param_handle("CURRENT_FUELT")
--local FUEL_1s = get_param_handle("FUEL_1s")
--local FUEL_10s = get_param_handle("FUEL_10s")
--local FUEL_100s = get_param_handle("FUEL_100s")
--local FUEL_1000s = get_param_handle("FUEL_1000s")
local current_FF = get_param_handle("CURRENT_FF")
local current_Slide = get_param_handle("CURRENT_SLIDE")
local LATERAL_ACC = get_param_handle("LATERAL_ACC")
local current_groundspeed = get_param_handle("CURRENT_GS")
local groundspeed_track = get_param_handle("GROUND_TRACK")
local timeHour = get_param_handle("timeHour")
local timeMins = get_param_handle("timeMins")
local timeSec = get_param_handle("timeSec")
local latitude = get_param_handle("CURRENT_LATITUDE")
local longitude = get_param_handle("CURRENT_LONGITUDE")
local wing_direction = get_param_handle("WIND_DIRECTION")
local wind_speed = get_param_handle("WIND_SPEED")

-- initial values
current_vv_pointer_visibility:set(1)
current_G:set(1)
MAX_G:set(1)


local feet_per_meter = 3.28084
local feet_per_meter_per_minute = feet_per_meter * 60
local degrees_per_radian = 57.2957795
local ias_conversion_to_knots = 1.9504132  -- guess based on sea level TAS vs. IAS value
local KG_TO_POUNDS = 2.20462
local mps_to_knot = 1.94384

function update()
local NWOW = sensor_data.getWOW_NoseLandingGear()
	--if pitot_iced:get() == 0 then
		current_alt:set(math.modf(adjusted_alt:get()/20)*20)
		local intg, fract = math.modf(adjusted_alt:get()/1000)
		alt_100s:set(math.modf(fract*1000/20)*20)
		alt_1000s:set(intg)
		
		current_ias:set(sensor_data.getIndicatedAirSpeed()*ias_conversion_to_knots)
		if current_ias:get()<50 then
			current_ias:set(50)
		end
		
		current_mach:set(sensor_data.getMachNumber())
		current_Tas:set(sensor_data.getTrueAirSpeed()*ias_conversion_to_knots)
		current_vv:set(math.modf(sensor_data.getVerticalVelocity()*feet_per_meter_per_minute/10)*10)
	--[[ 
	else
		current_alt:set(0)
		local intg, fract = math.modf(0*feet_per_meter/1000)
		alt_100s:set(math.modf(fract*1000/20)*20)
		alt_1000s:set(intg)
		
		current_ias:set(0)
		current_mach:set(0)
		current_Tas:set(0)
		current_vv:set(0)
	end]]
	
	if (math.modf(sensor_data.getVerticalVelocity()*feet_per_meter_per_minute/10)*10) > 9990 then
		current_vv:set(9990)
	elseif (math.modf(sensor_data.getVerticalVelocity()*feet_per_meter_per_minute/10)*10) < -9990 then
		current_vv:set(-9990)
	end
	if current_vv:get() > 1600 then
		current_vv_pointer:set(1600)
	elseif current_vv:get() < -2100 then
		current_vv_pointer:set(-2100)
	else
		current_vv_pointer:set(current_vv:get())
	end
	
	current_Ralt:set(math.modf(sensor_data.getRadarAltitude()*feet_per_meter/10)*10)
	--current_hdg:set(360-(sensor_data.getHeading()*degrees_per_radian))--true heading
	current_hdg:set((sensor_data.getMagneticHeading()*degrees_per_radian))--magnetic heading	
	current_AoA:set(sensor_data.getAngleOfAttack()*degrees_per_radian+10)
	current_pitch:set(sensor_data.getPitch())
	current_pitch2:set(sensor_data.getPitch()*degrees_per_radian)
	current_roll:set(sensor_data.getRoll())
	
	current_G:set(sensor_data.getVerticalAcceleration())
	if current_G:get() > MAX_G:get() and NWOW==0 then
		MAX_G:set(current_G:get())
	end
	current_RPM:set(sensor_data.getEngineLeftRPM()*100)
	current_RPM1s:set(math.fmod(current_RPM:get(),10))
	current_fuelT:set(sensor_data.getTotalFuelWeight()*KG_TO_POUNDS)
	--FUEL_1000s:set(current_fuelT:get()/1000)
	--FUEL_100s:set(math.fmod(FUEL_1000s:get(),1)*10)
	--FUEL_10s:set(math.fmod(FUEL_100s:get(),1)*10)
	--FUEL_1s:set(math.fmod(FUEL_10s:get(),1)*10)
	current_FF:set(sensor_data.getEngineLeftFuelConsumption()*KG_TO_POUNDS*3600)
	current_Slide:set(get_cockpit_draw_argument_value(161))
	LATERAL_ACC:set(sensor_data.getLateralAcceleration())
	
	local Vx, Vy, Vz = sensor_data.getSelfVelocity()--- DCS world axis: x is +north, y is +up, z is +east
	current_groundspeed:set(math.sqrt((Vx^2)+(Vz^2))*mps_to_knot)
	groundspeed_track:set(math.atan2(Vz,Vx)+sensor_data.getHeading())
	if current_groundspeed:get()<1 then groundspeed_track:set(0) end
	
	wind_speed:set(math.sqrt((WIND_X:get()^2)+(WIND_Y:get()^2))*mps_to_knot)
	local windDir = math.deg(math.atan2(WIND_Y:get(),WIND_X:get()))
	if windDir < 0 then
		wing_direction:set(360+windDir)
	else
		wing_direction:set(windDir)
	end
	
	local abstime = get_absolute_model_time()
    local hour = abstime/3600.0
    timeHour:set(hour)
    local int,frac = math.modf(hour)
    timeMins:set(math.floor(frac*60))
	local int1,frac1 = math.modf(frac*60)
	timeSec:set(frac1*60)
	
	local curx,cury,curz = sensor_data.getSelfCoordinates()
	local current_lat,current_long = Terrain.convertMetersToLatLon(curx,curz)
	latitude:set(DecDeg_to_DegMinSec(current_lat, "lat"))
	longitude:set(DecDeg_to_DegMinSec(current_long, "long"))

	local nosegear = get_aircraft_draw_argument_value(0)
	if current_AoA:get()>=17.5 and nosegear == 1 and ESbus:get()>21  and NWOW==0 then
		AOA_INDEXERv:set(1)
	else
		AOA_INDEXERv:set(0)
	end
	if current_AoA:get()>=16 and current_AoA:get()<=18 and nosegear == 1 and ESbus:get()>21  and NWOW==0 then
		AOA_INDEXERo:set(1)
	else
		AOA_INDEXERo:set(0)
	end
	if current_AoA:get()<=16.5 and nosegear == 1 and ESbus:get()>21  and NWOW==0 then
		AOA_INDEXER_UP:set(1)
	else
		AOA_INDEXER_UP:set(0)
	end
	
	set_aircraft_draw_argument_value(196, AOA_INDEXERv:get())
	set_aircraft_draw_argument_value(197, AOA_INDEXERo:get())
	set_aircraft_draw_argument_value(198, AOA_INDEXER_UP:get())
--print_message_to_user(LATERAL_ACC:get())
end

function DecDeg_to_DegMinSec(DecDeg, axis)
	local direction
	if axis == "lat" then
		if DecDeg/math.abs(DecDeg)== -1 then
			direction = "S"
		else
			direction = "N"
		end
	elseif axis == "long" then
		if DecDeg/math.abs(DecDeg)== -1 then
			direction = "W"
		else
			direction = "E"
		end
	end
	local int, frac = math.modf(math.abs(DecDeg))
	local D = int
	local int2, frac2 = math.modf(frac*60)
	local M = int2
	local S = math.modf(frac2*60)
	local output = tostring(direction.." "..D.." "..M.." "..S)
	return output
end

need_to_be_closed = false