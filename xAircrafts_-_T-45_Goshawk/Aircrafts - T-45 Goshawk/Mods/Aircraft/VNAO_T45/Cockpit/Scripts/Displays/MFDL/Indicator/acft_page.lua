dofile(LockOn_Options.script_path.."Displays/MFDDefs.lua")

local origin	         = CreateElement "ceSimple"
origin.name 		     = "acft_origin"
origin.element_params 	 = {"MFDL_ONOFF","MFDL_PAGE"} 
origin.controllers   	 = {{"parameter_in_range",0,1},{"parameter_in_range",1,ACFTDATAPage}}
Add(origin)

-------- Option Button Labels -----------------
addOBLabel("RSTlabel", OB7pos, "R\nS\nT", origin.name)
addOBLabel("DGROlabel", OB8pos, "D\nG\nR\nO", origin.name)
addOBLabel("SHIPlabel", OB9pos, "S\nH\nI\nP", origin.name)
addOBLabel("GPSlabel", OB12pos, "GPS", origin.name)
addOBLabel("WYPTlabel", OB14pos, "WYPT", origin.name)
addOBLabel("ADIlabel", OB16pos, "A\nD\nI", origin.name)
addOBLabel("HSIlabel", OB17pos, "H\nS\nI", origin.name)
-------------------------------------------------------

addText("BaroPress", {horizontalPos(-50), verticalPos(70)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}}, 	{"BARO PRESS INOP"}, origin.name, "LeftCenter") 
addText("latitude", {horizontalPos(-50), verticalPos(60)}, {"CURRENT_LATITUDE"}, {{"text_using_parameter",0,0}}, 	{"LAT \t%s"}, origin.name, "LeftCenter") 
addText("longitude", {horizontalPos(-50), verticalPos(50)}, {"CURRENT_LONGITUDE"}, {{"text_using_parameter",0,0}},	{"LONG\t%s"}, origin.name, "LeftCenter") 

addText("magnVariation", {horizontalPos(-50), verticalPos(30)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}}, {"MVAR \t  INOP"}, origin.name, "LeftCenter")
 
addText("heading", {horizontalPos(-50), verticalPos(0)}, {"CURRENT_HDG"}, {{"text_using_parameter",0,0}},		{"HDG  \t %03.0f"}, origin.name, "LeftCenter") 
addText("groundSpeed", {horizontalPos(-50), verticalPos(-10)}, {"CURRENT_GS"}, {{"text_using_parameter",0,0}},	{"GND SPD   %03.0f"}, origin.name, "LeftCenter") 

addText("WindSpdDir", {horizontalPos(-50), verticalPos(-30)}, {"WIND_DIRECTION","WIND_SPEED"}, {{"text_using_parameter",0,0},{"text_using_parameter",1,1}},  {"WIND \t %03.0f°/","%03.0f"}, origin.name, "LeftCenter") 

addText("alignment", {horizontalPos(-50), verticalPos(-50)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}},   {"ALGN  \tINOP"}, origin.name, "LeftCenter") 
addText("quality", {horizontalPos(-50), verticalPos(-60)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}}, 	{"QUAL  \tINOP"}, origin.name, "LeftCenter") 
addText("satiliteNum", {horizontalPos(-50), verticalPos(-70)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}}, {"GPS SAT 2"}, origin.name, "LeftCenter") 

--TODO: Add element data
