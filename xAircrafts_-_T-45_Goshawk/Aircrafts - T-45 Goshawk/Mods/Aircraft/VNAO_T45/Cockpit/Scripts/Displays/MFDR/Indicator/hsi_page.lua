dofile(LockOn_Options.script_path.."Displays/MFDDefs.lua")

local origin	         = CreateElement "ceSimple"
origin.name 		     = "hsi_origin" 
origin.element_params 	 = {"MFDR_ONOFF","MFDR_PAGE"} 
origin.controllers   	 = {{"parameter_in_range",0,1},{"parameter_in_range",1,HSIPage}}
Add(origin)

---------- Option Button Labels ------------------------
addOBLabel("AUTOlabel", OB1pos, "AUTO", "hsi_origin")
addCrossoutHorz("AUTOX", "AUTOlabel")
addOBLabel("SEQlabel", OB2pos, "SEQ", "hsi_origin")
addCrossoutHorz("SEQX", "SEQlabel")
addOBLabel("SCLlabel", OB3pos, "SCL", "hsi_origin")
addText("Scale", {0,verticalPos(86)}, {"HSI_SCALE"}, {{"text_using_parameter",0,0}}, {"%.0f"}, origin.name)
addOBLabel("WOSlabel", OB4pos, "WO/S", "hsi_origin")
addCrossoutHorz("WOSX", "WOSlabel")

addOBLabel("WYPTlabel", OB6pos, "W\nY\nP\nT", "hsi_origin")
addBox("WYPTBox", horizontalPos(4), verticalPos(16), "WYPTlabel", 0.0007, {"WAYPOINT_SELECTED"}, {{"parameter_in_range",0,1}})

local WYPTua = addOBLabel("WYPTupArrowlabel", {horizontalPos(94),verticalPos(36)}, "^", "hsi_origin")
	WYPTua.init_rot = {180}
	WYPTua.stringdefs = selectionArrow_sdef
addText("WYPTNumlabel", {horizontalPos(94) ,verticalPos(19)}, {"ACTIVE_WAYPOINT"}, {{"text_using_parameter",0,0}}, {"%.0f"}, origin.name, nil, defualt_MFD_sdef)
local WYPTda = addOBLabel("WYPTdownArrowlabel", {horizontalPos(94),0}, "^", "hsi_origin")
	--WYPTda.init_rot = {-90}
	WYPTda.stringdefs = selectionArrow_sdef
	
local CRSua = addOBLabel("CRSupArrowlabel", {horizontalPos(94),verticalPos(-34)}, "^", "hsi_origin")
	CRSua.init_rot = {180}
	CRSua.stringdefs = selectionArrow_sdef
local CRSvert = addOBLabel("CRSVertlabel", {horizontalPos(94) ,verticalPos(-54) }, "C\nR\nS", origin.name)
CRSvert.element_params = {"CRS_SELECTED"}
CRSvert.controllers = {{"parameter_in_range",0,1}}
local HGDvert = addOBLabel("HDGVertlabel", {horizontalPos(94) ,verticalPos(-54) }, "H\nD\nG", origin.name)
HGDvert.element_params = {"HDG_SELECTED"}
HGDvert.controllers = {{"parameter_in_range",0,1}}
local CRSda = addOBLabel("CRSdownArrowlabel", {horizontalPos(94),verticalPos(-74)}, "^", "hsi_origin")
	--CRSda.init_rot = {-90}
	CRSda.stringdefs = selectionArrow_sdef
	
addOBLabel("CRSlabel", OB11pos, "CRS", "hsi_origin")
addBox("CRSBox", horizontalPos(10), verticalPos(4), "CRSlabel", 0.0007, {"CRS_SELECTED"}, {{"parameter_in_range",0,1}})
addText("CRSnum", {horizontalPos(72) ,verticalPos(-86)}, {"HSI_CRS_SET"}, {{"text_using_parameter",0,0}}, {"%03.0f"}, origin.name, nil, defualt_MFD_sdef)

addOBLabel("HDGlabel", OB12pos, "HDG", "hsi_origin")
addBox("HDGBox", horizontalPos(10), verticalPos(4), "HDGlabel", 0.0007, {"HDG_SELECTED"}, {{"parameter_in_range",0,1}})
addText("HDGnum", {horizontalPos(36) ,verticalPos(-86)}, {"HSI_HDG_SET"}, {{"text_using_parameter",0,0}}, {"%03.0f"}, origin.name, nil, defualt_MFD_sdef)

addOBLabel("DATAlabel", OB14pos, "DATA", "hsi_origin")
--addOBLabel("FWDlabel", OB15pos, "FWD", "hsi_origin") -- used for front/aft cockpit control, can't simulate
addOBLabel("ADIlabel", OB16pos, "A\nD\nI", "hsi_origin")

addOBLabel("CDIlabel", OB17pos, "C\nD\nI", "hsi_origin")
addBox("CDIBox", horizontalPos(4), verticalPos(13), "CDIlabel", 0.0007, {"CDI_SELECTED"}, {{"parameter_in_range",0,1}})

addOBLabel("PLANlabel", OB18pos, "P\nL\nA\nN", "hsi_origin")
addBox("PLANBox", horizontalPos(4), verticalPos(16), "PLANlabel", 0.0007, {"PLAN_SELECTED"}, {{"parameter_in_range",0,1}})

addText("VORbearinglabel", {horizontalPos(-77),verticalPos(39)}, {"VOR_BEARING","VOR_ILS_TYPE"}, {{"parameter_in_range",1,1},{"text_using_parameter",0,0}}, {"V%03.0f°"}, origin.name, nil,defualt_MFD_sdef)
addText("VORlabel", OB19pos, {"VOR_ILS_TYPE"}, {{"parameter_in_range",0,1},{"text_using_parameter",0,0}}, {"V\nO\nR"}, origin.name)
addBox("VORBox", horizontalPos(4), verticalPos(13), "VORlabel", 0.0007, {"VOR_SELECTED"}, {{"parameter_in_range",0,1}})

addText("ILSlabel", OB19pos, {"VOR_ILS_TYPE"}, {{"parameter_in_range",0,2},{"text_using_parameter",0,0}}, {"I\nL\nS"}, origin.name)
addBox("ILSBox", horizontalPos(4), verticalPos(13), "ILSlabel", 0.0007, {"ILS_SELECTED"}, {{"parameter_in_range",0,1}})

addOBLabel("TCNlabel", OB20pos, "T\nC\nN", "hsi_origin")
addBox("TCNBox", horizontalPos(4), verticalPos(13), "TCNlabel", 0.0007, {"TACAN_SELECTED"}, {{"parameter_in_range",0,1}})
--------------- HSI Ring --------------------------------------------
local HSIRingorigin	         = CreateElement "ceSimple"
HSIRingorigin.name 		     = "HSIRingorigin"
HSIRingorigin.parent_element = origin.name
HSIRingorigin.element_params = {"CURRENT_HDG"} 
HSIRingorigin.controllers    = {{"rotate_using_parameter",0,0.0174533}}
Add(HSIRingorigin)

for i = 0, 35 do
	local name
	local heading = i * 10
	local radius = verticalPos(65)
	xpos = radius * math.sin(math.rad(heading))
	ypos = radius * math.cos(math.rad(heading))
	if i % 3 == 0 then -- every third spot print text
		if i % 9 == 0 then
			if i==0 then i="N" elseif i==9 then i="E" elseif i==18 then i="S" elseif i==27 then i="W" end
			addSimpleText("heading_num_"..heading, i, defualt_MFD_sdef, "CenterCenter", {xpos,ypos}, HSIRingorigin.name,{{"rotate_using_parameter",0,-0.0174533}},nil,nil,{"CURRENT_HDG"})
		else
			addSimpleText("heading_num_"..heading, i, defualt_MFD_sdef, "CenterCenter", {xpos,ypos}, HSIRingorigin.name,{{"rotate_using_parameter",0,-0.0174533}},nil,nil,{"CURRENT_HDG"}) 
		end
	else -- all other spots do dots
		dot			    = CreateElement "ceMeshPoly"
		dot.name 		= "heading_dot_"..heading
		dot.init_pos 	= {xpos, ypos}
		dot.material 	= white_material 
		dot.parent_element = HSIRingorigin.name 			
		set_circle(dot, 0.0008, 0, nil, 20)  -- name, outer R, inner R, arc, sides  
		AddElement(dot)
	end
end
---------------- Static Reference lines ---------------------------------
for i = 1, 7 do
	local angle = i * 45
	local radius = verticalPos(73)
	xpos = radius * math.sin(math.rad(angle))
	ypos = radius * math.cos(math.rad(angle))
	--addLine(name, 0.003, {xpos, ypos}, -angle, origin.name)
end
local LubberLine = addLine("LubberLine", 0.006, {0, verticalPos(65)}, 0, origin.name)
LubberLine.thickness  = 1.5
------------- Airplane Symbol --------------
airplaneSymbol = MakeMaterial("T45HSI_plane.tga",white_color)
local ASsize = 0.015
local APsymbol	   		 = CreateElement "ceTexPoly" 
APsymbol.name 			 = "APsymbol" 
APsymbol.vertices   	 = {{-ASsize, ASsize}, -- affects sizing (4 corners of tga file)
						  { ASsize, ASsize},
						  { ASsize,-ASsize},
						  {-ASsize,-ASsize}}
APsymbol.indices		 = {0,1,2,2,3,0}
APsymbol.tex_coords	  	 = {{0,0},{1,0},{1,1},{0,1}}
APsymbol.init_pos		 = {0, 0, 0}
APsymbol.material		 = airplaneSymbol
APsymbol.h_clip_relation = h_clip_relations.COMPARE
APsymbol.level			 = DEFAULT_LEVEL
APsymbol.parent_element  = origin.name
Add(APsymbol) 
-------------------- Ground speed and wind -----------------------------
addText("GS", {0, verticalPos(-18)}, {"CURRENT_GS"}, {{"text_using_parameter",0,0}}, {"%.0f GS"}, origin.name)

local GTPointer	         = CreateElement "ceSimple"
GTPointer.name 		     = "GTPointer"
GTPointer.parent_element = "hsi_origin"
GTPointer.element_params = {"GROUND_TRACK"} 
GTPointer.controllers    = {{"rotate_using_parameter",0,-1}}
Add(GTPointer)
addDiamond("GroundTrackPointer", {0,verticalPos(52)}, 0.0035, 0.001, GTPointer.name )
addLine("GTPtail", 0.005, {0, verticalPos(-7)}, 0, "GroundTrackPointer")

addText("windSpdDir", {0, verticalPos(-26)}, {"WIND_DIRECTION","WIND_SPEED"}, {{"text_using_parameter",0,0},{"text_using_parameter",1,1}}, {"W %03.0f°/","%.0f"}, origin.name)
-------------------- TACAN --------------------------------------
local TCNorigin	         = CreateElement "ceSimple"
TCNorigin.name 		     = "TCNorigin"
TCNorigin.parent_element = HSIRingorigin.name
TCNorigin.element_params = {"TACAN_BEARING","TACAN_RANGE"}
TCNorigin.controllers    = {{"rotate_using_parameter",0,-(2*math.pi/360)},{"parameter_in_range",1,0.001,225}}
Add(TCNorigin)

local tacan_pointer = addTri("TCN_pointer_triangle", 0, verticalPos(73), .0058, .001, TCNorigin.name)
tacan_pointer.element_params = {"TACAN_SELECTED"}
tacan_pointer.controllers    = {{"parameter_in_range",0,1}}
addLine("TCN_pointer_inside_line", 0.0037, {0,0.001}, 0, "TCN_pointer_triangle")
local tacan_tail = addLine("TCN_pointer_tail", 0.006, {0,verticalPos(-73)*2}, 180, "TCN_pointer_triangle")
tacan_tail.thickness  = 1.25

tacanSymbol = MakeMaterial("T45tacanSymbol.tga",white_color)
local TCNsize = 0.004
local TCNsymbol	   		 = CreateElement "ceTexPoly" 
TCNsymbol.name 			 = "TCNsymbol" 
TCNsymbol.vertices   	 = {{-TCNsize, TCNsize}, -- affects sizing (4 corners of tga file)
						  { TCNsize, TCNsize},
						  { TCNsize,-TCNsize},
						  {-TCNsize,-TCNsize}}
TCNsymbol.indices		 = {0,1,2,2,3,0}
TCNsymbol.tex_coords	 = {{0,0},{1,0},{1,1},{0,1}}
TCNsymbol.init_pos		 = {0, 0, 0}
TCNsymbol.material		 = tacanSymbol
TCNsymbol.h_clip_relation = h_clip_relations.COMPARE
TCNsymbol.level			 = DEFAULT_LEVEL
TCNsymbol.parent_element = TCNorigin.name
TCNsymbol.element_params = {"TACAN_RANGE","HSI_SCALE"}
TCNsymbol.controllers    = {{"move_up_down_using_parameter",0, verticalPos(65)/10},{"parameter_in_range",1,10}}
Add(TCNsymbol) 

local TCNsym20 = Copy(TCNsymbol)
TCNsym20.element_params = {"TACAN_RANGE","HSI_SCALE"}
TCNsym20.controllers    = {{"move_up_down_using_parameter",0, verticalPos(65)/20},{"parameter_in_range",1,20}}
Add(TCNsym20)

local TCNsym40 = Copy(TCNsymbol)
TCNsym40.element_params = {"TACAN_RANGE","HSI_SCALE"}
TCNsym40.controllers    = {{"move_up_down_using_parameter",0, verticalPos(65)/40},{"parameter_in_range",1,40}}
Add(TCNsym40)

local TCNsym80 = Copy(TCNsymbol)
TCNsym80.element_params = {"TACAN_RANGE","HSI_SCALE"}
TCNsym80.controllers    = {{"move_up_down_using_parameter",0, verticalPos(65)/80},{"parameter_in_range",1,80}}
Add(TCNsym80)

local TCNsym160 = Copy(TCNsymbol)
TCNsym160.element_params = {"TACAN_RANGE","HSI_SCALE"}
TCNsym160.controllers    = {{"move_up_down_using_parameter",0, verticalPos(65)/160},{"parameter_in_range",1,160}}
Add(TCNsym160)

addText("TCN_BRG_RNG", {horizontalPos(-85),verticalPos(80)}, {"TACAN_BEARING", "TACAN_RANGE"}, {{"parameter_in_range",1,-1,999},{"text_using_parameter",0,0},{"text_using_parameter",1,1}}, {"%03.0f°/","%.1f"}, origin.name, "LeftCenter")
addText("TCN_TTG", {horizontalPos(2),verticalPos(-8)}, {"TACAN_TTG_MINS", "TACAN_TTG_SECS"}, {{"text_using_parameter",0,0},{"text_using_parameter",1,1}}, {"%.0f:","%02.0f"}, "TCN_BRG_RNG", "LeftCenter")
------------------------------ Waypoints --------------------------------------------------------------------------------------------------------
for i=1,11 do
	local WYPTorigin	      = CreateElement "ceSimple"
	WYPTorigin.name 		  = "WYPT"..i.."origin"
	WYPTorigin.parent_element = HSIRingorigin.name
	WYPTorigin.element_params = {"WAYPOINT"..i.."BEARING","ACTIVE_WAYPOINT"}
	WYPTorigin.controllers    = {{"rotate_using_parameter",0,-(2*math.pi/360)},{"parameter_in_range",0,-1,361},{"parameter_in_range",1,i-1}}
	Add(WYPTorigin)
	
	local WYPTpointer = addTri("WYPT_"..i.."_bearing_pointer", 0, verticalPos(61), .004, .0008, "WYPT"..i.."origin")
	WYPTpointer.init_rot = {180}
	WYPTpointer.element_params = {"WAYPOINT_SELECTED"}
	WYPTpointer.controllers = {{"parameter_in_range",0,1}}
	local WYPTpointerTail = addLine("WYPT_"..i.."_bearing_pointer_tail", 0.006, {0,verticalPos(-61)}, 0, "WYPT"..i.."origin")
	WYPTpointerTail.thickness  = 1.25
	WYPTpointerTail.element_params = {"WAYPOINT_SELECTED"}
	WYPTpointerTail.controllers = {{"parameter_in_range",0,1}}
	
----- 10 nm scale -----------
	wyptShape10			= CreateElement "ceMeshPoly"
	wyptShape10.name 		= "wyptShape10_"..i
	wyptShape10.material 	= white_material 
	wyptShape10.parent_element = "WYPT"..i.."origin" 			
	set_circle(wyptShape10, 0.0016, 0.0014, nil, 20)  -- name, outer R, inner R, arc, sides  
	wyptShape10.element_params = {"WAYPOINT"..i.."RANGE","HSI_SCALE","CURRENT_HDG","WAYPOINT"..i.."BEARING"}
	wyptShape10.controllers    = {{"move_up_down_using_parameter",0, verticalPos(65)/10},{"parameter_in_range",1,10},{"rotate_using_parameter",2,-0.0174533},{"rotate_using_parameter",3,0.0174533}}
	AddElement(wyptShape10)
	
	wyptDot10			= CreateElement "ceMeshPoly"
	wyptDot10.name 		= "wyptDot10_"..i
	wyptDot10.material 	= white_material 
	wyptDot10.parent_element = "wyptShape10_"..i 			
	set_circle(wyptDot10, 0.0003, 0, nil, 10)  -- name, outer R, inner R, arc, sides  
	AddElement(wyptDot10)
	
	addSimpleText("WYPT_local10_num", i-1, {0.003, 0.003, 0, 0}, "LeftTop", {horizontalPos(3),verticalPos(-3)}, "wyptShape10_"..i)
----- 20 nm scale -----------	
	local wpytShp20 = Copy(wyptShape10)
	wpytShp20.name 		= "wpytShp20_"..i
	wpytShp20.element_params = {"WAYPOINT"..i.."RANGE","HSI_SCALE","CURRENT_HDG","WAYPOINT"..i.."BEARING"}
	wpytShp20.controllers    = {{"move_up_down_using_parameter",0, verticalPos(65)/20},{"parameter_in_range",1,20},{"rotate_using_parameter",2,-0.0174533},{"rotate_using_parameter",3,0.0174533}}
	AddElement(wpytShp20)
	
	local wpytDot20 = Copy(wyptDot10)
	wpytDot20.name 		= "wyptDot20_"..i
	wpytDot20.parent_element = "wpytShp20_"..i 
	Add(wpytDot20)
	
	addSimpleText("WYPT_local20_num", i-1, {0.003, 0.003, 0, 0}, "LeftTop", {horizontalPos(3),verticalPos(-3)}, "wpytShp20_"..i)
----- 40 nm scale -----------
	local wpytShp40 = Copy(wyptShape10)
	wpytShp40.name 		= "wpytShp40_"..i
	wpytShp40.element_params = {"WAYPOINT"..i.."RANGE","HSI_SCALE","CURRENT_HDG","WAYPOINT"..i.."BEARING"}
	wpytShp40.controllers    = {{"move_up_down_using_parameter",0, verticalPos(65)/40},{"parameter_in_range",1,40},{"rotate_using_parameter",2,-0.0174533},{"rotate_using_parameter",3,0.0174533}}
	AddElement(wpytShp40)
	
	local wpytDot40 = Copy(wyptDot10)
	wpytDot40.name 		= "wyptDot40_"..i
	wpytDot40.parent_element = "wpytShp40_"..i 
	Add(wpytDot40)
	
	addSimpleText("WYPT_local40_num", i-1, {0.003, 0.003, 0, 0}, "LeftTop", {horizontalPos(3),verticalPos(-3)}, "wpytShp40_"..i)
----- 80 nm scale -----------	
	local wpytShp80 = Copy(wyptShape10)
	wpytShp80.name 		= "wpytShp80_"..i
	wpytShp80.element_params = {"WAYPOINT"..i.."RANGE","HSI_SCALE","CURRENT_HDG","WAYPOINT"..i.."BEARING"}
	wpytShp80.controllers    = {{"move_up_down_using_parameter",0, verticalPos(65)/80},{"parameter_in_range",1,80},{"rotate_using_parameter",2,-0.0174533},{"rotate_using_parameter",3,0.0174533}}
	AddElement(wpytShp80)
	
	local wpytDot80 = Copy(wyptDot10)
	wpytDot80.name 		= "wyptDot80_"..i
	wpytDot80.parent_element = "wpytShp80_"..i 
	Add(wpytDot80)
	
	addSimpleText("WYPT_local80_num", i-1, {0.003, 0.003, 0, 0}, "LeftTop", {horizontalPos(3),verticalPos(-3)}, "wpytShp80_"..i)
----- 160 nm scale -----------	
	local wpytShp160 = Copy(wyptShape10)
	wpytShp160.name 		= "wpytShp160_"..i
	wpytShp160.element_params = {"WAYPOINT"..i.."RANGE","HSI_SCALE","CURRENT_HDG","WAYPOINT"..i.."BEARING"}
	wpytShp160.controllers    = {{"move_up_down_using_parameter",0, verticalPos(65)/160},{"parameter_in_range",1,160},{"rotate_using_parameter",2,-0.0174533},{"rotate_using_parameter",3,0.0174533}}
	AddElement(wpytShp160)
	
	local wpytDot160 = Copy(wyptDot10)
	wpytDot160.name 		= "wyptDot160_"..i
	wpytDot160.parent_element = "wpytShp160_"..i 
	Add(wpytDot160)
	
	addSimpleText("WYPT_local160_num", i-1, {0.003, 0.003, 0, 0}, "LeftTop", {horizontalPos(3),verticalPos(-3)}, "wpytShp160_"..i)
------- range bearing info	---------
	addText("WYPT_BRG_RNG", {horizontalPos(85),verticalPos(80)}, {"WAYPOINT"..i.."BEARING", "WAYPOINT"..i.."RANGE","ACTIVE_WAYPOINT"}, {{"parameter_in_range",2,i-1},{"parameter_in_range",0,-1,361},{"text_using_parameter",0,0},{"text_using_parameter",1,1}}, {"%03.0f°/","%.1f"}, origin.name, "RightCenter")
end
addText("WYPT_TTG", {horizontalPos(83),verticalPos(72)}, {"WYPT_TTG_MINS", "WYPT_TTG_SECS"}, {{"parameter_in_range",1,0,999},{"text_using_parameter",0,0},{"text_using_parameter",1,1}}, {"%.0f:","%02.0f"}, origin.name, "RightCenter")
--------------------------- VOR -----------------------------------------------
local VORorigin	         = CreateElement "ceSimple"
VORorigin.name 		     = "VORorigin"
VORorigin.parent_element = HSIRingorigin.name
VORorigin.element_params = {"VOR_BEARING","VOR_SELECTED"}
VORorigin.controllers    = {{"rotate_using_parameter",0,-(2*math.pi/360)},{"parameter_in_range",1,1}}
Add(VORorigin)

local VORpointer = addTri("VOR_bearing_pointer", 0, verticalPos(61), .006, .0008, "VORorigin")
VORpointer.init_rot = {180}

local VORpointerTail = addBox("VOR_bearing_pointer_tail", 0.0008, 0.002, "VORorigin", 0.00035)
VORpointerTail.init_pos = {0,verticalPos(-57)}
--------------------------- Heading Marker --------------------------------------------------------------------------------------------
local HDGorigin	         = CreateElement "ceSimple"
HDGorigin.name 		     = "HDGorigin"
HDGorigin.parent_element = HSIRingorigin.name
HDGorigin.element_params = {"HSI_HDG_SET"}
HDGorigin.controllers    = {{"rotate_using_parameter",0,-(2*math.pi/360)}}
Add(HDGorigin)

local LHDGbox = addLine("HDGLBox",  verticalPos(3), {horizontalPos(-2), verticalPos(70)}, {0}, "HDGorigin",nil,nil,nil,nil,nil,nil,3)
local RHDGbox = addLine("HDGRBox",  verticalPos(3), {horizontalPos(2), verticalPos(70)}, {0}, "HDGorigin",nil,nil,nil,nil,nil,nil,3)

--------------------- CDI ---------------------------------------------------------------------
local CDIorigin	         = CreateElement "ceSimple"
CDIorigin.name 		     = "CDIorigin"
CDIorigin.parent_element = HSIRingorigin.name
CDIorigin.element_params = {"HSI_CRS_SET","CRS_SELECTED","CDI_SELECTED"}
CDIorigin.controllers    = {{"rotate_using_parameter",0,-(2*math.pi/360)},{"parameter_in_range",1,1},{"parameter_in_range",2,1}}
Add(CDIorigin)

local CDI_lineBot = addLine("CDI_lineBot", verticalPos(35), {0,verticalPos(-60)}, 0, "CDIorigin")
CDI_lineBot.thickness  = 1
local CDI_lineTop = addLine("CDI_lineTop", verticalPos(35), {0,verticalPos(25.5)}, 0, "CDIorigin")
CDI_lineTop.thickness  = 1
addSolidTri("CDI_pointer_triangle", {0, verticalPos(62)}, {180}, .003, .007, "CDIorigin")

local CDI_deviation_line = addLine("CDI_deviation_line", verticalPos(50), {0,verticalPos(-25)}, 0, "CDIorigin", {{"move_left_right_using_parameter",0,verticalPos(42)}})
CDI_deviation_line.thickness  = 1
CDI_deviation_line.element_params = {"CDI_DEVIATION"}

for i= -2,2 do
	deviationDot			= CreateElement "ceMeshPoly"
	deviationDot.name 		= "deviationDot"
	deviationDot.material 	= white_material 
	deviationDot.init_pos	= {horizontalPos(21*i),0}
	deviationDot.parent_element = "CDIorigin"
	deviationDot.element_params = {"CDI_DOT_DRAW"}
	deviationDot.controllers = {{"parameter_in_range",0,1}}
	set_circle(deviationDot, 0.0007, 0.000, nil, 20)  -- name, outer R, inner R, arc, sides  
	AddElement(deviationDot)
end
--------------------- planmetric (PLAN)------------------------------------------------------------------------------------------
num_points = 24
step = math.rad(360.0/num_points)
radius  = verticalPos(65)
verts = {}
for i = 1, num_points do
	verts[i] = {radius * math.cos(i * step), radius * math.sin(i * step)}
end
inds = {}
j = 0
for i = 0, num_points-3 do
	j = j + 1
	inds[j] = 0
	j = j + 1
	inds[j] = i + 1
	j = j + 1
	inds[j] = i + 2
end

planMask				= CreateElement "ceMeshPoly"
planMask.name			= "planMask"
planMask.vertices 		= verts
planMask.indices		= inds
planMask.material		= MakeMaterial(nil,{205,5,5,128})
planMask.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL  
planMask.level			= DEFAULT_LEVEL
planMask.element_params  = {"MFDR_ONOFF","MFDR_PAGE","CURRENT_HDG","PLAN_DRAW"} 
planMask.controllers   	 = {{"parameter_in_range",0,1},{"parameter_in_range",1,HSIPage},{"rotate_using_parameter",2,0.0174533},{"parameter_in_range",3,1}}
planMask.isvisible		= false
Add(planMask)

local PLANorigin	      = CreateElement "ceSimple"
PLANorigin.name 		  = "PLANorigin"
PLANorigin.parent_element = planMask.name	
PLANorigin.element_params = {"PLAN_ORIGIN_LR","PLAN_ORIGIN_UD","HSI_CRS_SET","CRS_SELECTED","PLAN_SELECTED"}
PLANorigin.controllers    = {{"move_left_right_using_parameter",0,verticalPos(65)},{"move_up_down_using_parameter",1, verticalPos(65)},{"rotate_using_parameter",2,-(2*math.pi/360)},{"parameter_in_range",3,1},{"parameter_in_range",4,1}}
Add(PLANorigin)

local PLAN_line = addLine("PLAN_line", verticalPos(260), {0,verticalPos(-130)}, 0, "PLANorigin")
PLAN_line.level 	= DEFAULT_LEVEL + 1

local planTri = addSolidTri("PLAN_pointer_triangle", {0, verticalPos(40)}, {180}, .003, .007, "PLANorigin")
planTri.level 	= DEFAULT_LEVEL + 1