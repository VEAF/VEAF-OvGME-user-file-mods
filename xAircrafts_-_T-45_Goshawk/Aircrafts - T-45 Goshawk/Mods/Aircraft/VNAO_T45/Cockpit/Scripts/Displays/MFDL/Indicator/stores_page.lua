dofile(LockOn_Options.script_path.."Displays/MFDDefs.lua")
dofile(LockOn_Options.script_path.."Displays/MFDPages.lua")
-- TODO: 
local origin	         = CreateElement "ceSimple"
origin.name 		     = create_guid_string() 
origin.element_params 	 = {"MFDL_ONOFF","MFDL_PAGE"} 
origin.controllers   	 = {{"parameter_in_range",0,1},{"parameter_in_range",1,STRSPage}}
Add(origin)

StoresPage = MakeMaterial("T45Stores_Background.tga",white_color)
local page   	= CreateElement "ceTexPoly" 
page.name 		= create_guid_string() 
page.vertices   = {{-MFDHalfSize, MFDHalfSize}, -- affects sizing
					{ MFDHalfSize, MFDHalfSize},
					{ MFDHalfSize,-MFDHalfSize},
					{-MFDHalfSize,-MFDHalfSize}}
page.indices		= {0,1,2,2,3,0}
page.tex_coords	 	= {{0,0},{1,0},{1,1},{0,1}}
page.material		= StoresPage	
page.parent_element = origin.name
Add(page)
--------------------- Common --------------------------------------------
addOBLabel("ADIlabel", OB16pos, "A\nD\nI", origin.name)
addOBLabel("HSIlabel", OB17pos, "H\nS\nI", origin.name)
addOBLabel("AGlabel", OB18pos, "A\n/\nG", origin.name)
addBox("AGBox", horizontalPos(5), verticalPos(14), "AGlabel", 0.0007, {"MASTER_MODE"}, {{"parameter_in_range",0,1}})
addOBLabel("AAlabel", OB19pos, "A\n/\nA", origin.name)
addBox("AABox", horizontalPos(5), verticalPos(14), "AAlabel", 0.0007, {"MASTER_MODE"}, {{"parameter_in_range",0,2}})
addOBLabel("NAVlabel", OB20pos, "N\nA\nV", origin.name)
addBox("navBox", horizontalPos(5), verticalPos(14), "NAVlabel", 0.0007, {"MASTER_MODE"}, {{"parameter_in_range",0,0}})

addText("armIndicator", {0, 0}, {"ARMIND"}, {{"parameter_in_range",0,1},{"text_using_parameter",0,0}}, {"ARM"}, origin.name, nil, {0.0055, 0.0055, 0, 0}) 
addText("safeIndicator", {0, 0}, {"ARMIND"}, {{"parameter_in_range",0,0},{"text_using_parameter",0,0}}, {"SAFE"}, origin.name, nil, {0.0055, 0.0055, 0, 0}) 
addText("storeLinfo", {horizontalPos(-50),verticalPos(-5)}, {"STOREL"}, {{"text_using_parameter",0,0}}, {"%s"}, origin.name, "CenterTop", {0.0042, 0.0042, 0, 0})
addText("storeRinfo", {horizontalPos(50),verticalPos(-5)}, {"STORER"}, {{"text_using_parameter",0,0}}, {"%s"}, origin.name, "CenterTop", {0.0042, 0.0042, 0, 0})

----------------- Gun ---------------------------
local gunLabel = addOBLabel("GUNlabel", OB3pos, "GUN", origin.name)
gunLabel.element_params  = {"MASTER_MODE"} 
gunLabel.controllers   	 = {{"parameter_in_range",0,0.9,2.1}}
addBox("gunBox", horizontalPos(14), verticalPos(5), "GUNlabel", 0.0007, {"GUN_SELECT"}, {{"parameter_in_range",0,1}})
addText("gunText", {0,verticalPos(24)}, {"GUN_SELECT"}, {{"parameter_in_range",0,1},{"text_using_parameter",0,0}}, {"GUN"}, origin.name, nil, {0.0055, 0.0055, 0, 0})
------------------------- A/G specific  ------------------------------------------------
local AGorigin	         = CreateElement "ceSimple"
AGorigin.name 		     = create_guid_string() 
AGorigin.parent_element  = origin.name
AGorigin.element_params  = {"MASTER_MODE"} 
AGorigin.controllers   	 = {{"parameter_in_range",0,1}}
Add(AGorigin)

addOBLabel("LRKTlabel", OB1pos, "RKT", AGorigin.name)
addBox("LRKTBox", horizontalPos(14), verticalPos(5), "LRKTlabel", 0.0007, {"STATION_SELECTED"}, {{"parameter_in_range",0,1}})
addOBLabel("LBOMBlabel", OB2pos, "BOMB", AGorigin.name)
addBox("LBOMBBox", horizontalPos(14), verticalPos(5), "LBOMBlabel", 0.0007, {"STATION_SELECTED"}, {{"parameter_in_range",0,2}})
addOBLabel("RBOMBlabel", OB4pos, "BOMB", AGorigin.name)
addBox("RBOMBBox", horizontalPos(14), verticalPos(5), "RBOMBlabel", 0.0007, {"STATION_SELECTED"}, {{"parameter_in_range",0,3}})
addOBLabel("RRKTlabel", OB5pos, "RKT", AGorigin.name)
addBox("RRKTBox", horizontalPos(14), verticalPos(5), "RRKTlabel", 0.0007, {"STATION_SELECTED"}, {{"parameter_in_range",0,4}})
local QTYua = addOBLabel("WYPTupArrowlabel", {horizontalPos(94),verticalPos(72)}, "^", AGorigin.name)
	QTYua.init_rot = {180}
	QTYua.stringdefs = selectionArrow_sdef
addOBLabel("QTYlabel", {horizontalPos(94) ,verticalPos(54) }, "Q\nT\nY", AGorigin.name) -- TODO: this needs to be dynamic 
local QTYda = addOBLabel("WYPTdownArrowlabel", {horizontalPos(94),verticalPos(36)}, "^", AGorigin.name)
	QTYda.stringdefs = selectionArrow_sdef
addOBLabel("MANlabel", OB8pos, "M\nA\nN", AGorigin.name)
addBox("MANBox", horizontalPos(5), verticalPos(14), "MANlabel", 0.0007, {"CCIP_MODE"}, {{"parameter_in_range",0,0}})
addOBLabel("CCIPlabel", OB9pos, "C\nC\nI\nP", AGorigin.name)
addBox("CCIPBox", horizontalPos(5), verticalPos(16), "CCIPlabel", 0.0007, {"CCIP_MODE"}, {{"parameter_in_range",0,1}})
local TGHT = addOBLabel("TGHTlabel", OB10pos, "T\nG\nH\nT", AGorigin.name)
TGHT.element_params = {"CCIP_MODE"}
TGHT.controllers		= {{"parameter_in_range",0,1}}
addOBLabel("RPPLlabel", OB11pos, "RPPL", AGorigin.name)
addBox("RPPLBox", horizontalPos(14), verticalPos(5), "RPPLlabel", 0.0007, {"RIPPLE_MODE"}, {{"parameter_in_range",0,1}})

local ripple_single = addText("RippleMode", {horizontalPos(-65),verticalPos(-50)}, {"RIPPLE_MODE"}, {{"parameter_in_range",0,0}}, nil, AGorigin.name, "LeftCenter")
ripple_single.value = "ROCKETS \t\tSINGLE"
local ripple_ripple = addText("RippleMode", {horizontalPos(-65),verticalPos(-50)}, {"RIPPLE_MODE"}, {{"parameter_in_range",0,1}}, nil, AGorigin.name, "LeftCenter")
ripple_ripple.value = "ROCKETS \t\tRIPPLE"

addText("TrgtHght", {horizontalPos(-65),verticalPos(-37)}, {"CCIP_MODE","TargetHeight"}, {{"parameter_in_range",0,1},{"text_using_parameter",1,0}}, {"TARGET HEIGHT \t INOP"}, AGorigin.name, "LeftCenter")
addText("MilDep", {horizontalPos(-65),verticalPos(-37)}, {"CCIP_MODE","MIL_DEPRESSION"}, {{"parameter_in_range",0,0},{"text_using_parameter",1,0}}, {"MIL DEP \t\t %.0f"}, AGorigin.name, "LeftCenter")

------------------------- A/A specific  -----------------------------------------------------
local AAorigin	         = CreateElement "ceSimple"
AAorigin.name 		     = create_guid_string() 
AAorigin.parent_element  = origin.name
AAorigin.element_params  = {"MASTER_MODE"} 
AAorigin.controllers   	 = {{"parameter_in_range",0,2}}
Add(AAorigin)

addOBLabel("LAClabel", OB8pos, "L\nA\nC", AAorigin.name)
addOBLabel("RTGSlabel", OB9pos, "R\nT\nG\nS", AAorigin.name)
addOBLabel("WSPNlabel", OB10pos, "W\nS\nP\nN", AAorigin.name)

addText("wingspan", {horizontalPos(-65),verticalPos(-37)}, {"CCIP_MODE","MIL_DEP"}, {{"parameter_in_range",0,0},{"text_using_parameter",1,0}}, {"WINGSPAWN \t 31"}, AAorigin.name, "LeftCenter")
---------------------------------------------------------------------------------

