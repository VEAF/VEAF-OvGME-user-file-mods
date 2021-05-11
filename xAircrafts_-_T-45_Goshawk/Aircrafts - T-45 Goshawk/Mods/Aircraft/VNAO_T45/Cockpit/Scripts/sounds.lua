--[[
sounds ids 1 ... n
]]
local count = 0
local function counter()
	count = count + 1
	return count
end

SOUND_NOSOUND = -1
SWITCH_SOUND_1 = counter()
SWITCH_SOUND_2 = counter()
SWITCH_SOUND_3 = counter()

