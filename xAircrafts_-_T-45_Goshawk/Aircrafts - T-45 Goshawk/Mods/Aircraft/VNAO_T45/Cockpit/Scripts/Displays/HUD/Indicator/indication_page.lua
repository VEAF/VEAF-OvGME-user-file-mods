dofile(LockOn_Options.script_path.."Displays/HUD/Indicator/definitions.lua")

-- these are so the elements can be shared between HUD and MFD HUD repeater
HUD_Color ={2,255,20,255}--{0,150,0,225}
HUD_material = MakeMaterial(nil,HUD_Color)
HUD_font = "font_T45HUD"
HUD_sdef_regularLarge = {0.0065,0.0065, 0, 0}
HUD_sdef_regular = {0.006,0.006, 0, 0}



local origin	        = CreateElement "ceSimple"
origin.name 		    = create_guid_string() 
origin.element_params  	= {"GEN_BUS","HUD_PWR"} 							   
origin.controllers 	 	= {{"parameter_in_range",0,25,29},{"parameter_in_range",1,1}}	-- will turn off elements that are tied to this origin when the generator bus is off
AddElement(origin, true) -- the origin must be collimated!!

-------------- Left Side ------------------------------------------------
addText("IAS", IASPos, {"CURRENT_IAS","HUD_BRT"}, {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}, {"%.0f"} , origin.name, "CenterTop", HUD_sdef_regularLarge, HUD_font)
local IASbox = addBox("IASBox",15,7,"IAS",3,{"HUD_BRT"},{{"opacity_using_parameter",0}}, {0}, HUD_material, true)
IASbox.init_pos={0,-3.75}

addText("GroundSpeed", GSPos, {"CURRENT_GS","HUD_BRT","approach","DECLUTTER_LEVEL"}, {{"parameter_in_range",3,0},{"parameter_in_range",2,0},{"text_using_parameter",0,0},{"opacity_using_parameter",1}}, {"GS %.0f"}, origin.name, "LeftCenter", HUD_sdef_regular, HUD_font)
addText("AOA", AOAPos, {"CURRENT_AOA","HUD_BRT","DECLUTTER_LEVEL"}, {{"parameter_in_range",2,0},{"text_using_parameter",0,0,1},{"opacity_using_parameter",1}}, {"  %.1f"} , origin.name, "LeftCenter", HUD_sdef_regular, HUD_font)

addText("alpha", AOAPos, {"CURRENT_AOA","HUD_BRT","DECLUTTER_LEVEL"}, {{"parameter_in_range",2,0},{"text_using_parameter",0,0,1},{"opacity_using_parameter",1}}, {"@"}, origin.name, "LeftCenter", HUD_sdef_regular, "T45MFD_alphaHUD")

addText("mach", MachPos, {"CURRENT_MACH","HUD_BRT","approach","DECLUTTER_LEVEL"}, {{"parameter_in_range",3,0},{"parameter_in_range",2,0},{"text_using_parameter",0,0},{"opacity_using_parameter",1}} , {"M %.2f","%s"} , origin.name, "LeftCenter", HUD_sdef_regular, HUD_font)
addText("G", GPos, {"CURRENT_G","HUD_BRT","approach","DECLUTTER_LEVEL"}, {{"parameter_in_range",3,0},{"parameter_in_range",2,0},{"text_using_parameter",0,0},{"opacity_using_parameter",1}} , {"G %.1f"} , origin.name, "LeftCenter", HUD_sdef_regular, HUD_font)
addText("peakG", peakGPos, {"MAX_G","HUD_BRT","approach","DECLUTTER_LEVEL"}, {{"parameter_in_range",0,3.99,15},{"parameter_in_range",3,0},{"parameter_in_range",2,0},{"text_using_parameter",0,0},{"opacity_using_parameter",1}} , {"  %.1f"} , origin.name, "LeftCenter",HUD_sdef_regular, HUD_font)

addText("time", timePos, {"timeHour","timeMins","timeSec","HUD_BRT","approach","DECLUTTER_LEVEL"}, {{"parameter_in_range",5,0},{"parameter_in_range",4,0},{"text_using_parameter",0,0},{"text_using_parameter",1,0},{"text_using_parameter",2,1},{"opacity_using_parameter",3}}, {"%02.0f:","%02.0f"}, origin.name,nil,HUD_sdef_regular,HUD_font)
--------------- Right Side ---------------------------------------
addText("verticalVelocity", VVPos, {"CURRENT_VV","HUD_BRT"}, {{"text_using_parameter",0,0},{"opacity_using_parameter",1}} , nil, origin.name,nil,HUD_sdef_regular,HUD_font)

addText("altitude1000", ALTPos, {"ALT_1000s","HUD_BRT"}, {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}, nil , origin.name, "RightTop", HUD_sdef_regularLarge,HUD_font)
addText("altitude100", {77,-0.75}, {"ALT_100s","HUD_BRT"}, {{"text_using_parameter",0,0},{"opacity_using_parameter",1}} , {"%03.0f"}, origin.name, "LeftTop",HUD_sdef_regular,HUD_font)
local altBox = addBox("altBox",19,7,"altitude1000",3,{"HUD_BRT"},{{"opacity_using_parameter",0}},{0}, HUD_material, true)
altBox.init_pos={2.5,-4}

addText("RadarAlt", RALTPos, {"CURRENT_RALT","HUD_BRT"}, {{"parameter_in_range",0,1,5000},{"text_using_parameter",0,0},{"opacity_using_parameter",1}}, {"%.0f R"}, origin.name,nil,HUD_sdef_regular,HUD_font)

addText("tacanRange", {80,-60}, {"TACAN_RANGE","HUD_BRT","TACAN_SELECTED"}, {{"parameter_in_range",0,-1,999},{"parameter_in_range",2,1},{"text_using_parameter",0,0},{"opacity_using_parameter",1}}, {"%.1F TCN"}, origin.name,nil,HUD_sdef_regular,HUD_font)
addText("waypointRange", {80,-60}, {"SELECTED_WAYPOINT_RANGE","HUD_BRT","WAYPOINT_SELECTED","ACTIVE_WAYPOINT"}, {{"parameter_in_range",0,-1,999},{"parameter_in_range",2,1},{"text_using_parameter",0,0},{"text_using_parameter",3,1},{"opacity_using_parameter",1}}, {"%.1F W","%02.0f"}, origin.name,nil,HUD_sdef_regular,HUD_font)
------------------------------------------------------------------
------------------- Velocity Vector -------------------------------------
local velVecOrigin	        = CreateElement "ceSimple"
velVecOrigin.name 		     = create_guid_string() 
velVecOrigin.element_params  = {"VELVEC_V","VELVEC_H","VV_FLASH"} 							   
velVecOrigin.controllers 	 = {{"move_up_down_using_parameter",0,1}, {"move_left_right_using_parameter",1,1},{"parameter_in_range",2,1}}
velVecOrigin.parent_element  = origin.name
AddElement(velVecOrigin,true)

local VelVecCircle		= CreateElement "ceSMultiLine"
VelVecCircle.name 		= "VelVecCircle"
VelVecCircle.material 	= HUD_material 
VelVecCircle.parent_element = velVecOrigin.name 			
set_circle(VelVecCircle, 5, 4, nil, 20)  -- name, outer R, inner R, arc, sides   
VelVecCircle.element_params  = {"HUD_BRT"}
VelVecCircle.controllers     = {{"opacity_using_parameter",0}} 
AddElement(VelVecCircle,true)

local VVLU =addLine("VVLineUp", 7, {0, 5}, 0, "VelVecCircle",nil,nil,nil,nil,HUD_material, true, 2.5)
VVLU.element_params  = {"HUD_BRT"}
VVLU.controllers     = {{"opacity_using_parameter",0}} 
local VVLL =addLine("VVLineLeft", 8, {-5, 0}, 90, "VelVecCircle",nil,nil,nil,nil,HUD_material, true, 2.5)
VVLL.element_params  = {"HUD_BRT"}
VVLL.controllers     = {{"opacity_using_parameter",0}} 
local VVLR =addLine("VVLineRight", 8, {5, 0}, -90, "VelVecCircle",nil,nil,nil,nil,HUD_material, true, 2.5)
VVLR.element_params  = {"HUD_BRT"}
VVLR.controllers     = {{"opacity_using_parameter",0}} 

local ESym=18
local AoaE           = CreateElement "ceTexPoly"	-- on speed bracket
AoaE.name            = create_guid_string()
AoaE.material        = MakeMaterial("T45EBracket.tga",HUD_Color)
AoaE.vertices   		= {{-ESym, ESym}, -- affects sizing (4 corners of tga file)
						{ ESym, ESym},
						{ ESym,-ESym},
						{-ESym,-ESym}}
AoaE.indices			= {0,1,2,2,3,0}
AoaE.tex_coords	 	= {{0,0},{1,0},{1,1},{0,1}}
AoaE.init_pos        = EPos
AoaE.alignment       = "CenterCenter"
AoaE.element_params  = {"E_POS","approach","HUD_BRT"}
AoaE.controllers     = {{"move_up_down_using_parameter",0,0.018}, {"parameter_in_range",1,1}, {"opacity_using_parameter",2}} 
AoaE.parent_element  = velVecOrigin.name
AddElement(AoaE,true)

local GhostvelVecOrigin	        = CreateElement "ceSimple"
GhostvelVecOrigin.name 		     = create_guid_string() 
GhostvelVecOrigin.element_params  = {"VELVECGhost_V","VELVECGhost_H","VELVECCage"} 							   
GhostvelVecOrigin.controllers 	 = {{"move_up_down_using_parameter",0,1}, {"move_left_right_using_parameter",1,1},{"parameter_in_range",2,1}}
GhostvelVecOrigin.parent_element  = origin.name
AddElement(GhostvelVecOrigin,true)

local VVLU =addLine("VVLineUp", 7, {0, 5}, 0, GhostvelVecOrigin.name,nil,nil,nil,nil,HUD_material, true, 2.5 )
VVLU.element_params  = {"HUD_BRT"}
VVLU.controllers     = {{"opacity_using_parameter",0}} 
local VVLL =addLine("VVLineLeft", 8, {-5, 0}, 90, GhostvelVecOrigin.name,nil,nil,nil,nil,HUD_material, true, 2.5 )
VVLL.element_params  = {"HUD_BRT"}
VVLL.controllers     = {{"opacity_using_parameter",0}} 
local VVLR =addLine("VVLineRight", 8, {5, 0}, -90, GhostvelVecOrigin.name,nil,nil,nil,nil,HUD_material, true, 2.5 )
VVLR.element_params  = {"HUD_BRT"}
VVLR.controllers     = {{"opacity_using_parameter",0}} 
-------------- Pitch Ladder --------------------------------------
local LadderOrigin	        = CreateElement "ceSimple"
LadderOrigin.name 		     = create_guid_string() 
LadderOrigin.element_params  = {"CURRENT_ROLL", "LADDER_PITCH"} 							   
LadderOrigin.controllers 	 = {{"rotate_using_parameter",0,1},{"move_up_down_using_parameter",1,-1}}
LadderOrigin.parent_element  = velVecOrigin.name
AddElement(LadderOrigin,true)

local function add_ladder_line(name, width, half_gap, tick, shift_y, pitch, controllers)
	
	local lineOrigin = LadderOrigin
	
	-- 0 - left side of the pitch line, 1 - right side respectively
	for i = 0, 1 do
		local side
		local side_name
		if i == 0 then
			side = -1
			side_name = "left"
		else
			side = 1
			side_name = "right"
		end

		local tick_rot
		if shift_y < 0 then
			-- negative pitch
			tick_rot = 0
		else
			-- positive pitch
			tick_rot = 180
		end
		
		local pitchLimited
		if pitch > 90 then
			-- above 90 degrees
			pitchLimited = pitch - 180
			tick_rot = 0
		elseif pitch < -90 then
			-- below -90 degrees
			pitchLimited = pitch + 180
			tick_rot = 180
		else
			pitchLimited = pitch
		end
		
		local length
		local tick_shift_y
		-- each pitch line is rotated by the pitch / 2 angle
		local lineRot = pitchLimited / 2
		if lineRot ~= 0 then
			length     = width / math.cos(math.rad(lineRot))
			tick_shift_y = length * math.sin(math.rad(lineRot))
		else
			length     = width
			tick_shift_y = 0
		end
		
		local line1 = addLine(name.."_hor_"..side_name, length, {half_gap * side, DegToMilRad(pitchLimited)-tick_shift_y}, (lineRot - 90) * side, lineOrigin.name, nil, shift_y < 0, 7, 5, HUD_material, true, 2.5)
		line1.element_params  = {"HUD_BRT"}
		line1.controllers     = {{"opacity_using_parameter",0}}		
		local line2 = addLine(name.."_tick_"..side_name, tick, {(half_gap + width) * side, DegToMilRad(pitchLimited)}, tick_rot, lineOrigin.name, nil, nil, nil, nil, HUD_material, true, 2.5)
		line2.element_params  = {"HUD_BRT"}
		line2.controllers     = {{"opacity_using_parameter",0}}	
		
		if shift_y ~= 0 then
			
			local text_shift_y
			-- pitch numerics text is inverted below -90 and above 90 degrees
			local inverted
			if shift_y < 0 then
				if pitch > -90 then
					inverted = false
					text_shift_y = 8
				else
					inverted = true
					text_shift_y = -8
				end
			else
				if pitch < 90 then
					inverted = false
					text_shift_y = -8
				else
					inverted = true
					text_shift_y = 8
				end
			end
			
			local textAlign
			if side < 0 then
				if inverted == false then
					textAlign = "RightCenter"
				else
					textAlign = "LeftCenter"
				end
			else
				if inverted == false then
					textAlign = "LeftCenter"
				else
					textAlign = "RightCenter"
				end
			end
			
			local text = addSimpleText(name.."_numerics_"..side_name,  pitchLimited, HUD_sdef_regularLarge, textAlign, {(half_gap + width + 4) * side, DegToMilRad(pitchLimited)}, lineOrigin.name, nil, nil, HUD_font, {"HUD_BRT"}, true)
			--text.element_params  = {"HUD_BRT"}
			text.controllers     = {{"opacity_using_parameter",0}}
			if inverted == true then
				text.init_rot = {180}
			end
			
		end
	end
end

add_ladder_line("horizon_line", 40, 17, 6, 0, 0)

-- -85 to +85 degrees
local counterBegin = -85 / 5
local counterEnd   = -counterBegin
for i = counterBegin, counterEnd do
	local name
	local pitch = i * 5
	if i > 0 then
		name = "pitch_line_positive_"..pitch
	else
		name = "pitch_line_negative_"..pitch
	end

	if i ~= 0 then
		add_ladder_line(name, 25, 17, 4, pitch, pitch)
	end
end

addSimpleText("Zenith+", "+", {0.0375,0.0375, 0, 0}, nil, {0,DegToMilRad(90)}, LadderOrigin.name, nil, nil, HUD_font,nil,true )

nadirCircle			    = CreateElement "ceSMultiLine"
nadirCircle.name 		= "nadirCircle"
nadirCircle.init_pos 	= {0, DegToMilRad(-90)}
nadirCircle.material 	= HUD_material 
nadirCircle.parent_element = LadderOrigin.name 			
set_circle(nadirCircle, 16, 14, nil, 26)  -- name, outer R, inner R, arc, sides   
nadirCircle.h_clip_relation  = h_clip_relations.COMPARE
nadirCircle.level			= DEFAULT_LEVEL
nadirCircle.additive_alpha = false
Add(nadirCircle)
addSimpleText("NadirX", "X", {0.025,0.025, 0, 0}, nil, nil, nadirCircle.name , nil, nil, HUD_font, nil, true)
------------ Roll indicator ------------------------------------------
local function add_roll_line(name, width, roll)
	for i = 0, 1 do
		local side
		local side_name
		if i == 0 then
			side = -1
			side_name = "left"
		else
			side = 1
			side_name = "right"
		end		
		
		local radius = 140
		xpos = radius * math.sin(math.rad(roll))*side
		ypos = -radius * math.cos(math.rad(roll))

		local line1 = addLine(name.."_"..side_name, width, {xpos, ypos}, (roll)*side, origin.name, nil, nil, nil, nil, HUD_material, true, 2.5)
		line1.element_params  = {"HUD_BRT","DECLUTTER_LEVEL","MASTER_MODE"}
		line1.controllers     = {{"opacity_using_parameter",0},{"parameter_in_range",1,-0.1,1.9},{"parameter_in_range",2,0}}		
	end
end

add_roll_line("roll_line_0" , 5, 0)
add_roll_line("roll_line_5" , 3, 5)
add_roll_line("roll_line_15", 5, 15)
add_roll_line("roll_line_30", 5, 30)
add_roll_line("roll_line_45", 5, 45)

local rollPointerOrigin	        	= CreateElement "ceSimple"
rollPointerOrigin.name 		     	= create_guid_string() 
rollPointerOrigin.element_params  	= {"CURRENT_ROLL","DECLUTTER_LEVEL","MASTER_MODE"} 							   
rollPointerOrigin.controllers 	 	= {{"rotate_using_parameter",0,1},{"parameter_in_range",0,-0.829,0.829},{"parameter_in_range",1,-0.1,1.9},{"parameter_in_range",2,0}}
rollPointerOrigin.parent_element  = origin.name
Add(rollPointerOrigin)

local tri = addTri("roll_pointer", 0, -135, 8, 4, rollPointerOrigin.name,HUD_material)
tri.element_params  = {"HUD_BRT"}
tri.controllers     = {{"opacity_using_parameter",0}}	
------------------ Heading Tape ----------------------------
boxX = 65
boxY = 12
local headingBase   = CreateElement "ceMeshPoly" 
headingBase.name 	= "headingBase"
headingBase.vertices = {{-boxX, boxY}, -- affects sizing
					{ boxX, boxY},
					{ boxX,-boxY},
					{-boxX,-boxY}}
headingBase.indices			= {0,1,2,2,3,0}
headingBase.tex_coords	 	= {{0,0},{1,0},{1,1},{0,1}}
headingBase.init_pos		= {0, 45, 0}
headingBase.material		= MakeMaterial(nil,{205,5,5,150})	
headingBase.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL  
headingBase.level			= DEFAULT_LEVEL 
headingBase.isvisible		= false
headingBase.collimated      = true
headingBase.element_params  = {"HUD_PWR","DECLUTTER_LEVEL","GEN_BUS"}  
headingBase.controllers     = {{"parameter_in_range",0,1},{"parameter_in_range",1,-0.1,1.9},{"parameter_in_range",2,25,29}}
Add(headingBase)

local HdgTapeorigin	         = CreateElement "ceSimple"
HdgTapeorigin.name 		     = "HdgTapeorigin"
HdgTapeorigin.parent_element = headingBase.name
HdgTapeorigin.element_params = {"CURRENT_HDG"} 
HdgTapeorigin.controllers   = {{"move_left_right_using_parameter",0, -0.004}}
Add(HdgTapeorigin)


local counterBegin = -3	-- need a few extra lines past 0-360 for wrap around
local counterEnd   = 360 / 5 + 3
for i = counterBegin, counterEnd do
	local heading = i * 5
	dot			    = CreateElement "ceSMultiLine"
	dot.name 		= "heading_dot_"..heading
	dot.init_pos 	= {i*20, -8}
	dot.material 	= HUD_material 
	dot.parent_element = HdgTapeorigin.name 			
	set_circle(dot, 1.7, 0, nil, 18)  -- name, outer R, inner R, arc, sides  
	dot.h_clip_relation = h_clip_relations.COMPARE
	dot.level			 = DEFAULT_LEVEL +1
	dot.additive_alpha = false
	dot.element_params  = {"HUD_BRT"}
	dot.controllers     = {{"opacity_using_parameter",0}}	
	Add(dot)
	
	if heading > 355 then
		heading = heading - 360
	elseif heading < 0 then
		heading = heading + 360
	end
	if heading % 2 == 0 then -- only print text for every 10 degrees
		local text = addSimpleText(heading.."_number", heading/10, HUD_sdef_regular, "CenterBottom", {0,6}, dot.name, nil, nil, HUD_font, {"HUD_BRT"}, true )
		text.h_clip_relation = h_clip_relations.COMPARE
		text.level			 = DEFAULT_LEVEL +1
		text.controllers     = {{"opacity_using_parameter",0}}	
	end
end

local x_size = 6
local y_size = 4
local t = 0.6--thickness
local	HDGCaret		= CreateElement "ceSMultiLine"
HDGCaret.name		   	= "HDGCaret" 
HDGCaret.vertices	 = {{0 		    ,	0		},--0
						{x_size     , y_size	},--1
						{x_size+ t  , y_size- t },
						{t 			, -t		},	
						
						{x_size 	, -y_size	},
						{x_size+ t  , -y_size+ t},
						{t 			, t			},--6
						}
HDGCaret.indices	   	 = { 0,1,2,	0,2,3, 0,4,5, 0,5,6}--vertices for each triangle
HDGCaret.init_pos	   	 = {0,29,0}
HDGCaret.init_rot		 = {-90}
HDGCaret.material    	 = HUD_material
HDGCaret.additive_alpha  = false
HDGCaret.h_clip_relation = h_clip_relations.COMPARE
HDGCaret.level 			 = DEFAULT_LEVEL 
HDGCaret.parent_element  = origin.name
HDGCaret.element_params  = {"HUD_BRT","DECLUTTER_LEVEL"}
HDGCaret.controllers     = {{"opacity_using_parameter",0},{"parameter_in_range",1,-0.1,1.9}}	
Add(HDGCaret)

local TCNcommandHeading = addLine("TCNcommandHeading", 9, {0,30}, 180, origin.name, {{"opacity_using_parameter",0},{"move_left_right_using_parameter",1, -0.004},{"parameter_in_range",2,1}},nil,nil,nil,HUD_material, true, 4)
TCNcommandHeading.element_params = {"HUD_BRT","TCN_CMDHDG","TACAN_SELECTED"}

local WYPTcommandHeading = addLine("WYPTcommandHeading", 9, {0,30}, 180, origin.name, {{"opacity_using_parameter",0},{"move_left_right_using_parameter",1, -0.004},{"parameter_in_range",2,1}},nil,nil,nil,HUD_material, true, 4)
WYPTcommandHeading.element_params = {"HUD_BRT","WYPT_CMDHDG","WAYPOINT_SELECTED"}

------------------------ ILS Needles ----------------------------------------------------
local GSorigin	         = CreateElement "ceSimple"
GSorigin.name 		     = "GSorigin"
GSorigin.parent_element  = velVecOrigin.name
GSorigin.element_params  = {"ILS_GS"} 
GSorigin.controllers   	 = {{"move_up_down_using_parameter",0, 0.0175},{"parameter_in_range",0,-1,1.1}}
Add(GSorigin)

local GSline = addLine("GSline", 35, {-17.5,0}, -90, GSorigin.name,nil,nil,nil,nil,HUD_material, true, 2.5)

local LOCorigin	         = CreateElement "ceSimple"
LOCorigin.name 		     = "LOCorigin"
LOCorigin.parent_element  = velVecOrigin.name
LOCorigin.element_params = {"ILS_LOC"} 
LOCorigin.controllers    = {{"move_left_right_using_parameter",0, 0.0175},{"parameter_in_range",0,-1,1.1}}
Add(LOCorigin)

local LOCline = addLine("LOCline", 35, {0,-17.5}, 0, LOCorigin.name,nil,nil,nil,nil,HUD_material, true, 2.5)


------------------- Scratch Pad ------------------------------------
local scratch_output           = CreateElement "ceStringPoly"
scratch_output.name            = create_guid_string()
scratch_output.material        = HUD_font
scratch_output.init_pos        = scratchPadPos
scratch_output.alignment       = "CenterCenter"
scratch_output.stringdefs      = {0.01, 0.01, 0, 0}
scratch_output.formats         = {"%s"} 
scratch_output.element_params  = {"SCRATCH_PAD","SCRATCH_ON","HUD_BRT"}
scratch_output.controllers     = {{"parameter_in_range",1,1},{"text_using_parameter",0,0},{"opacity_using_parameter",2}} 
scratch_output.parent_element  = origin.name
AddElement(scratch_output, true)

addBox("scratchpad",50,8,scratch_output.name,3,{"HUD_BRT"},{{"opacity_using_parameter",0}},{0}, HUD_material, true)
-------========================================================= A/G HUD symbology ==========================================================
local AGorigin	         = CreateElement "ceSimple" -- parent for all A/G elements to turn them all off together
AGorigin.name 		     = create_guid_string() 
AGorigin.parent_element  = origin.name
AGorigin.element_params  = {"MASTER_MODE"} -- 0:nav, 1:AG, 2:AA
AGorigin.controllers   	 = {{"parameter_in_range",0,1}}
Add(AGorigin)


for i = 1,15 do
	local staticLines = addLine("depressionStepLine"..i, 12, {-6,-math.rad(i)*1000}, -90, AGorigin.name,nil,nil,nil,nil,HUD_material, true, 2.5)
	staticLines.element_params = {"CCIP_MODE"} -- manual=0, CCIP=1
	staticLines.controllers    = {{"parameter_in_range",0,0}} 
end

local DSLorigin	         = CreateElement "ceSimple" 
DSLorigin.name 		     = create_guid_string() 
DSLorigin.parent_element = AGorigin.name
DSLorigin.element_params = {"MIL_DEPRESSION","CCIP_MODE"} 
DSLorigin.controllers    = {{"move_up_down_using_parameter",0,-1/1000},{"parameter_in_range",1,0}}
Add(DSLorigin)

local DSLaimingCircleSmall			= CreateElement "ceSMultiLine"
DSLaimingCircleSmall.name 			= "DSLaimingCircleSmall"
DSLaimingCircleSmall.material 		= HUD_material 
DSLaimingCircleSmall.parent_element = DSLorigin.name 			
set_circle(DSLaimingCircleSmall, 3, 2, nil, 15)  -- name, outer R, inner R, arc, sides   
DSLaimingCircleSmall.element_params  = {"HUD_BRT"}
DSLaimingCircleSmall.controllers     = {{"opacity_using_parameter",0}} 
AddElement(DSLaimingCircleSmall, true)

for i = 0,7 do
	addLine("DSLmiddleCircle"..i, 4, {15*math.sin(i*math.rad(45)-math.rad(6)),15*math.cos(i*math.rad(45)-math.rad(6))}, -i*45-90, DSLorigin.name,nil,nil,nil,nil,HUD_material, true, 2.5)
end
for i = 0,18 do
	addLine("DSLoutterCircle"..i, 4, {40*math.sin(i*math.rad(20)-math.rad(2)),40*math.cos(i*math.rad(20)-math.rad(2))}, -i*20-90, DSLorigin.name,nil,nil,nil,nil,HUD_material, true, 2.5)
end

addText("milDepNumber", {95,-45}, {"CCIP_MODE","MIL_DEPRESSION"}, {{"parameter_in_range",0,0},{"text_using_parameter",1,0}}, nil, AGorigin.name,nil,HUD_sdef_regular,HUD_font)


local CCIPorigin	      = CreateElement "ceSimple" 
CCIPorigin.name 		  = create_guid_string() 
CCIPorigin.parent_element = velVecOrigin.name
CCIPorigin.element_params = {"CURRENT_ROLL","CCIP_FINAL","CCIP_MODE","MASTER_MODE"} -- CCIP_mode=1
CCIPorigin.controllers    = {{"rotate_using_parameter",0,1},{"move_up_down_using_parameter",1,1},{"parameter_in_range",2,1},{"parameter_in_range",3,1}}
Add(CCIPorigin)

local crossHairBase	      = CreateElement "ceSimple" 
crossHairBase.name 		  = create_guid_string() 
crossHairBase.parent_element = CCIPorigin.name
crossHairBase.element_params = {"CURRENT_ROLL"} 
crossHairBase.controllers    = {{"rotate_using_parameter",0,-1}}
Add(crossHairBase)

addLine("CCIP_CrossHairLine1", 12, {0,4}, 0, crossHairBase.name,nil,nil,nil,nil,HUD_material, true, 2.5)
addLine("CCIP_CrossHairLine2", 12, {-4,0}, 90, crossHairBase.name,nil,nil,nil,nil,HUD_material, true, 2.5)
addLine("CCIP_CrossHairLine3", 12, {0,-4}, 180, crossHairBase.name,nil,nil,nil,nil,HUD_material, true, 2.5)
addLine("CCIP_CrossHairLine4", 12, {4,0}, 270, crossHairBase.name,nil,nil,nil,nil,HUD_material, true, 2.5)

addText("ccipLabel", {95,-45}, {"CCIP_MODE"}, {{"parameter_in_range",0,1},{"text_using_parameter",0,0}}, {"CCIP"}, AGorigin.name,nil,HUD_sdef_regular,HUD_font)
addText("bombLabel", {95,-55}, {"WEAPON_TYPE"}, {{"parameter_in_range",0,1},{"text_using_parameter",0,0}}, {"BOMB"}, AGorigin.name,nil,HUD_sdef_regular,HUD_font)
addText("rocketLabel", {95,-55}, {"WEAPON_TYPE"}, {{"parameter_in_range",0,2},{"text_using_parameter",0,0}}, {"RKT"}, AGorigin.name,nil,HUD_sdef_regular,HUD_font)


function addCrossoutHorz(name, parent, elements, controllers)
local line1 = addLine(name.."_line1", 28, {13,3.5}, 105, parent,nil,nil,nil,nil,HUD_material, true, 2.5)
line1.element_params = elements 
line1.controllers    = controllers
local line2 = addLine(name.."_line2", 28, {13,-3.5}, 75, parent,nil,nil,nil,nil,HUD_material, true, 2.5)
line2.element_params = elements 
line2.controllers    = controllers
end
addCrossoutHorz("armIndCross", "bombLabel", {"ARMIND"}, {{"parameter_in_range",0,0}})
addCrossoutHorz("armIndCross", "rocketLabel", {"ARMIND"}, {{"parameter_in_range",0,0}})

impactLineLength = 1200
boxX = 1
boxY = impactLineLength/2
local maskBase   = CreateElement "ceMeshPoly" 
maskBase.name 	= "maskBase"
maskBase.vertices = {{-boxX, boxY}, -- affects sizing
					{ boxX, boxY},
					{ boxX,-boxY},
					{-boxX,-boxY}}
maskBase.indices			= {0,1,2,2,3,0}
maskBase.tex_coords	 	= {{0,0},{1,0},{1,1},{0,1}}
maskBase.init_pos		= {0, -impactLineLength/2-4.5, 0}
maskBase.parent_element = CCIPorigin.name
maskBase.material		= MakeMaterial(nil,{205,5,5,130})	
maskBase.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL  
maskBase.level			= DEFAULT_LEVEL 
maskBase.isvisible		= false
maskBase.collimated      = true
maskBase.element_params  = {"CCIP_FINAL"}  
maskBase.controllers     = {{"move_up_down_using_parameter",0,-1}}
Add(maskBase)

local impactLine      	  = CreateElement "ceSMultiLine"
impactLine.name             = "impactLine"
impactLine.material         = HUD_material
impactLine.additive_alpha	  = false
impactLine.collimated		  = true
impactLine.use_mipfilter    = true
impactLine.parent_element = CCIPorigin.name
impactLine.init_pos       = {0, 4, 0}
impactLine.h_clip_relation = h_clip_relations.COMPARE
impactLine.level 		    = DEFAULT_LEVEL+1
impactLine.init_rot   = {0}	
impactLine.vertices   = {{0, 0}, {0, impactLineLength}}
impactLine.indices    = {0, 1}
Add(impactLine)

-------============================== A/A HUD symbology ===========================================
local AAorigin	         = CreateElement "ceSimple"
AAorigin.name 		     = create_guid_string() 
AAorigin.parent_element  = origin.name
AAorigin.element_params  = {"MASTER_MODE"} 
AAorigin.controllers   	 = {{"parameter_in_range",0,2}}
Add(AAorigin)

