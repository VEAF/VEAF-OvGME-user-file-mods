dofile(LockOn_Options.script_path.."command_defs.lua")


local dev = GetSelf()
local update_time_step = 0.033
make_default_activity(update_time_step)--update will be called 30 times per second
local sensor_data = get_base_data()

--local Terrain = require('terrain')

local meter2mile = 0.000621371
local meter2feet = 3.28084
local meterToNauticalMile = 1/1852
local degrees_per_radian = 57.2957795
local mps_to_knot = 1.94384

wyptOutput = {}
for i=1,11 do
	wyptOutput[i] = {
		waypoint_range = get_param_handle("WAYPOINT"..i.."RANGE"),
		waypoint_bearing = get_param_handle("WAYPOINT"..i.."BEARING")
	}
end
local SelWyptRange = get_param_handle("SELECTED_WAYPOINT_RANGE")
local SelWyptBearing = get_param_handle("SELECTED_WAYPOINT_BEARING")
local CDI_deviation = get_param_handle("CDI_DEVIATION")
local CDI_deviation = get_param_handle("CDI_DEVIATION")
local CDI_deviation_dot_draw = get_param_handle("CDI_DOT_DRAW")
local PLAN_origin_LR = get_param_handle("PLAN_ORIGIN_LR")
local PLAN_origin_UD = get_param_handle("PLAN_ORIGIN_UD")
local PLAN_draw = get_param_handle("PLAN_DRAW")
local TACAN_TTG_mins = get_param_handle("TACAN_TTG_MINS")
local TACAN_TTG_secs = get_param_handle("TACAN_TTG_SECS")
local WYPT_TTG_mins = get_param_handle("WYPT_TTG_MINS")
local WYPT_TTG_secs = get_param_handle("WYPT_TTG_SECS")

------- inputs only ----
local tacanBearing = get_param_handle("TACAN_BEARING")
local tacanRange = get_param_handle("TACAN_RANGE")
local courseBearing = get_param_handle("HSI_CRS_SET")
local tacan_selected = get_param_handle("TACAN_SELECTED")
local vor_selected = get_param_handle("VOR_SELECTED")
local vorBearing = get_param_handle("VOR_BEARING")
local waypoint_selected = get_param_handle("WAYPOINT_SELECTED")
local active_waypoint = get_param_handle("ACTIVE_WAYPOINT") -- 0-10
local HSI_scale = get_param_handle("HSI_SCALE") 
local current_groundspeed = get_param_handle("CURRENT_GS")
local groundspeed_direction = get_param_handle("GROUND_TRACK")
-----------

local waypointData = {} -- 1 is home base ("0" in ME), 2 is first waypoint "1" in ME, etc.
function post_initialize()
    waypointData = get_mission_route() -- get waypoints x,y,alt that were set in mission editor
end


function SetCommand(command,value)  
end

function update_waypoints()
	for i=1,11 do
		if waypointData[i] then
			bearing, range = get_waypoint_brg_rng(waypointData[i].x, waypointData[i].y)
			wyptOutput[i].waypoint_range:set(range)
			wyptOutput[i].waypoint_bearing:set(bearing)
		else
			wyptOutput[i].waypoint_range:set(-1) -- this is so it can disappear when the waypoint doesn't exist
			wyptOutput[i].waypoint_bearing:set(-1)
		end
	end
end

function get_waypoint_brg_rng(Xcoord, Ycoord) -- note: Y is usually altitude in DCS coordinates, but in get_mission_route() Y is the lateral coordinate (normally Z)
	local selfX,selfY,selfZ = sensor_data.getSelfCoordinates()
	local bearing = math.deg(math.atan2((Ycoord-selfZ),(Xcoord-selfX)))%360
	local range = math.sqrt((Xcoord - selfX)^2 + (Ycoord - selfZ)^2)*meterToNauticalMile

	return bearing, range
end

function update_CDI_deviation()
local gearPos = get_aircraft_draw_argument_value(0)
	if tacan_selected:get()==1 then
		CDI_deviation:set((tacanBearing:get()-courseBearing:get())/10) -- TACAN full deviation: 10 deg
		if CDI_deviation:get()>1 then CDI_deviation:set(1) end
		if CDI_deviation:get()<-1 then CDI_deviation:set(-1) end
	elseif vor_selected:get()==1 then
		CDI_deviation:set((vorBearing:get()-courseBearing:get())/10) -- VOR full deviation: 10 deg
		if CDI_deviation:get()>1 then CDI_deviation:set(1) end
		if CDI_deviation:get()<-1 then CDI_deviation:set(-1) end
	elseif waypoint_selected:get()==1 then 				-- waypoint full deviation 4nm gear up, 0.3nm gear down
		local perpDist = SelWyptRange:get()*math.sin(math.rad(SelWyptBearing:get() - courseBearing:get())) -- trig to find perpendicular distance
		if gearPos >= 0.9 then
			CDI_deviation:set(perpDist/0.3)
		else
			CDI_deviation:set(perpDist/4)
		end
		if CDI_deviation:get()>1 then CDI_deviation:set(1) end
		if CDI_deviation:get()<-1 then CDI_deviation:set(-1) end
	else
		CDI_deviation:set(0)
	end
end

function update_PLAN_origin()
	local scale = HSI_scale:get() -- 10,20,40,80,160
	if tacan_selected:get()==1 then
		PLAN_origin_LR:set( tacanRange:get()*math.sin(math.rad(tacanBearing:get())) /scale )
		PLAN_origin_UD:set( tacanRange:get()*math.cos(math.rad(tacanBearing:get())) /scale )
		PLAN_draw:set(1)
	elseif waypoint_selected:get()==1 then
		PLAN_origin_LR:set( SelWyptRange:get()*math.sin(math.rad(SelWyptBearing:get())) /scale )
		PLAN_origin_UD:set( SelWyptRange:get()*math.cos(math.rad(SelWyptBearing:get())) /scale )
		PLAN_draw:set(1)
	else
		PLAN_origin_LR:set(0)
		PLAN_origin_UD:set(0)
		PLAN_draw:set(0)
	end
end

function calculateTTG(range, bearing)
	local Vx, Vy, Vz = sensor_data.getSelfVelocity()--- DCS world axis: x is +north, y is +up, z is +east
	local groundDir = math.deg(math.atan2(Vz,Vx))
	if groundDir < 0 then
		groundDir = groundDir +360
	end
	local directVelocity = current_groundspeed:get()*math.cos(math.rad(groundDir-bearing))	--speed toward nav mark 
	if directVelocity<0 then directVelocity=0.00 end
	local hoursToGo = (range/directVelocity)
	
    local int,frac = math.modf(hoursToGo)
    local minutesTG = math.floor(frac*60)
	local int1,frac1 = math.modf(frac*60)
	local secondsTG = frac1*60
	return minutesTG, secondsTG
end

function update()
	update_waypoints()
	update_CDI_deviation()
	update_PLAN_origin()
	
	if vor_selected:get()==1 or tacan_selected:get()==1 or waypoint_selected:get()==1 then
		CDI_deviation_dot_draw:set(1)
	else
		CDI_deviation_dot_draw:set(0)
	end
	
	local tacanMin, tacanSec = calculateTTG(tacanRange:get(), tacanBearing:get())
	TACAN_TTG_mins:set(tacanMin)
	TACAN_TTG_secs:set(tacanSec)
	
	local waypointMin, waypointSec = calculateTTG(wyptOutput[active_waypoint:get()+1].waypoint_range:get(), wyptOutput[active_waypoint:get()+1].waypoint_bearing:get())
	WYPT_TTG_mins:set(waypointMin)
	WYPT_TTG_secs:set(waypointSec)
	
	SelWyptBearing:set(wyptOutput[active_waypoint:get()+1].waypoint_bearing:get())
	SelWyptRange:set(wyptOutput[active_waypoint:get()+1].waypoint_range:get())

end

need_to_be_closed = false -- close lua state after initialization

--[[
TACAN and VOR: full deviation 10 deg
ILS: based on loc size
Waypoint landing gear down: 0.3 nm full dev
waypoint landing gear up: 4nm full dev
]]