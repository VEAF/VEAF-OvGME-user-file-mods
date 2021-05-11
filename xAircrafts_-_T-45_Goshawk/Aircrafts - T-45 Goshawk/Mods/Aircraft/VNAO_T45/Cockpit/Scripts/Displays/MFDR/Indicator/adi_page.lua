dofile(LockOn_Options.script_path.."Displays/MFDDefs.lua")
------- TODO: spin direction indicator, smaller size numbers for altitude 100s, 
local origin	         = CreateElement "ceSimple"
origin.name 		     = "adi_origin"
origin.element_params 	 = {"MFDR_ONOFF","MFDR_PAGE"} 
origin.controllers   	 = {{"parameter_in_range",0,1},{"parameter_in_range",1,ADIPage}}
Add(origin)

---------- Option Button Labels --------
addOBLabel("HYBDlabel", OB2pos, "HYBD", "adi_origin")
addBox("HYBDBox", horizontalPos(13), verticalPos(4), "HYBDlabel", 0.0007)

addOBLabel("INSlabel", OB3pos, "INS", "adi_origin")
addOBLabel("GPSlabel", OB4pos, "GPS", "adi_origin")
--addOBLabel("REJlabel", OB10pos, "R\nE\nJ", "adi_origin")

local lawUA = addOBLabel("upArrowlabel", {horizontalPos(94),verticalPos(-34)}, "^", origin.name)
	lawUA.init_rot = {180}
	lawUA.stringdefs = selectionArrow_sdef
	lawUA.element_params = {"LAW_SELECTED"}
	lawUA.controllers = {{"parameter_in_range",0,1}}
local LAWvert = addOBLabel("LAWVertlabel", {horizontalPos(94) ,verticalPos(-54) }, "L\nA\nW", origin.name)
LAWvert.element_params = {"LAW_SELECTED"}
LAWvert.controllers = {{"parameter_in_range",0,1}}
local lawDA = addOBLabel("downArrowlabel", {horizontalPos(94),verticalPos(-74)}, "^", origin.name)
	--lawDA.init_rot = {-90}
	lawDA.stringdefs = selectionArrow_sdef
	lawDA.element_params = {"LAW_SELECTED"}
	lawDA.controllers = {{"parameter_in_range",0,1}}

local UA = addOBLabel("upArrowlabel", {horizontalPos(94),verticalPos(-34)}, "^", origin.name)
	UA.init_rot = {180}
	UA.stringdefs = selectionArrow_sdef
	UA.element_params = {"BINGO_SELECTED"}
	UA.controllers = {{"parameter_in_range",0,1}}
local BINGOvert = addOBLabel("BingoVertlabel", {horizontalPos(94) ,verticalPos(-54) }, "B\nN\nG\nO", origin.name)
BINGOvert.element_params = {"BINGO_SELECTED"}
BINGOvert.controllers = {{"parameter_in_range",0,1}}
local DA = addOBLabel("downArrowlabel", {horizontalPos(94),verticalPos(-74)}, "^", origin.name)
	--DA.init_rot = {-90}
	DA.stringdefs = selectionArrow_sdef
	DA.element_params = {"BINGO_SELECTED"}
	DA.controllers = {{"parameter_in_range",0,1}}
	
addOBLabel("LAWlabel", OB11pos, "LAW", "adi_origin")
addText("LAWnum", {horizontalPos(72) ,verticalPos(-86)}, {"LAW"}, {{"text_using_parameter",0,0}}, nil, origin.name, nil, {0.0028, 0.0028, 0, 0})
addBox("LawBox", horizontalPos(10), verticalPos(4), "LAWlabel", 0.0007, {"LAW_SELECTED"}, {{"parameter_in_range",0,1}})

addOBLabel("BNGOlabel", OB12pos, "BNGO", "adi_origin")
addText("BNGOnum", {horizontalPos(36) ,verticalPos(-86)}, {"BINGO"}, {{"text_using_parameter",0,0}}, nil, origin.name, nil, {0.0028, 0.0028, 0, 0})
addBox("BNGOBox", horizontalPos(13), verticalPos(4), "BNGOlabel", 0.0007, {"BINGO_SELECTED"}, {{"parameter_in_range",0,1}})

addOBLabel("DATAlabel", OB14pos, "DATA", "adi_origin")

local ptUA = addOBLabel("upArrowlabel", {horizontalPos(94),verticalPos(-34)}, "^", origin.name)
	ptUA.init_rot = {180}
	ptUA.stringdefs = selectionArrow_sdef
	ptUA.element_params = {"PT_SELECTED"}
	ptUA.controllers = {{"parameter_in_range",0,1}}
local PTvert = addOBLabel("PTVertlabel", {horizontalPos(94) ,verticalPos(-54) }, "P\nT", origin.name)
PTvert.element_params = {"PT_SELECTED"}
PTvert.controllers = {{"parameter_in_range",0,1}}
local ptDA = addOBLabel("downArrowlabel", {horizontalPos(94),verticalPos(-74)}, "^", origin.name)
	--ptDA.init_rot = {-90}
	ptDA.stringdefs = selectionArrow_sdef
	ptDA.element_params = {"PT_SELECTED"}
	ptDA.controllers = {{"parameter_in_range",0,1}}
addOBLabel("PTlabel", OB15pos, "PT", "adi_origin")
addText("PTnum", {horizontalPos(-72) ,verticalPos(-86)}, {"PITCH_TRIM"}, {{"text_using_parameter",0,0}}, nil, origin.name, nil, {0.0035, 0.0035, 0, 0})
addBox("PTBox", horizontalPos(10), verticalPos(4), "PTlabel", 0.0007, {"PT_SELECTED"}, {{"parameter_in_range",0,1}})

addOBLabel("HSIlabel", OB17pos, "H\nS\nI", "adi_origin")

------------ ADI ----------------------
ADILadder 			= MakeMaterial("T45ADI_PitchLadder.tga",{255,255,255,255}) 
ADIwaterline 		= MakeMaterial("T45Waterline.tga",{255,255,255,255})

num_points = 36
step = math.rad(360.0/num_points)
radius  = verticalPos(55)
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

ADIBase					= CreateElement "ceMeshPoly"
ADIBase.name			= "ADIBase"
ADIBase.vertices 		= verts
ADIBase.indices			= inds
ADIBase.init_pos		= {0, verticalPos(5.733), 0}
ADIBase.material		= MakeMaterial(nil,{205,5,5,255})
ADIBase.h_clip_relation = h_clip_relations.REWRITE_LEVEL  
ADIBase.level			= ADI_LEVEL  
ADIBase.element_params 	 = {"MFDR_ONOFF","MFDR_PAGE"} 
ADIBase.controllers   	 = {{"parameter_in_range",0,1},{"parameter_in_range",1,ADIPage}}
ADIBase.isvisible		= false
Add(ADIBase)

local adiX = verticalPos(58.66)
local adiY = verticalPos(264)
local adiLadder	   		  = CreateElement "ceTexPoly" 
adiLadder.name 			  = "adiLadder" 
adiLadder.vertices   	  = {{-adiX, adiY}, -- affects sizing (4 corners of tga file)
						  { adiX, adiY},
						  { adiX,-adiY},
						  {-adiX,-adiY}}
adiLadder.indices		  = {0,1,2,2,3,0}
adiLadder.tex_coords	  = {{0,0},{1,0},{1,1},{0,1}}
adiLadder.init_pos		  = {0, verticalPos(5.733), 0}
adiLadder.material		  = ADILadder
adiLadder.element_params  = {"CURRENT_ROLL","CURRENT_PITCH","PITCH_TRIM","MFDR_BRIGHTNESS"}  
adiLadder.controllers     = {{"rotate_using_parameter",0,1,0}, {"move_up_down_using_parameter",1, verticalPos(-120)},{"move_up_down_using_parameter",2, verticalPos(-2)},{"opacity_using_parameter",3}}	
adiLadder.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
adiLadder.level			  = ADI_LEVEL 
Add(adiLadder)

local wX = verticalPos(20)
local wY = verticalPos(20)
local waterline	   		  = CreateElement "ceTexPoly" 
waterline.name 			  = "waterline" 
waterline.vertices   	  = {{-wX, wY}, -- affects sizing (4 corners of tga file)
						  { wX, wY},
						  { wX,-wY},
						  {-wX,-wY}}
waterline.indices		  = {0,1,2,2,3,0}
waterline.tex_coords	  = {{0,0},{1,0},{1,1},{0,1}}
waterline.init_pos		  = {0, verticalPos(5.733), 0}
waterline.material		  = ADIwaterline
waterline.h_clip_relation = h_clip_relations.COMPARE
waterline.level			  = ADI_LEVEL +1
waterline.element_params  = {"MFDR_ONOFF","MFDR_PAGE"} 
waterline.controllers     = {{"parameter_in_range",0,1},{"parameter_in_range",1,ADIPage}}
Add(waterline)

local GSorigin	         = CreateElement "ceSimple"
GSorigin.name 		     = "GSorigin"
GSorigin.init_pos		 = {0, verticalPos(5.733), 0}
GSorigin.element_params  = {"ILS_GS","MFDR_ONOFF","MFDR_PAGE"} 
GSorigin.controllers   	 = {{"move_up_down_using_parameter",0, verticalPos(55)},{"parameter_in_range",1,1},{"parameter_in_range",2,ADIPage}}
Add(GSorigin)

local GSline = addLine("GSline", horizontalPos(50), {horizontalPos(-25),0}, -90, GSorigin.name)
GSline.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
GSline.level		   = ADI_LEVEL +1

local LOCorigin	         = CreateElement "ceSimple"
LOCorigin.name 		     = "LOCorigin"
LOCorigin.init_pos		 = {0, verticalPos(5.733), 0}
LOCorigin.element_params = {"ILS_LOC","MFDR_ONOFF","MFDR_PAGE"} 
LOCorigin.controllers    = {{"move_left_right_using_parameter",0, horizontalPos(55)},{"parameter_in_range",1,1},{"parameter_in_range",2,ADIPage}}
Add(LOCorigin)

local LOCline = addLine("LOCline", verticalPos(50), {0,verticalPos(-25)}, 0, LOCorigin.name)
LOCline.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
LOCline.level		    = ADI_LEVEL +1

local rollPointerOrigin	        	= CreateElement "ceSimple"
rollPointerOrigin.name 		     	= create_guid_string() 
rollPointerOrigin.element_params  	= {"CURRENT_ROLL","MFDR_ONOFF","MFDR_PAGE"} 		
rollPointerOrigin.init_pos		 = {0, verticalPos(5.733), 0}					   
rollPointerOrigin.controllers 	 	= {{"rotate_using_parameter",0,1},{"parameter_in_range",0,-1.57,1.57},{"parameter_in_range",1,1},{"parameter_in_range",2,ADIPage}}
Add(rollPointerOrigin)

local tri = addSolidTri("roll_pointer", {0,verticalPos(-54.3)}, {0}, 0.0025, 0.0045, rollPointerOrigin.name)
tri.h_clip_relation = h_clip_relations.COMPARE
tri.level		    = ADI_LEVEL +1
-------------- Heading Tape  ------------------------------------------------------------------
boxX=verticalPos(37.333) 
boxY =verticalPos(8.53)
local headingBase   = CreateElement "ceMeshPoly" 
headingBase.name 	= "headingBase"
headingBase.vertices = {{-boxX, boxY}, -- affects sizing
					{ boxX, boxY},
					{ boxX,-boxY},
					{-boxX,-boxY}}
headingBase.indices			= {0,1,2,2,3,0}
headingBase.tex_coords	 	= {{0,0},{1,0},{1,1},{0,1}}
headingBase.init_pos		= {0, verticalPos(77.33), 0}
headingBase.material		= MakeMaterial(nil,{205,5,5,200})	
headingBase.h_clip_relation = h_clip_relations.REWRITE_LEVEL  
headingBase.level			= ADI_LEVEL-1
headingBase.isvisible		= false
headingBase.element_params  = {"MFDR_ONOFF","MFDR_PAGE"}  
headingBase.controllers     = {{"parameter_in_range",0,1},{"parameter_in_range",1,ADIPage}}
Add(headingBase)

local HdgTapeorigin	         = CreateElement "ceSimple"
HdgTapeorigin.name 		     = "HdgTapeorigin"
HdgTapeorigin.parent_element = headingBase.name
HdgTapeorigin.element_params 	 = {"CURRENT_HDG"} 
HdgTapeorigin.controllers   	 = {{"move_left_right_using_parameter",0, -0.0018}}
Add(HdgTapeorigin)


local counterBegin = -3	-- need a few extra lines past 0-360 for overlap
local counterEnd   = 360 / 5 + 3
for i = counterBegin, counterEnd do
	local name
	local heading = i * 5
	name = "heading_line_"..heading
	local line = addLine(name, 0.005, {i*0.009, -0.005}, 0, HdgTapeorigin.name)
	line.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	line.level			 = ADI_LEVEL-1
	
	if heading > 355 then
		heading = heading - 360
	elseif heading < 0 then
		heading = heading + 360
	end
	if heading % 2 == 0 then -- only print text for every 10 degrees
		local text = addSimpleText(name.."_number", heading/10, {0.0035, 0.0035, 0, 0}, "CenterBottom", {0,0.005}, line.name)
		text.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
		text.level			 = ADI_LEVEL-1
	end
end
local BottomHeadingline = addLine(name, 0.702, {0, 0}, -90, "heading_line_-15")
	  BottomHeadingline.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	  BottomHeadingline.level			 = ADI_LEVEL-1
--------------- Page Background ----------------------------------------------------------------------
ADIPageText  		= MakeMaterial("T45ADI_Background.tga",{255,255,255,255}) 
local page   = CreateElement "ceTexPoly" 
page.name 		= create_guid_string() 
page.vertices   = {{-MFDHalfSize, MFDHalfSize}, -- affects sizing
					{ MFDHalfSize, MFDHalfSize},
					{ MFDHalfSize,-MFDHalfSize},
					{-MFDHalfSize,-MFDHalfSize}}
page.indices		= {0,1,2,2,3,0}
page.tex_coords	 	= {{0,0},{1,0},{1,1},{0,1}}
page.material		= ADIPageText	
page.parent_element = "adi_origin"
AddElement(page)
--------------------- IAS --------------------------------------------------------------------------
addText("IAS", {horizontalPos(-72.66), verticalPos(78.66)}, {"CURRENT_IAS"}, {{"text_using_parameter",0,0}}, {"%.0f"}, origin.name)

local IASPointerOrigin	        = CreateElement "ceSimple"
IASPointerOrigin.name 		     = create_guid_string() 
IASPointerOrigin.element_params  = {"CURRENT_IAS"} 							   
IASPointerOrigin.controllers 	 = {{"rotate_using_parameter", 0, -3.1416/50}}
IASPointerOrigin.parent_element  = "IAS"
Add(IASPointerOrigin)

local IASPointer = addLine("IAS_pointer",  verticalPos(7), {0, 0.005, 0}, {0}, IASPointerOrigin.name,nil,nil,nil,nil,nil,nil,2)

----------------- Altitude -------------------------------------------
addText("Alt1000", {horizontalPos(72.5), verticalPos(78.66)}, {"ALT_1000s"}, {{"text_using_parameter",0,0}}, {"%.0f"}, origin.name, "RightCenter", {0.0042, 0.0042, 0, 0})
addText("Alt100", {horizontalPos(72.5), verticalPos(78.25)}, {"ALT_100s"}, {{"text_using_parameter",0,0}}, {"%03.0f"}, origin.name, "LeftCenter")

local AltPointerOrigin	        = CreateElement "ceSimple"
AltPointerOrigin.name 		     = create_guid_string() 
AltPointerOrigin.element_params  = {"CURRENT_ALT"} 							   
AltPointerOrigin.controllers 	 = {{"rotate_using_parameter", 0, -3.1416/500}}
AltPointerOrigin.parent_element  = "Alt100"
Add(AltPointerOrigin)

local AltPointer = addLine("Alt_pointer",  verticalPos(7), {0, 0.005, 0}, {0}, AltPointerOrigin.name,nil,nil,nil,nil,nil,nil,2)

------------- True Air Aspeed ----------------------------------------------------
addText("TAS", {horizontalPos(-88), verticalPos(49.33)}, {"CURRENT_TAS"}, {{"text_using_parameter",0,0}}, {"T %.0f"}, origin.name, "LeftCenter")
--------------- AOA -----------------------------------------
addText("AOA", {horizontalPos(-89.33), verticalPos(41.33)}, {"CURRENT_AOA"}, {{"text_using_parameter",0,0}}, {"  %.1f"}, origin.name, "LeftCenter")
addText("alpha", {horizontalPos(-89.33), verticalPos(41.33)}, {"CURRENT_AOA"}, {{"text_using_parameter",0,0}}, {"@"}, origin.name, "LeftCenter", nil, "T45MFD_alpha")
--------------------- Mach ------------------------------------
addText("Mach", {horizontalPos(-88), verticalPos(32.66)}, {"CURRENT_MACH"}, {{"text_using_parameter",0,0}}, {"M %.2f"}, origin.name, "LeftCenter")
-------------------- G ----------------
addText("G", {horizontalPos(-81.33),verticalPos(-42.66)}, {"CURRENT_G"}, {{"text_using_parameter",0,0}}, {"G %.1f"}, origin.name, "LeftCenter")
addText("peakG", {horizontalPos(-81.33),verticalPos(-51)}, {"MAX_G"}, {{"parameter_in_range",0,3.99,15},{"text_using_parameter",0,0}}, {"  %.1f"}, origin.name, "LeftCenter")
------------------- Vertical Velocity ------------------------
addText("VV_output", {horizontalPos(98), verticalPos(5.733)}, {"CURRENT_VV"}, {{"text_using_parameter",0,0}}, {"%.0f"}, origin.name, "RightBottom",{0.003, 0.003, 0, 0})

local VVPointerOrigin	        = CreateElement "ceSimple"
VVPointerOrigin.name 		     = create_guid_string() 
VVPointerOrigin.parent_element  = origin.name
VVPointerOrigin.element_params  = {"CURRENT_VV_POINTER"} 							   
VVPointerOrigin.controllers 	 = {{"move_up_down_using_parameter", 0, 1.70604e-5}}
Add(VVPointerOrigin)

local VV_pointer = addSolidTri("VV_pointer", {horizontalPos(69.33), verticalPos(5.733)}, {-90}, 0.0056*0.577, 0.0056, VVPointerOrigin.name )

--------------------- Radar altitude ------------------
addText("Ralt", {horizontalPos(97.33), verticalPos(56)}, {"CURRENT_RALT"}, {{"parameter_in_range",0,1,5000},{"text_using_parameter",0,0}}, {"%.0f R"}, origin.name, "RightCenter")
------------- Slip Ball and spin direction indicator-------------------------------------------------------
slipBall			    = CreateElement "ceMeshPoly"
slipBall.name 		    = create_guid_string()
slipBall.init_pos 		= {0, verticalPos(-79.25)}
slipBall.material 	    = white_material 
slipBall.element_params = {"CURRENT_SLIDE"}  
slipBall.controllers    = {{"move_left_right_using_parameter",0, 0.15}}	
slipBall.parent_element  = origin.name
set_circle(slipBall, 0.003, 0, nil, 30)  -- name, outer R, inner R, arc, sides  
Add(slipBall)

ADIspinIndicator = MakeMaterial("T45spinInd.tga",{255,255,255,255}) 
local SIsize = verticalPos(8)
local spinInd   		= CreateElement "ceTexPoly" 
spinInd.name 			= create_guid_string() 
spinInd.vertices  		= {{-SIsize, SIsize}, -- affects sizing
						{ SIsize, SIsize},
						{ SIsize,-SIsize},
						{-SIsize,-SIsize}}
spinInd.indices			= {0,1,2,2,3,0}
spinInd.tex_coords	 	= {{0,0},{1,0},{1,1},{0,1}}
spinInd.material		= ADIspinIndicator	
spinInd.parent_element  = "adi_origin"
spinInd.init_pos		= {0, verticalPos(-60), 0}
spinInd.element_params  = {"LATERAL_ACC"} 
spinInd.controllers     = {{"move_left_right_using_parameter",0,0.015}}
AddElement(spinInd)
