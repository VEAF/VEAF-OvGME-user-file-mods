dofile(LockOn_Options.script_path.."command_defs.lua")

-- This script is just to update connectors' position

local dev = GetSelf()
local update_time_step = 0.5
make_default_activity(update_time_step) -- enables call to update


function post_initialize()   

end


function SetCommand(command,value)
	
	
end

function update()
	local canopy_clickable_ref = get_clickable_element_reference("PNT_001")
	canopy_clickable_ref:update()
			
	local MasterLightSw_CR = get_clickable_element_reference("PNT_400")
	MasterLightSw_CR:update()
	
	local FingerLift_CR = get_clickable_element_reference("PNT_005")
	FingerLift_CR:update()
	
	local GTSbutton_CR = get_clickable_element_reference("PNT_035")
	GTSbutton_CR:update()
		
	local MICbutton_CR = get_clickable_element_reference("PNT_294")
	MICbutton_CR:update()
	
end

need_to_be_closed = false -- close lua state after initialization
