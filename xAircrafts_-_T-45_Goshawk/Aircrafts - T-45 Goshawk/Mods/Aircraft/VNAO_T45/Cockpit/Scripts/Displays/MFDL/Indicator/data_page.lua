dofile(LockOn_Options.script_path.."Displays/MFDDefs.lua")

local origin	         = CreateElement "ceSimple"
origin.name 		     = "data_origin"
origin.element_params 	 = {"MFDL_ONOFF","MFDL_PAGE"} 
origin.controllers   	 = {{"parameter_in_range",0,1},{"parameter_in_range",1,DATAPage}}
Add(origin)

-------- Option Button Labels ---------
addOBLabel("Latlabel", OB2pos, "LAT", origin.name)
addOBLabel("LONGlabel", OB3pos, "LONG", origin.name)
addOBLabel("ELEVlabel", OB4pos, "ELEV", origin.name)
addOBLabel("MVARlabel", OB5pos, "MVAR", origin.name)
local WYPTua = addOBLabel("WYPTupArrowlabel", {horizontalPos(94),verticalPos(36)}, ">", origin.name)
	WYPTua.init_rot = {90}
	WYPTua.stringdefs = {0.008,1.5*0.008, 0, 0}
addOBLabel("WYPTNumlabel", {horizontalPos(94) ,verticalPos(18) }, "0", origin.name) -- TODO: this needs to be dynamic 
local WYPTda = addOBLabel("WYPTdownArrowlabel", {horizontalPos(94),0}, ">", origin.name)
	WYPTda.init_rot = {-90}
	WYPTda.stringdefs = {0.008,1.5*0.008, 0, 0}
addOBLabel("DEPlabel", OB10pos, "D\nE\nP", origin.name)
addOBLabel("SEQlabel", {horizontalPos(86) ,verticalPos(-72)}, "S\nE\nQ", origin.name)
addOBLabel("GPSlabel", OB12pos, "GPS", origin.name)
addOBLabel("ACFTlabel", OB15pos, "ACFT", origin.name)
addOBLabel("ADIlabel", OB16pos, "A\nD\nI", origin.name)
addOBLabel("HSIlabel", OB17pos, "H\nS\nI", origin.name)
addOBLabel("ELEVlabel", OB18pos, "E\nL\nE\nV", origin.name)
addOBLabel("OSlabel", {horizontalPos(-86),0}, "O\n/\nS", origin.name)
addOBLabel("BRGlabel", OB19pos, "B\nR\nG", origin.name)
addOBLabel("OSlabel", {horizontalPos(-86),verticalPos(36)}, "O\n/\nS", origin.name)
addOBLabel("RNGlabel", OB20pos, "R\nN\nG", origin.name)
addOBLabel("OSlabel", {horizontalPos(-86),verticalPos(72)}, "O\n/\nS", origin.name)
------------------------------------------------------------------------------------

addText("waypoint", {horizontalPos(-50), verticalPos(40)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}}, 		{"WYPT  \t  INOP"}, origin.name, "LeftCenter") 
addText("latitude", {horizontalPos(-50), verticalPos(30)}, {"CURRENT_FF"}, {{"text_using_parameter",0,0}}, 			{"LAT    \t\t INOP"}, origin.name, "LeftCenter") 
addText("longitude", {horizontalPos(-50), verticalPos(20)}, {"CURRENT_FUELT"}, {{"text_using_parameter",0,0}},		{"LONG \t\t INOP"}, origin.name, "LeftCenter") 
addText("elevation", {horizontalPos(-50), verticalPos(10)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}},		{"ELEV   \t INOP"}, origin.name, "LeftCenter") 
addText("magnVariation", {horizontalPos(-50), verticalPos(0)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}}, 	{"MVAR \t\t INOP"}, origin.name, "LeftCenter") 
addText("offsetRange", {horizontalPos(-50), verticalPos(-10)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}},		{"O/S RNG  \tINOP"}, origin.name, "LeftCenter") 
addText("offsetBearing", {horizontalPos(-50), verticalPos(-20)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}},	{"O/S BRG  \tINOP"}, origin.name, "LeftCenter") 
addText("offsetElevation", {horizontalPos(-50), verticalPos(-30)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}}, {"O/S ELEV \tINOP"}, origin.name, "LeftCenter") 

--TODO: Scratchpad, waypoint sequence, add element data
