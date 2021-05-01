dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "cursor_targets.lua")
dofile(LockOn_Options.common_script_path.."elements_defs.lua")

update_time_step = 0.06
make_default_activity(update_time_step)

local dev = GetSelf()
local sensor_data= get_base_data()

local update_counter = 0 --for logging
pct_fill = 0.9

local rad_to_deg = math.deg
local deg_to_rad = math.rad
local function NM_to_m(NM)
    return NM * 1852
end
local function m_to_NM(m)
    return m/1852
end

params = setmetatable({}, {
    __index = function(self, param_name)
        local handle = get_param_handle(param_name)
        self[param_name] = handle
        return handle
    end,
})


------------------------------------------------------------
----ADC/EGI Params----
local nav_heading = get_param_handle("NAV_RADAR_HEADING")
local nav_degree = get_param_handle("NAV_RADAR_DEGREE")
local Wind_rad = get_param_handle("Wind_rad")
local Wind_knts = get_param_handle("Wind_knts")
local HudGS = get_param_handle("HudGS")
local Self_NorthCorrection_rad = get_param_handle("Self_NorthCorrection_rad")
drift_marker = get_param_handle("DRIFT_MARKER")
nav_agl = get_param_handle("NAV_RADAR_AGL")
local xwind_comp = 0
local drift_angle = 0
nav_agl_1 = 0
nav_agl_10 = 0
nav_agl_50 = 0

----Clock Params----
local gmt_time = get_param_handle("GMT_TIME")
local hours = get_param_handle("Clock_hours")
local mins = get_param_handle("Clock_mins")
local secs = get_param_handle("Clock_secs")

----Cursor Params----
local nav_cursor_xpos = get_param_handle("NAV_Cursor_Xpos")
local nav_cursor_ypos = get_param_handle("NAV_Cursor_Ypos")

local nav_cursor_xpos_dsp = get_param_handle("NAV_Cursor_Xpos_Dsp")
local nav_cursor_ypos_dsp = get_param_handle("NAV_Cursor_Ypos_Dsp")

local nav_manual_cursor = get_param_handle("NAV_Manual_Cursor")
local nav_ground_cursor = get_param_handle("NAV_Ground_Cursor")
local nav_computer_cursor = get_param_handle("NAV_Computer_Cursor")
local cursor_mode_disp = get_param_handle("CURSOR_MODE_DISP")
local cursor_next_target = get_param_handle("Cursor_Next_Target")
local cursor_previous_target = get_param_handle("Cursor_Previous_Target")
local cursor_insert = get_param_handle("Cursor_Insert")
local cursor_pressed = get_param_handle("Cursor_Pressed")
local cursor_cross_display = get_param_handle("CURSOR_CROSS_DISPLAY")

cursor_pos = get_param_handle("CURSOR_POS_VAL")
local cursor_rel = get_param_handle("CURSOR_REL")
local cursor_bearing_nose = get_param_handle("CURSOR_BEARING_NOSE")
local mag_curs_sp = get_param_handle("MAG_CURS_SP")
local self_lat_deg = get_param_handle("Self_lat_deg")
local self_long_deg = get_param_handle("Self_long_deg")
local self_lat_hemi = "N"
local self_long_hemi = "E"
local self_lat_DDD = 0
local self_lat_mmmm = 0
local self_long_DDD = 0
local self_long_mmmm = 0
local cursor_lat_deg = get_param_handle("CURSOR_LAT_DEG")
local cursor_long_deg = get_param_handle("CURSOR_LONG_DEG")
local cursor_lat_hemi = "N"
local cursor_long_hemi = "E"
local cursor_lat_DDD = 0
local cursor_lat_mmmm = 0
local cursor_long_DDD = 0
local cursor_long_mmmm = 0

local cursor_range = 0
local cursor_bearing = 0
local cursor_target_num = 0
local NAV_Cursor_Forward = 0
local NAV_Cursor_Aft = 0
local NAV_Cursor_Left = 0
local NAV_Cursor_Right = 0
local NAV_Cursor_Xpos = 0.0
local NAV_Cursor_Ypos = 0.3
local cursor_insert = 0

----Cursor Target Params----
params.nav_Cursor_ypos:set(0.3)
nav_cursor_ypos_dsp:set(0.3)
----Navaid Params----

----Misc Params----
params.NAV_RADAR_RANGE:set(20)

----Waypoint Nav Params----
params.XTK_YARDS:set(0)
xtk_value = nil
params.ETA:set("XXXX:XX")
params.TOT_TIME:set("XXXX:XX")
params.TGS_INDC:set("XXX")


--temp
num_waypoints = 0
current_wpt = 2
perf_cruise_speed = 220 --kts ground speed
tot = 67080


params.TOT_ACTIVE:set(1)
params.TOT_WAYPOINT:set(4)

cursor_cross_display:set(1)
------------------------------------------------------------
----Cursor Keybinds----
dev:listen_command(CURSOR.Manual_Cursor)
dev:listen_command(CURSOR.Ground_Cursor)
dev:listen_command(CURSOR.Computer_Cursor)
dev:listen_command(CURSOR.Cursor_Forward)
dev:listen_command(CURSOR.Cursor_Aft)
dev:listen_command(CURSOR.Cursor_Left)
dev:listen_command(CURSOR.Cursor_Right)
dev:listen_command(CURSOR.Cursor_Release)
dev:listen_command(CURSOR.Cursor_Next_Target)
dev:listen_command(CURSOR.Cursor_Previous_Target)
dev:listen_command(CURSOR.Cursor_Insert)
dev:listen_command(CURSOR.Cursor_Reset)
dev:listen_command(AMU.pilot_AMU002_SelectKey_001)
dev:listen_command(AMU.pilot_AMU002_SelectKey_002)
dev:listen_command(AMU.pilot_AMU002_SelectKey_003)
dev:listen_command(AMU.pilot_AMU002_SelectKey_004)
dev:listen_command(AMU.pilot_AMU002_SelectKey_005)
dev:listen_command(AMU.pilot_AMU002_SelectKey_006)
dev:listen_command(AMU.pilot_AMU002_SelectKey_007)
dev:listen_command(AMU.pilot_AMU002_SelectKey_008)
dev:listen_command(AMU.copilot_AMU002_SelectKey_001)
dev:listen_command(AMU.copilot_AMU002_SelectKey_002)
dev:listen_command(AMU.copilot_AMU002_SelectKey_003)
dev:listen_command(AMU.copilot_AMU002_SelectKey_004)
dev:listen_command(AMU.copilot_AMU002_SelectKey_005)
dev:listen_command(AMU.copilot_AMU002_SelectKey_006)
dev:listen_command(AMU.copilot_AMU002_SelectKey_007)
dev:listen_command(AMU.copilot_AMU002_SelectKey_008)

function SetCommand(command,value)
    if command == CURSOR.Manual_Cursor then
        nav_manual_cursor:set(1)
        nav_ground_cursor:set(0)
        nav_computer_cursor:set(0)
        NAV_Cursor_Xpos = nav_cursor_xpos:get()
        NAV_Cursor_Ypos = nav_cursor_ypos:get()
    end
    if command == CURSOR.Ground_Cursor then
        nav_manual_cursor:set(0)
        nav_ground_cursor:set(1)
        nav_computer_cursor:set(0)
    end
    if command == CURSOR.Computer_Cursor then
        nav_manual_cursor:set(0)
        nav_ground_cursor:set(0)
        nav_computer_cursor:set(1)
    end
    if command == CURSOR.Cursor_Reset then
        nav_manual_cursor:set(1)
        nav_ground_cursor:set(0)
        nav_computer_cursor:set(0)
        NAV_Cursor_Xpos = 0.0
        NAV_Cursor_Ypos = 0.3
        nav_cursor_xpos:set(0.0)
        nav_cursor_ypos:set(0.3)
        nav_cursor_xpos_dsp:set(0.0)
        nav_cursor_ypos_dsp:set(0.3)
    end
    if command == CURSOR.Cursor_Insert then
        cursor_insert = 1
    end
    --------------------------------------------------------
    if command == CURSOR.Cursor_Next_Target then
        cursor_next_target:set(1)
    end
    if command == CURSOR.Cursor_Previous_Target then
        cursor_previous_target:set(1)
    end
    --------------------------------------------------------
    if command == CURSOR.Cursor_Forward then
		NAV_Cursor_Forward = 1
		cursor_pressed:set(1)
	end
	if command == CURSOR.Cursor_Aft then
		NAV_Cursor_Aft = 1
		cursor_pressed:set(1)
	end
	if command == CURSOR.Cursor_Left then
		NAV_Cursor_Left = 1
		cursor_pressed:set(1)
	end
	if command == CURSOR.Cursor_Right then
		NAV_Cursor_Right = 1
		cursor_pressed:set(1)
	end
    if command == CURSOR.Cursor_Release then
		NAV_Cursor_Forward = 0
		NAV_Cursor_Aft = 0
		NAV_Cursor_Left = 0
		NAV_Cursor_Right = 0
	end
   --------------------------------------------------------
    if params.PILOT_AMU002_Range:get() == 1 then
        if command == AMU.pilot_AMU002_SelectKey_001 then
            params.NAV_RADAR_RANGE:set(1.5)
        end
        if command == AMU.pilot_AMU002_SelectKey_002 then
            params.NAV_RADAR_RANGE:set(3)
        end
        if command == AMU.pilot_AMU002_SelectKey_003 then
            params.NAV_RADAR_RANGE:set(5)
        end
        if command == AMU.pilot_AMU002_SelectKey_004 then
            params.NAV_RADAR_RANGE:set(10)
        end
        if command == AMU.pilot_AMU002_SelectKey_005 then
            params.NAV_RADAR_RANGE:set(20)
        end
        if command == AMU.pilot_AMU002_SelectKey_006 then
            params.NAV_RADAR_RANGE:set(40)
        end
        if command == AMU.pilot_AMU002_SelectKey_007 then
            params.NAV_RADAR_RANGE:set(80)
        end
        if command == AMU.pilot_AMU002_SelectKey_008 and params.NAV_RADAR_RANGE:get() == 160 then
            params.NAV_RADAR_RANGE:set(320)
        elseif command == AMU.pilot_AMU002_SelectKey_008 then
            params.NAV_RADAR_RANGE:set(160)
        end
    end
    if params.COPILOT_AMU002_Range:get() == 1 then
        if command == AMU.copilot_AMU002_SelectKey_001 then
            params.NAV_RADAR_RANGE:set(1.5)
        end
        if command == AMU.copilot_AMU002_SelectKey_002 then
            params.NAV_RADAR_RANGE:set(3)
        end
        if command == AMU.copilot_AMU002_SelectKey_003 then
            params.NAV_RADAR_RANGE:set(5)
        end
        if command == AMU.copilot_AMU002_SelectKey_004 then
            params.NAV_RADAR_RANGE:set(10)
        end
        if command == AMU.copilot_AMU002_SelectKey_005 then
            params.NAV_RADAR_RANGE:set(20)
        end
        if command == AMU.copilot_AMU002_SelectKey_006 then
            params.NAV_RADAR_RANGE:set(40)
        end
        if command == AMU.copilot_AMU002_SelectKey_007 then
            params.NAV_RADAR_RANGE:set(80)
        end
        if command == AMU.copilot_AMU002_SelectKey_008 and params.NAV_RADAR_RANGE:get() == 160 then
            params.NAV_RADAR_RANGE:set(320)
        elseif command == AMU.copilot_AMU002_SelectKey_008 then
            params.NAV_RADAR_RANGE:set(160)
        end
    end

end
------------------------------------------------------------
----Cursor Functions----
local function cursor_target_lat(cursor_target_num) --I guess functions are Enums now
    if cursor_target_num == 0 then
        return params.Target_0_Lat:get()
    elseif cursor_target_num == 1 then
        return params.Target_1_Lat:get()
    elseif cursor_target_num == 2 then
        return params.Target_2_Lat:get()
    elseif cursor_target_num == 3 then
        return params.Target_3_Lat:get()
    elseif cursor_target_num == 4 then
        return params.Target_4_Lat:get()
    elseif cursor_target_num == 5 then
        return params.Target_5_Lat:get()
    elseif cursor_target_num == 6 then
        return params.Target_6_Lat:get()
    elseif cursor_target_num == 7 then
        return params.Target_7_Lat:get()
    elseif cursor_target_num == 8 then
        return params.Target_8_Lat:get()
    elseif cursor_target_num == 9 then
        return params.Target_9_Lat:get()
    end
end

local function cursor_target_long(cursor_target_num) --There's probably a more elegant way to do this
    if cursor_target_num == 0 then
        return params.Target_0_Long:get()
    elseif cursor_target_num == 1 then
        return params.Target_1_Long:get()
    elseif cursor_target_num == 2 then
        return params.Target_2_Long:get()
    elseif cursor_target_num == 3 then
        return params.Target_3_Long:get()
    elseif cursor_target_num == 4 then
        return params.Target_4_Long:get()
    elseif cursor_target_num == 5 then
        return params.Target_5_Long:get()
    elseif cursor_target_num == 6 then
        return params.Target_6_Long:get()
    elseif cursor_target_num == 7 then
        return params.Target_7_Long:get()
    elseif cursor_target_num == 8 then
        return params.Target_8_Long:get()
    elseif cursor_target_num == 9 then
        return params.Target_9_Long:get()
    end
end


local function num_cursor_targets() --gets number of non (0,0) cursor targets

    local num_targets = 0

    if params.Target_1_Lat:get() ~= 0 and params.Target_1_Lat:get() ~= 0 then
        num_targets = num_targets + 1
    end
    if params.Target_2_Lat:get() ~= 0 and params.Target_2_Lat:get() ~= 0 then
        num_targets = num_targets + 1
    end
    if params.Target_3_Lat:get() ~= 0 and params.Target_3_Lat:get() ~= 0 then
        num_targets = num_targets + 1
    end
    if params.Target_4_Lat:get() ~= 0 and params.Target_4_Lat:get() ~= 0 then
        num_targets = num_targets + 1
    end
    if params.Target_5_Lat:get() ~= 0 and params.Target_5_Lat:get() ~= 0 then
        num_targets = num_targets + 1
    end
    if params.Target_6_Lat:get() ~= 0 and params.Target_6_Lat:get() ~= 0 then
        num_targets = num_targets + 1
    end
    if params.Target_7_Lat:get() ~= 0 and params.Target_7_Lat:get() ~= 0 then
        num_targets = num_targets + 1
    end
    if params.Target_8_Lat:get() ~= 0 and params.Target_8_Lat:get() ~= 0 then
        num_targets = num_targets + 1
    end
    if params.Target_9_Lat:get() ~= 0 and params.Target_9_Lat:get() ~= 0 then
        num_targets = num_targets + 1
    end

    return num_targets

end

num_targets = num_cursor_targets()

local function rel_mag_to_coord(lat1, long1, rangeNM, bearingmag_deg, magvar) --spherical earth, rhumb lines
	local R = 6366707 -- Spherical Earth Approx. of Radius in m
	local true_bearing = deg_to_rad(bearingmag_deg) - magvar

    lat1 = deg_to_rad(lat1)
    long1 = deg_to_rad(long1)

	local adist = NM_to_m(rangeNM)/R
	local lat2 = lat1 + adist*math.cos(true_bearing)

	local dPsi = math.log(math.tan(math.pi/4+lat2/2)/(math.tan(math.pi/4+lat1/2)))

	local q = 0
	if true_bearing ~= (math.pi/2) and true_bearing ~= (3*math.pi/2) then q = (lat2-lat1)/dPsi
	else q = math.cos(lat1)
	end

	local dLong = adist*math.sin(true_bearing)/q
	local long2 = long1 + dLong

    return rad_to_deg(lat2), rad_to_deg(long2)
end

local function coord_to_rel_mag(lat1, long1, lat2, long2, magvar)
    local R = 6366707
    -- print_message_to_user(lat1.." "..long1.." "..lat2.." "..long2..' '..magvar)
    lat1 = deg_to_rad(lat1)
    lat2 = deg_to_rad(lat2)
    long1 = deg_to_rad(long1)
    long2 = deg_to_rad(long2)

    local dPsi = math.log(math.tan(math.pi/4+lat2/2)/(math.tan(math.pi/4+lat1/2)))

    local q = 0
	if lat1 == lat2 then q = math.cos(lat1)
	else q = (lat2-lat1)/dPsi
	end

    local rangeNM = m_to_NM((math.sqrt(((lat2-lat1)^2)+((q^2)*((long2-long1)^2)))*R))

    local true_bearing = math.atan2((long2-long1),dPsi)
    local mag_bearing = true_bearing + magvar

	return rad_to_deg(mag_bearing), rangeNM
end

--------------WIP-------------------
local function set_display_cursor()
    local pct_fill = 0.99
    local posx = nav_cursor_xpos:get()
    local posy = nav_cursor_ypos:get()

    local agl = math.atan2(posy, posx)
    local xrg = pct_fill * math.cos(agl)
    local yrg = pct_fill * math.sin(agl)

    local xval = math.min(math.max((-1*xrg), posx), xrg)
    local yval = math.min(math.max((-1*yrg), posy), yrg)

    if (pct_fill^2 - ((posx^2) + (posy^2)))>0 then
        nav_cursor_xpos_dsp:set(posx)
        nav_cursor_ypos_dsp:set(posy)
        cursor_cross_display:set(1)
    else
        nav_cursor_xpos_dsp:set(xrg)
        nav_cursor_ypos_dsp:set(yrg)
        cursor_cross_display:set(0)
    end
end


------------------------------------------------------------
function update()

	update_counter = update_counter + 1 --increment counter

    --headings
    nav_heading:set(sensor_data:getMagneticHeading()-Self_NorthCorrection_rad:get())
    nav_degree:set(math.deg(sensor_data:getMagneticHeading())-math.deg(Self_NorthCorrection_rad:get()))

    --clocks
    gmt_sec = (hours:get()+12)*3600
    gmt_time:set(string.format("%02.0f", math.floor(hours:get()+12))..string.format("%02.f", math.floor(mins:get()))..":"..string.format("%02.f",secs:get()))
    params.PILOT_STOPWATCH_TIME:set(string.format("%02.0f", params.PILOT_StopWatchMin:get())..":"..string.format("%02.f",params.PILOT_StopWatchSec:get()))
    params.COPILOT_STOPWATCH_TIME:set(string.format("%02.0f", params.COPILOT_StopWatchMin:get())..":"..string.format("%02.f",params.COPILOT_StopWatchSec:get()))

    --range ring values
    params.RANGE_RING_1_VAL:set(params.NAV_RADAR_RANGE:get()*0.2)
    params.RANGE_RING_2_VAL:set(params.NAV_RADAR_RANGE:get()*0.4)
    params.RANGE_RING_3_VAL:set(params.NAV_RADAR_RANGE:get()*0.6)
    params.RANGE_RING_4_VAL:set(params.NAV_RADAR_RANGE:get()*0.8)

    --rad alt rounding
    nav_agl_1 = ((sensor_data:getRadarAltitude() * 3.28084) - 15)
    nav_agl_10 = ((sensor_data:getRadarAltitude() * 3.28084) - 15)-((sensor_data:getRadarAltitude() * 3.28084) - 15)%10
    nav_agl_50 = ((sensor_data:getRadarAltitude() * 3.28084) - 15)-((sensor_data:getRadarAltitude() * 3.28084) - 15)%50

    if nav_agl_1 <= 300 then nav_agl:set(nav_agl_1)
        elseif nav_agl_1 <= 1000 then nav_agl:set(nav_agl_10)
        else nav_agl:set(nav_agl_50)
    end
    --

    ---drift cross
    xwind_comp = math.sin(Wind_rad:get())*Wind_knts:get()
    drift_angle = (math.asin(xwind_comp/HudGS:get()))
    drift_marker:set(drift_angle)
    --

    --wind arrow
    if math.cos(Wind_rad:get()) > 0 then
        params.WIND_POINT_X:set(math.sin(Wind_rad:get()))
        params.WIND_POINT_Y:set(-math.cos(Wind_rad:get()))
    else
        params.WIND_POINT_X:set(math.sin(Wind_rad:get()))
        params.WIND_POINT_Y:set(math.cos(Wind_rad:get()))
    end
    if math.cos(Wind_rad:get()) > 0 then
        params.WIND_END_X:set(-math.sin(Wind_rad:get()))
        params.WIND_END_Y:set(-math.cos(Wind_rad:get()))
    else
        params.WIND_END_X:set(-math.sin(Wind_rad:get()))
        params.WIND_END_Y:set(math.cos(Wind_rad:get()))
    end
    if math.cos(Wind_rad:get()) < 0 then
        params.WIND_HEIGHT_X:set(-math.sin(Wind_rad:get()))
        params.WIND_HEIGHT_Y:set(-math.cos(Wind_rad:get()))
    else
        params.WIND_HEIGHT_X:set(math.sin(Wind_rad:get()))
        params.WIND_HEIGHT_Y:set(math.cos(Wind_rad:get()))
    end
    if math.sin(Wind_rad:get()) > 0 and math.cos(Wind_rad:get()) > 0 then
        params.WIND_NUMBER_POSX:set(math.sin(Wind_rad:get())+0.6)
    elseif math.sin(Wind_rad:get()) <= 0 and math.cos(Wind_rad:get()) <= 0 then
        params.WIND_NUMBER_POSX:set(-math.sin(Wind_rad:get())+0.6)
    elseif math.sin(Wind_rad:get()) > 0 and math.cos(Wind_rad:get()) <= 0 then
        params.WIND_NUMBER_POSX:set(-math.sin(Wind_rad:get())-0.6)
    elseif math.sin(Wind_rad:get()) <= 0 and math.cos(Wind_rad:get()) > 0 then
        params.WIND_NUMBER_POSX:set(math.sin(Wind_rad:get())-0.6)
    end
    if math.sin(Wind_rad:get()) > 0 and math.cos(Wind_rad:get()) > 0 then
        params.WIND_NUMBER_POSHYP:set(-math.sin(2*Wind_rad:get())/5-math.cos(Wind_rad:get())/1.5)
    elseif math.sin(Wind_rad:get()) <= 0 and math.cos(Wind_rad:get()) <= 0 then
        params.WIND_NUMBER_POSHYP:set(-math.sin(2*Wind_rad:get())/5+math.cos(Wind_rad:get())/1.5)
    elseif math.sin(Wind_rad:get()) > 0 and math.cos(Wind_rad:get()) <= 0 then
        params.WIND_NUMBER_POSHYP:set(-math.sin(2*Wind_rad:get())/5-math.cos(Wind_rad:get())/1.5)
    elseif math.sin(Wind_rad:get()) <= 0 and math.cos(Wind_rad:get()) > 0 then
        params.WIND_NUMBER_POSHYP:set(-math.sin(2*Wind_rad:get())/5+math.cos(Wind_rad:get())/1.5)
    end

    params.WIND_X:set(math.abs(math.sin(Wind_rad:get())*Wind_knts:get()))
    params.WIND_Y:set(math.abs(math.cos(Wind_rad:get())*Wind_knts:get()))


    --cursor control inputs
    if cursor_next_target:get() == 1 then
        cursor_target_num = (cursor_target_num + 1)%(num_targets+1)
        cursor_next_target:set(0)
    end
    if cursor_previous_target:get() == 1 then
        cursor_target_num = (cursor_target_num - 1)%(num_targets+1)
        cursor_previous_target:set(0)
    end
    if NAV_Cursor_Forward == 1 then
        NAV_Cursor_Ypos = NAV_Cursor_Ypos + 0.025
        nav_cursor_ypos:set(NAV_Cursor_Ypos)
        -- set_display_cursor()
    end
    if NAV_Cursor_Aft == 1 then
        NAV_Cursor_Ypos = NAV_Cursor_Ypos - 0.025
        nav_cursor_ypos:set(NAV_Cursor_Ypos)
        -- set_display_cursor()

    end
    if NAV_Cursor_Left == 1 then
        NAV_Cursor_Xpos = NAV_Cursor_Xpos - 0.025
        nav_cursor_xpos:set(NAV_Cursor_Xpos)
        -- set_display_cursor()


    end
    if NAV_Cursor_Right == 1 then
        NAV_Cursor_Xpos = NAV_Cursor_Xpos + 0.025
        nav_cursor_xpos:set(NAV_Cursor_Xpos)
        -- set_display_cursor()
    end
    set_display_cursor()
    --cursor mode text
    if nav_manual_cursor:get() == 1 then
        cursor_mode_disp:set("MAN CURSOR")
    elseif nav_ground_cursor:get() == 1 then
        cursor_mode_disp:set("GND CURSOR")
    elseif nav_computer_cursor:get() == 1 then
        cursor_mode_disp:set("CMPR CURSOR")
    end
    --

    ----cursor screen position to range/bearing (Manual Cursor)----
    if nav_manual_cursor:get() == 1 then
        mag_curs_sp:set(math.sqrt((nav_cursor_xpos:get())^2+(nav_cursor_ypos:get())^2))
        cursor_range = mag_curs_sp:get()*params.NAV_RADAR_RANGE:get()
        cursor_bearing = rad_to_deg(math.atan(nav_cursor_xpos:get()/nav_cursor_ypos:get())) + nav_degree:get()

        if nav_cursor_ypos:get() < 0.0 then
            cursor_bearing = cursor_bearing + 180
        elseif nav_cursor_xpos:get() < 0.0 then
            cursor_bearing = cursor_bearing + 360
        elseif nav_cursor_xpos:get() == 0.0 and nav_cursor_ypos:get() == 0.0 then
            cursor_bearing = 0
        end

        if cursor_bearing >= 360 then cursor_bearing = cursor_bearing - 360
        end

        --cursor coordinates
        local lat_temp, long_temp = rel_mag_to_coord(self_lat_deg:get(), self_long_deg:get(), cursor_range, cursor_bearing, Self_NorthCorrection_rad:get())
        cursor_lat_deg:set(lat_temp)
        cursor_long_deg:set(long_temp)

        cursor_pressed:set(0)
    end

    ----range/bearing to cursor screen position, no slew (Computer Cursor)----
    if nav_computer_cursor:get() == 1 then
        cursor_lat_deg:set(cursor_target_lat(cursor_target_num))
        cursor_long_deg:set(cursor_target_long(cursor_target_num))

        local mag_bearing, range = coord_to_rel_mag(self_lat_deg:get(), self_long_deg:get(), cursor_lat_deg:get(), cursor_long_deg:get(), Self_NorthCorrection_rad:get())

        cursor_range = range
        cursor_bearing = mag_bearing

        local bearing_from_nose = deg_to_rad(cursor_bearing - nav_degree:get())

        nav_cursor_xpos:set(math.sin(bearing_from_nose)*cursor_range/params.NAV_RADAR_RANGE:get())
        nav_cursor_ypos:set(math.cos(bearing_from_nose)*cursor_range/params.NAV_RADAR_RANGE:get())
        set_display_cursor()

        if cursor_bearing < 0 then cursor_bearing = cursor_bearing + 360 end

        cursor_pressed:set(0)
    end

    ----range/bearing to cursor screen position, with slew (Ground Cursor)----
    if nav_ground_cursor:get() == 1 then
        if cursor_pressed:get() == 0 then
            NAV_Cursor_Xpos = nav_cursor_xpos:get()
            NAV_Cursor_Ypos = nav_cursor_ypos:get()

            local mag_bearing, range = coord_to_rel_mag(self_lat_deg:get(), self_long_deg:get(), cursor_lat_deg:get(), cursor_long_deg:get(), Self_NorthCorrection_rad:get())

            cursor_range = range
            cursor_bearing = mag_bearing

            local bearing_from_nose = deg_to_rad(cursor_bearing - nav_degree:get())

            nav_cursor_xpos:set(math.sin(bearing_from_nose)*cursor_range/params.NAV_RADAR_RANGE:get())
            nav_cursor_ypos:set(math.cos(bearing_from_nose)*cursor_range/params.NAV_RADAR_RANGE:get())
            set_display_cursor()

            if cursor_bearing < 0 then cursor_bearing = cursor_bearing + 360 end

        end

        if cursor_pressed:get() == 1 then

            mag_curs_sp:set(math.sqrt((nav_cursor_xpos:get())^2+(nav_cursor_ypos:get())^2))
            cursor_range = mag_curs_sp:get()*params.NAV_RADAR_RANGE:get()
            cursor_bearing = rad_to_deg(math.atan(nav_cursor_xpos:get()/nav_cursor_ypos:get())) + nav_degree:get()

            if nav_cursor_ypos:get() < 0.0 then
                cursor_bearing = cursor_bearing + 180
            elseif nav_cursor_xpos:get() < 0.0 then
                cursor_bearing = cursor_bearing + 360
            elseif nav_cursor_xpos:get() == 0.0 and nav_cursor_ypos:get() == 0.0 then
                cursor_bearing = 0
        end

        if cursor_bearing >= 360 then cursor_bearing = cursor_bearing - 360
        end

        --cursor coordinates
        local lat_temp, long_temp = rel_mag_to_coord(self_lat_deg:get(), self_long_deg:get(), cursor_range, cursor_bearing, Self_NorthCorrection_rad:get())
        cursor_lat_deg:set(lat_temp)
        cursor_long_deg:set(long_temp)

        cursor_pressed:set(0)
        end
    end

    ----Coord/Range/Bearing Formatting----

    --lat/long decimal to displayable DDD MM.MM
    self_long_DDD = math.floor(self_long_deg:get())
    self_lat_DDD = math.floor(self_lat_deg:get())
    self_long_mmmm = (self_long_deg:get() - self_long_DDD)*60
    self_lat_mmmm = (self_lat_deg:get() - self_lat_DDD)*60

    if self_lat_DDD >= 0 then
        self_lat_hemi = "N"
    else self_lat_hemi = "S"
    end

    if self_lat_DDD >= 0 then
        self_long_hemi = "E"
    else self_long_hemi = "W"
    end

    cursor_long_DDD = math.floor(cursor_long_deg:get())
    cursor_lat_DDD = math.floor(cursor_lat_deg:get())
    cursor_long_mmmm = (cursor_long_deg:get() - cursor_long_DDD)*60
    cursor_lat_mmmm = (cursor_lat_deg:get() - cursor_lat_DDD)*60

    if cursor_lat_DDD >= 0 then
        cursor_lat_hemi = "N"
    else cursor_lat_hemi = "S"
    end

    if cursor_lat_DDD >= 0 then
        cursor_long_hemi = "E"
    else cursor_long_hemi = "W"
    end

    --line from ownship to cursor
    cursor_bearing_nose:set(deg_to_rad(cursor_bearing-nav_degree:get()))

    --cursor range/bearing output
    cursor_rel:set(string.format("%03.0f", cursor_bearing).."/"..string.format("%.1f", cursor_range))

    --cursor coord output
    cursor_pos:set(string.format("%s", cursor_lat_hemi)..string.format("%02.0f", math.abs(cursor_lat_DDD)).."° "..string.format("%05.2f", math.abs(cursor_lat_mmmm))
    .."   "..string.format("%s", cursor_long_hemi)..string.format("%03.0f", math.abs(cursor_long_DDD)).."° "..string.format("%05.2f", math.abs(cursor_long_mmmm)))


    if current_wpt == nil then
        params.CURRENT_WAYPOINT:set("XXXXXX")
    end

    if current_wpt == nil then
        params.WPT_REL:set("XXX/XXX.X")
    end

    if current_wpt == nil then
        params.TTG:set("XXX:XX")
    end

    if current_wpt == nil then
        params.ETA:set("XXXX:XX")
    end

    if current_wpt == nil then
        xtk_value = nil
    end


    if xtk_value == nil then
        params.XTK_LR:set("X")
        params.XTK_VAL_DISP:set("XXXX")
    end

    tot_sec = 0
    tot_dist = 0

    for i = 1, (params.TOT_WAYPOINT:get()-1) do

        if i > current_leg then
            local leg_length = get_param_handle("LEG_"..i.."_LENGTH")
            local leg_time_sec = (leg_length:get()/perf_cruise_speed)*3600
            tot_sec = tot_sec + leg_time_sec
            tot_dist = tot_dist + leg_length:get()
        end
    end


    tot_sec = tot_sec + ttg_H*3600 + ttg_M*60 + ttg_S + gmt_sec
    tot_dist = tot_dist + range_wpt


    tot_S = math.floor((tot_sec) % 60)
    tot_M = math.floor(((tot_sec - tot_S)/60) % 60)
    tot_H = math.floor(tot_sec/3600) % 24


    if update_counter % 15 == 0 then
        params.TOT_TIME:set(string.format("%02.0f", tot_H)..string.format("%02.0f", tot_M)..":​"..string.format("%02.0f", tot_S))
    end

    tgs = math.max(math.min(tot_dist*3600/(tot - gmt_sec), 999), 0)

    if update_counter % 15 == 0 then
        params.TGS_INDC:set(string.format("%03.0f", tgs).." ​")
    end


end

function post_initialize()

end
