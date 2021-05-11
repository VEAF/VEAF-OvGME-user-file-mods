dofile(LockOn_Options.script_path.."Displays/MFDDefs.lua")

local origin	         = CreateElement "ceSimple"
origin.name 		     = "gps_origin"
origin.element_params 	 = {"MFDR_ONOFF","MFDR_PAGE"} 
origin.controllers   	 = {{"parameter_in_range",0,1},{"parameter_in_range",1,GPSDATAPage}}
Add(origin)

-------- Option Button Labels -----------------
local WYPTua = addOBLabel("WYPTupArrowlabel", {horizontalPos(94),verticalPos(36)}, ">", origin.name)
	WYPTua.init_rot = {90}
	WYPTua.stringdefs = {0.008,1.5*0.008, 0, 0}
addOBLabel("WYPTNumlabel", {horizontalPos(94) ,verticalPos(18) }, "0", origin.name) -- TODO: this needs to be dynamic 
local WYPTda = addOBLabel("WYPTdownArrowlabel", {horizontalPos(94),0}, ">", origin.name)
	WYPTda.init_rot = {-90}
	WYPTda.stringdefs = {0.008,1.5*0.008, 0, 0}
addOBLabel("XFERabel", OB9pos, "X\nF\nE\nR", origin.name)
addOBLabel("WYPTlabel", OB14pos, "WYPT", origin.name)
addOBLabel("ACFTlabel", OB15pos, "ACFT", origin.name)
addOBLabel("ADIlabel", OB16pos, "A\nD\nI", origin.name)
addOBLabel("HSIlabel", OB17pos, "H\nS\nI", origin.name)
addOBLabel("APCHlabel", OB18pos, "A\nP\nC\nH", origin.name)
addOBLabel("NORMlabel", OB19pos, "N\nO\nR\nM", origin.name)
------------------------------------------------------------------------------------

addText("placeholder", {horizontalPos(-50), verticalPos(20)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}}, 		{"GPS WAYPOINT INFO  \n PLACEHOLDER "}, origin.name, "LeftCenter") 



--TODO: Will implementing GPS waypoints be viable/practicle?
