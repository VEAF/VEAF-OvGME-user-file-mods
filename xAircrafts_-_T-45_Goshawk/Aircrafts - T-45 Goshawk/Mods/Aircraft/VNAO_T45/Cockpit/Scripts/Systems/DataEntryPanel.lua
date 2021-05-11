dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()
local update_time_step = 0.1 --update will be called 10 times per second
make_default_activity(update_time_step)

local scratchpad = get_param_handle("SCRATCH_PAD")
scratchpad:set(" ")
local scratchOn = get_param_handle("SCRATCH_ON")
local masterMode = get_param_handle("MASTER_MODE")
masterMode:set(0)
local declutter_level = get_param_handle("DECLUTTER_LEVEL") -- 0: normal, 1: declutter 1, 2: declutter 2
declutter_level:set(0)
local bingo = get_param_handle("BINGO") 
bingo:set(900)
local law = get_param_handle("LAW") 
law:set(500)
local HDG = get_param_handle("HSI_HDG_SET") 
HDG:set(0)
local CRS = get_param_handle("HSI_CRS_SET") 
CRS:set(0)
local depression = get_param_handle("MIL_DEPRESSION") 
depression:set(140)

BingoSet = false
LAWSet = false
CourseSet = false
HeadingSet = false
NumString=""

dev:listen_command(device_commands.DEP1)
dev:listen_command(device_commands.DEP2)
dev:listen_command(device_commands.DEP3)
dev:listen_command(device_commands.DEP4)
dev:listen_command(device_commands.DEP5)
dev:listen_command(device_commands.DEP6)
dev:listen_command(device_commands.DEP7)
dev:listen_command(device_commands.DEP8)
dev:listen_command(device_commands.DEP9)
dev:listen_command(device_commands.DEP0)
dev:listen_command(device_commands.DEPenter)
dev:listen_command(device_commands.DEPclear)
dev:listen_command(device_commands.DEPdeclutter)
dev:listen_command(device_commands.DEPmode)
dev:listen_command(device_commands.DEPlaw)
dev:listen_command(device_commands.DEPcrs)
dev:listen_command(device_commands.DEPhdg)
dev:listen_command(device_commands.DEPbingo)
dev:listen_command(device_commands.DEPdepressionUp)
dev:listen_command(device_commands.DEPdepressionDown)


local placeholder={}	-- initialize array
for i=1,6 do
	placeholder[i]=""
end
local maxDigits = 6 -- max number of digits to be entered
function enterNumber(digit)
	if CourseSet or HeadingSet then
		maxDigits = 3
	elseif BingoSet or LAWSet then
		maxDigits = 4
	else
		maxDigits = 6
	end
	for i=1,maxDigits do
		if placeholder[i] == "" then
		placeholder[i] = (digit)
		break
		end
	end
end

function clearAll() -- make sure other inputs aren't conflicting
	BingoSet = false
	LAWSet = false
	CourseSet = false
	HeadingSet = false
end

function SetCommand(command,value)
	if value == 1 then -- a button press will trigger SetCommand twice, once at arg=1 and again at arg=0 so this only allows one input
	if command >= device_commands.DEP1 and command <= device_commands.DEP9 then
		enterNumber(command-device_commands.DEP1+1)
	elseif command == device_commands.DEP0 then
		enterNumber(0)
	elseif command == device_commands.DEPclear then
		if placeholder[1] ~= "" then
			for i=1,6 do
				placeholder[i]=""
			end
		else
			clearAll()
		end
	elseif command == device_commands.DEPbingo then
		clearAll()
		BingoSet = true
	elseif command == device_commands.DEPlaw then
		clearAll()
		LAWSet = true
	elseif command == device_commands.DEPcrs then
		clearAll()
		CourseSet = true
	elseif command == device_commands.DEPhdg then
		clearAll()
		HeadingSet = true
	elseif command == device_commands.DEPmode then
		if masterMode:get()==2 then 
			masterMode:set(0) 
		else
			masterMode:set(masterMode:get()+1)
		end
	elseif command == device_commands.DEPdeclutter then
		if declutter_level:get()==2 then 
			declutter_level:set(0) 
		else
			declutter_level:set(declutter_level:get()+1)
		end
	elseif command == device_commands.DEPenter then
		if BingoSet and tonumber(NumString) <= 3000 then
			bingo:set(NumString)
		elseif LAWSet then
			law:set(NumString)
		elseif CourseSet and tonumber(NumString) < 360 then
			CRS:set(NumString)
		elseif HeadingSet and tonumber(NumString) < 360 then
			HDG:set(NumString)
		end
		clearAll()
		for i=1,6 do
				placeholder[i]=""
		end
	elseif command == device_commands.DEPdepressionUp then
		local milDep = depression:get()+10
		if milDep>270 then milDep=270 end
		depression:set(milDep)
	elseif command == device_commands.DEPdepressionDown then
		local milDep = depression:get()-10
		if milDep<0 then milDep=0 end
		depression:set(milDep)
	end
	end
end

function update()
	if BingoSet then
		scratchOn:set(1)
		NumString = (placeholder[1]..placeholder[2]..placeholder[3]..placeholder[4]..placeholder[5]..placeholder[6])
		scratchpad:set("BF \t"..NumString)
	elseif LAWSet then
		scratchOn:set(1)
		NumString = (placeholder[1]..placeholder[2]..placeholder[3]..placeholder[4]..placeholder[5]..placeholder[6])
		scratchpad:set("LW \t"..NumString)
	elseif CourseSet then
		scratchOn:set(1)
		NumString = (placeholder[1]..placeholder[2]..placeholder[3]..placeholder[4]..placeholder[5]..placeholder[6])
		scratchpad:set("CS \t"..NumString)
	elseif HeadingSet then
		scratchOn:set(1)
		NumString = (placeholder[1]..placeholder[2]..placeholder[3]..placeholder[4]..placeholder[5]..placeholder[6])
		scratchpad:set("CH \t"..NumString)
	else
		scratchOn:set(0)
		NumString=""
	end

	
--print_message_to_user(bingo:get())
end

need_to_be_closed = false 