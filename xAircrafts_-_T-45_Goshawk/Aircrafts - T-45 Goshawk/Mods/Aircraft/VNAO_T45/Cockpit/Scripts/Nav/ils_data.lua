dofile(LockOn_Options.script_path.."Nav/NAV_util.lua") 

local fileName =  get_terrain_related_data("beacons") or get_terrain_related_data("beaconsFile")
if fileName then 
	local f = loadfile(fileName)
	if f then
		f()
	end
end

local Terrain	= require('terrain')

terrainAirdromes = get_terrain_related_data("Airdromes") or {};

local ils_loc = {}
local ils_gs = {}

local degrees_per_radian = 57.2957795

if next(terrainAirdromes) == not nil then -- Caucasus format
  for i,o in pairs(Airdrome) do
    if terrainAirdromes[i] then
      local roadnet = terrainAirdromes[i].roadnet
      if roadnet then
        if o.runway then
          for sideRangeName, ranges in pairs(o.runway) do
            if ranges.side then
              for sideName, sides in pairs(ranges.side) do
                for j, side in ipairs(sides) do
                  local sideType = side.type
                  
                  if sideType == NAV_TYPE_ILS_LOC then
                   for ii, runway in pairs(Terrain.getRunwayList(roadnet)) do
                      local sideX, sideY, angle	= getBeaconPlacement(sideName, runway, roadnet)
                      angle = angle * degrees_per_radian
                      if angle < 0 then angle = angle + 360 end
                      local ilsalt = math.floor(Terrain.GetHeight(sideX, sideY) + 0.5)
                      
                      local	homer_data = {
                                            name        = terrainAirdromes[i].names.en.."-"..sideName.."-ILS_LOC",
                                            beaconId    = "",
                                            ntype       = sideType,
                                            callsign    = side.callsign or nil,
                                            frequency   = side.frequency,
                                            channel     = side.channel or nil,
                                            position    = {x = sideX, z = sideY, y = ilsalt}, -- in-game xyz
                                            direction   = angle,
                                            positionGeo = position or nil, -- lat/long
                                          }
                      
                      ils_loc[#ils_loc + 1] = NAV_STATION1(homer_data)
                    end
                  end
                  
                  if sideType == NAV_TYPE_ILS_GS then                    
                    for ii, runway in pairs(Terrain.getRunwayList(roadnet)) do
                      local sideX, sideY, angle	= getBeaconPlacement(sideName, runway, roadnet)
                      if angle < 0 then angle = angle + 360 end
                      local ilsalt = math.floor(Terrain.GetHeight(sideX, sideY) + 0.5)

                      local	homer_data = {
                                            name        = terrainAirdromes[i].names.en.."-"..sideName.."-ILS_GS",
                                            beaconId    = "",
                                            ntype       = sideType,
                                            callsign    = side.callsign or nil,
                                            frequency   = side.frequency,
                                            channel     = side.channel or nil,
                                            position    = {x = sideX, z = sideY, y = ilsalt}, -- in-game xyz
                                            direction   = angle,
                                            positionGeo = position or nil, -- lat/long
                                          }
                      
                      ils_gs[#ils_gs + 1] = NAV_STATION1(homer_data)
                    end
                  end                  
                end
              end
            end
          end	
        end
      end
    end
  end
else -- NTTR/Normandy/PG
	for i,o in pairs(beacons) do
		if o.type == NAV_TYPE_ILS_LOC then
			ils_loc[#ils_loc + 1] = NAV_STATION2(o)
		elseif o.type == NAV_TYPE_ILS_GS then
			ils_gs[#ils_gs + 1] = NAV_STATION2(o)
		end	
	end
end

return ils_loc, ils_gs
