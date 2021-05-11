dofile(LockOn_Options.script_path.."Displays/MFDDefs.lua")

local origin	         = CreateElement "ceSimple"
origin.name 		     = "engine_origin"
origin.element_params 	 = {"MFDL_ONOFF","MFDL_PAGE"} 
origin.controllers   	 = {{"parameter_in_range",0,1},{"parameter_in_range",1,ENGPage}}
Add(origin)

-------- Option Button Labels ---------
addOBLabel("HSIlabel", OB17pos, "H\nS\nI", origin.name)
addOBLabel("ADIlabel", OB16pos, "A\nD\nI", origin.name)

addText("N2rpm", {horizontalPos(-60), verticalPos(66)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}}, {"N2 RPM %%  \t  %.0f"}, origin.name, "LeftCenter") -- 0-115%
addText("FuelFlow", {horizontalPos(-60), verticalPos(54)}, {"CURRENT_FF"}, {{"text_using_parameter",0,0}}, {"FF    \t \t %.0f"}, origin.name, "LeftCenter") -- 0-7000pph
addText("FuelQTY", {horizontalPos(-60), verticalPos(42)}, {"CURRENT_FUELT"}, {{"text_using_parameter",0,0}}, {"FQTY \t \t %.0f"}, origin.name, "LeftCenter") -- 0-3306lb

addText("N1rpm", {horizontalPos(-60), verticalPos(18)}, {"N1_RPM"}, {{"text_using_parameter",0,0}}, {"N1 RPM %%  \t %.0f"}, origin.name, "LeftCenter") -- 0-120%
addText("TotalAirTemp", {horizontalPos(-60), verticalPos(6)}, {"TOTAL_AIR_TEMP"}, {{"text_using_parameter",0,0}}, {"TAT C \t\t %.0f"}, origin.name, "LeftCenter") -- -60-99C
addText("EnginePressRatio", {horizontalPos(-60), verticalPos(-6)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}}, {"EPR   \t\t INOP"}, origin.name, "LeftCenter") -- EPR=exhaust press/atmo press
addText("TurbineEgt", {horizontalPos(-60), verticalPos(-18)}, {"EGT"}, {{"text_using_parameter",0,0}}, {"T6 C  \t\t %.0f"}, origin.name, "LeftCenter") -- 0-1000C

---- only when weight on wheels
addText("HPC", {horizontalPos(-60), verticalPos(-40)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}}, {"HPC PRESS \t INOP"}, origin.name, "LeftCenter") -- compressor discharge press (P3) 0-250psi
addText("ThrottlePosDeg", {horizontalPos(-60), verticalPos(-52)}, {"CURRENT_RPM"}, {{"text_using_parameter",0,0}}, {"PLA   \t\t INOP"}, origin.name, "LeftCenter") -- 0-48 deg
