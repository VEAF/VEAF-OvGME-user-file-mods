dofile(LockOn_Options.script_path.."PFD_Display/indicator/definitions.lua")

local PFD_dll_values = get_param_handle("PFD_dll_values")
local PFD_lua_values = false --Set to true if you want to run the PFD with lua code
if PFD_lua_values then
	PFD_dll_values:set(0.0)
else
	PFD_dll_values:set(1.0)
end

local update_time_step = 0.006 --EFM rate (0.006 s) or multible of 0.006 s (fastest), 0.012 s, 0.024 s, etc
make_default_activity(update_time_step)

-- difference between IAS value at bottom and top of IAS tape and IAS value at indicator
local min_ref_airspeed_diff, max_ref_airspeed_diff = -58, 49

local reference_airspeed_up_down = get_param_handle "PFD_reference_airspeed_up_down"
local reference_airspeed = get_param_handle "PILOT_RefAirspeedVal"
local IAS = get_param_handle("IAS")

-- difference between altitude value at bottom and top of altitude tape and altitude value at indicator
local min_ref_altitude_diff, max_ref_altitude_diff = -920, 920

local reference_altitude = get_param_handle "PILOT_HudRefAltitudeCaretVal"
local reference_altitude_up_down = get_param_handle "PFD_reference_altitude_up_down"
local Baro_alt_ft = get_param_handle "Baro_alt_ft"

local VVI_up_down = get_param_handle "VVI_up_down"

local sensor_data = get_base_data()

function update()
	-- Convert vertical velocity from m/sec to FPM. Clamp vertical velocity to between -3000 to 3000, and divide by 1000.
	-- Change scale: (-1 to 1) to (-2, 2); (-3, -1) to (-4, -2), (1, 3) to (2, 4).
	local VV_thousands = msec_to_fpm(sensor_data.getVerticalVelocity()) / 1000
	local clamped_VVI_thousands = clamp(VV_thousands, -3, 3)
	local scaled_VVI_up_down_value
	if math.abs(clamped_VVI_thousands) <= 1 then
		scaled_VVI_up_down_value = clamped_VVI_thousands * 2
	else
		scaled_VVI_up_down_value = clamped_VVI_thousands + (clamped_VVI_thousands < 0 and -1 or 1)
	end
	VVI_up_down:set(scaled_VVI_up_down_value)

	local ref_airspeed_diff = reference_airspeed:get() - IAS:get()
	reference_airspeed_up_down:set(clamp(ref_airspeed_diff, min_ref_airspeed_diff, max_ref_airspeed_diff))

	local ref_altitude_diff = reference_altitude:get() - Baro_alt_ft:get()
	local clamped_ref_altitude_diff = clamp(ref_altitude_diff, min_ref_altitude_diff, max_ref_altitude_diff)

	reference_altitude_up_down:set(clamped_ref_altitude_diff)
end

-- function post_initialize()
-- end
