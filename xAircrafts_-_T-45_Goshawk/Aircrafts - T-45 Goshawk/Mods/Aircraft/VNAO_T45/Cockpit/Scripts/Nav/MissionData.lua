dofile(LockOn_Options.common_script_path.."tools.lua")
	

local missionDir = lfs.tempdir()
local cfile     = lfs.writedir()..'Data\\tempMission.lua'
local userPath  = lfs.writedir()..'Data\\'

function scandir(directory)
	local i, t = 0, {}
	for file in lfs.dir(directory) do
		if string.match(file, "~mis") then
			i = i + 1
			t[i] = directory .. file
		end
	end
	return t
end

function findMissionFile(fileList)
	local correctFile = 0
	local newest = 0
	local file_attr

	for fileNumber, filepath in pairs(fileList) do
	
		file = io.open(filepath, "r") 
	
		local fLine = file:read()
		
		if string.match(fLine, "mission") then
			file_attr = lfs.attributes(filepath)
			if file_attr.modification > newest then
				correctFile = filepath
				newest = file_attr.modification
			end
		end
		if file then
		file:close()
		end
	end
	return correctFile
	
end

function copyFile(fpath, cpath)
	infile = io.open(fpath, "r")
	instr = infile:read("*a")
	infile:close()

	outfile = io.open(cpath, "w+")
	outfile:write(instr)
	outfile:close()
end


function load_tempmission_file()

	local fList = scandir(missionDir)
	local rf 	= findMissionFile(fList)
	copyFile(rf, cfile)

	dofile(userPath..'tempMission.lua')

end


------------------ Carrier TACAN  ----------------------------------------

function get_carrier_data()
	local miz_carriers = {}

	if mission then
		for i = 1,#mission.coalition.blue.country do
			if mission.coalition.blue.country[i].ship then
				for ig = 1,#mission.coalition.blue.country[i].ship.group do
					for iu = 1,#mission.coalition.blue.country[i].ship.group[ig].units do
						local tacan = -1	
						local speed = mission.coalition.blue.country[i].ship.group[ig].route.points[1].speed
						--local speed2 = mission.coalition.blue.country[i].ship.group[ig].route.points[2].speed
						for it = 1 ,#mission.coalition.blue.country[i].ship.group[ig].route.points	do
							
							for itt = 1,#mission.coalition.blue.country[i].ship.group[ig].route.points[it].task.params.tasks do
								if mission.coalition.blue.country[i].ship.group[ig].route.points[it].task.params.tasks[itt].params.action then
									if mission.coalition.blue.country[i].ship.group[ig].route.points[it].task.params.tasks[itt].params.action.id == "ActivateBeacon"	then
										tacan = mission.coalition.blue.country[i].ship.group[ig].route.points[it].task.params.tasks[itt].params.action.params.channel
									end		
								end
							end					
							
						end
						
							miz_carriers[#miz_carriers+1] = {
								
								x 		= mission.coalition.blue.country[i].ship.group[ig].units[iu].x,
								z 		= mission.coalition.blue.country[i].ship.group[ig].units[iu].y,
								heading = mission.coalition.blue.country[i].ship.group[ig].units[iu].heading,
								tacan	= tacan,
								speed	= speed,
								--speed2	= speed2,
								act_x	= mission.coalition.blue.country[i].ship.group[ig].units[iu].x,
								act_z	= mission.coalition.blue.country[i].ship.group[ig].units[iu].y,
															}
					end
				end
			end
		end
	end
	
	return miz_carriers
end

function update_carrier_tacan()
local carrier_tacan = {}
	local new_x,new_z
	if miz_carriers then
		for i = 1,#miz_carriers do
			local act_travel_dist = model_time * miz_carriers[i].speed -- seconds*m/s=meters traveled
			new_x,new_z = pnt_dir(miz_carriers[i].x, miz_carriers[i].z, miz_carriers[i].heading, act_travel_dist)

			miz_carriers[i].act_x = new_x
			miz_carriers[i].act_z = new_z								

			carrier_tacan[i] = {
					channel = miz_carriers[i].tacan,
					position = {x = miz_carriers[i].act_x,
								y = 21,
								z = miz_carriers[i].act_z,},
					}
		end
	end
	return carrier_tacan
end

function pnt_dir(pnt_x,pnt_z,angle_rad,distance)
	local new_x,new_z
	
	if angle_rad < 0 then angle_rad = angle_rad + math.rad(360) end
		
	new_z = pnt_z + (distance * math.sin(angle_rad))
	new_x = pnt_x + (distance * math.cos(angle_rad))

	return new_x,new_z
end
