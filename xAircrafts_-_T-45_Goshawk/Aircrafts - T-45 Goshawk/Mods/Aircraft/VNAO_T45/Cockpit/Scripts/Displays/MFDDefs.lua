dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."Displays/MFDPages.lua")
SetScale(METERS) --FOV, Milliradians, Meters
DEFAULT_LEVEL = 6
NOCLIP_LEVEL  = DEFAULT_LEVEL - 1
ADI_LEVEL = NOCLIP_LEVEL - 1
-------- Materials ----------

white_color 	=	{240,240,240,255}

white_material  = MakeMaterial(nil,white_color)
display_font	= "font_T45MFD"

defualt_MFD_sdef = {0.0032, 0.0032, 0, 0}

selectionArrow_sdef = {2*0.006,0.006, 0, 0}

----------------- functions for dislay elements -------
MFDHalfSize = 0.062 -- positions are done from center of MFD, so max distance in each direction will be +- half size
--------- use these functions to position MFD elements based on 100%=edge of MFD in each direction
function verticalPos(percent)
	local pos = (percent/100)*MFDHalfSize
	return pos
end
function horizontalPos(percent)
	local pos = (percent/100)*MFDHalfSize
	return pos
end

function sizePercent(percent)
	local pos = (percent/100)*MFDHalfSize
	return pos
end

OB1pos  = {horizontalPos(-72),verticalPos(94)}
OB2pos  = {horizontalPos(-36),verticalPos(94)}
OB3pos  = {0				 ,verticalPos(94)}
OB4pos  = {horizontalPos(36) ,verticalPos(94)}
OB5pos  = {horizontalPos(72) ,verticalPos(94)}
OB6pos  = {horizontalPos(94) ,verticalPos(72)}
OB7pos  = {horizontalPos(94) ,verticalPos(36)}
OB8pos  = {horizontalPos(94) , 				0}
OB9pos  = {horizontalPos(94) ,verticalPos(-36)}
OB10pos = {horizontalPos(94) ,verticalPos(-72)}
OB11pos = {horizontalPos(72) ,verticalPos(-94)}
OB12pos = {horizontalPos(36) ,verticalPos(-94)}
OB13pos = {0				 ,verticalPos(-94)}
OB14pos = {horizontalPos(-36),verticalPos(-94)}
OB15pos = {horizontalPos(-72),verticalPos(-94)}
OB16pos = {horizontalPos(-94),verticalPos(-72)}
OB17pos = {horizontalPos(-94),verticalPos(-36)}
OB18pos = {horizontalPos(-94),				0}
OB19pos = {horizontalPos(-94),verticalPos(36)}
OB20pos = {horizontalPos(-94),verticalPos(72)}
function addOBLabel(labelName, OB_num_pos, value, parent)
	local object           	= CreateElement "ceStringPoly"
	object.name          	= labelName
	object.material 		= display_font
	object.alignment		= "CenterCenter"
	object.init_pos			= OB_num_pos
	object.stringdefs		= {0.0032, 0.0032, 0, 0.001}  -- {size vertical, horizontal, 0, vert spacing}
	object.formats			= {"%s"}
	object.value			= value
	object.parent_element 	= parent
	object.h_clip_relation 	= h_clip_relations.COMPARE
	object.level		  	= DEFAULT_LEVEL 
	Add(object)
	return object
end

function AddElement(object, collimated)
    object.use_mipfilter    = true
	object.additive_alpha   = false
	object.collimated     	= collimated or false
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= DEFAULT_LEVEL 
	Add(object)
end

function addSimpleText(name, value, stringdef, align, pos, parent, controllers, formats, _material, elementParams, collimated)
	local txt = CreateElement "ceStringPoly"--ceStringSLine"
	txt.name               = name
	--txt.isdraw             = true
	txt.material           = _material or display_font
	txt.additive_alpha	  = false
	txt.collimated		  = collimated or false
	txt.use_mipfilter      = true--use_mipfilter
	
	if parent ~= nil then
		txt.parent_element = parent
	end
	
	if controllers ~= nil then
		if type(controllers) == "table" then
			txt.controllers = controllers
		end
	end
	
	pos = pos or {0, 0}
	txt.init_pos       	  = {pos[1], pos[2], 0}
	
	txt.h_clip_relation = h_clip_relations.COMPARE
	txt.level 		    = DEFAULT_LEVEL
	
	txt.alignment = align or "CenterCenter"
	txt.stringdefs = stringdef or defualt_MFD_sdef
		
	if value ~= nil then
		txt.value = value
	end
	txt.element_params  = elementParams
	txt.formats 		= {"%.0f"} --formats
	
	Add(txt)
	return txt
end

function addText(name, pos, elementParams, controllers, _format, parent, alignment, stringdef, font)
local txt_output           = CreateElement "ceStringPoly"
txt_output.name            = name
txt_output.material        = font or display_font
txt_output.init_pos        = pos
txt_output.alignment       = alignment or "CenterCenter"
txt_output.stringdefs      = stringdef or defualt_MFD_sdef
txt_output.formats         = _format or {"%.0f"} 
txt_output.element_params  = elementParams
txt_output.controllers     = controllers
txt_output.parent_element  = parent
txt_output.use_mipfilter   = true
txt_output.additive_alpha  = false
txt_output.collimated      = false
txt_output.h_clip_relation = h_clip_relations.COMPARE
txt_output.level		   = DEFAULT_LEVEL
Add(txt_output)
return txt_output
end

function buildStrokeLineVerts(length, dashed, stroke, gap)
	local verts = {}
	local inds = {}
	
	if dashed == true and stroke ~= nil and gap ~= nil then
		local segLength = stroke + gap
		local numOfWholePairs = math.floor(length / segLength)
		local reminder = length - numOfWholePairs * segLength
		
		local function addSeg(num)
			local shift1 = num * 2
			verts[shift1 + 1] = {0, num * segLength}
			verts[shift1 + 2] = {0, num * segLength + stroke}
			
			inds[shift1 + 1] = shift1
			inds[shift1 + 2] = shift1 + 1
		end
		
		for segNum = 0, numOfWholePairs - 1 do
			addSeg(segNum)
		end
		
		if reminder > 0 then
			if reminder >= stroke then
				addSeg(numOfWholePairs)
			else
				local shift1 = numOfWholePairs * 2
				verts[shift1 + 1] = {0, numOfWholePairs * segLength}
				verts[shift1 + 2] = {0, numOfWholePairs * segLength + reminder}
				
				inds[shift1 + 1] = shift1
				inds[shift1 + 2] = shift1 + 1
			end
		end
	else
		verts = {{0, 0}, {0, length}}
		inds  = {0, 1}
	end
	
	return verts, inds
end
-- line
-- rot (CCW in degrees from up)
-- pos (position of beginning of the line)
function addLine(name, length, pos, rot, parent, controllers, dashed, stroke, gap, material, collimated, thickness, fuzziness)
	local line      = CreateElement "ceSMultiLine"
	line.name             = name
	line.material         = material or white_material
	line.additive_alpha	  = false
	line.use_mipfilter    = true
	line.collimated		  = collimated or false
	
	if parent ~= nil then
		line.parent_element = parent
	end
	
	if controllers ~= nil then
		if type(controllers) == "table" then
			line.controllers = controllers
		end
	end
	
	pos = pos or {0, 0}
	line.init_pos       	  = {pos[1], pos[2], 0}
	
	line.h_clip_relation = h_clip_relations.COMPARE
	line.level 		    = DEFAULT_LEVEL

	if rot ~= nil then
		line.init_rot   = {rot}
	end
		
	local verts, inds = buildStrokeLineVerts(length, dashed, stroke, gap)
	line.vertices   = verts
	line.indices    = inds
	
	line.thickness    		= thickness or 0.9
	line.fuzziness    		= fuzziness or 0.25
	Add(line)
	return line
end


function addBox(name, x, y, parent, _thickness, params, controllers, rot, material, collimated)
		
local box	 = CreateElement "ceSMultiLine"
box.name	 = name 
box.material = material or white_material	
box.vertices = {{-x , y},	
				{-x ,-y},
				{x 	,-y},
				{x  , y},	
				}	
box.indices	= { 0,1,
				1,2,
				2,3,
				3,0}

box.parent_element 		= parent
box.init_rot			= rot
box.additive_alpha 		= false
box.use_mipfilter 		= true
box.h_clip_relation 	= h_clip_relations.COMPARE
box.level 				= DEFAULT_LEVEL
box.element_params		= params
box.controllers			= controllers
box.collimated			= collimated or false
box.thickness    		= _thickness or 1.5
box.fuzziness    		= fuzziness or 0.5
Add(box)	
return box
end

function addTri(name, xPos, yPos, size, _thickness, parent, material)
		
local Triangle	 = CreateElement "ceSMultiLine"
Triangle.name	 = name 
Triangle.material = material or white_material	
Triangle.vertices={ {0 ,0	}, 
					{-0.577*size,size},
					{0.577*size,size},
				}	
Triangle.indices	= { 0,1,
						1,2,
						2,0	}
Triangle.init_pos       	= {xPos,yPos,0}
Triangle.parent_element 	= parent
Triangle.use_mipfilter 		= true
Triangle.additive_alpha 	= false
Triangle.thickness    		= _thickness or 1.5
Triangle.fuzziness    		= fuzziness or 0.5
Triangle.h_clip_relation 	= h_clip_relations.COMPARE
Triangle.level 				= DEFAULT_LEVEL
Add(Triangle)	
return Triangle
end

function addSolidTri(name, pos, rot, sizeX, sizeY, parent)
local Triangle	 = CreateElement "ceMeshPoly"
Triangle.name	 = name 
Triangle.material = white_material	
Triangle.vertices={ {0 		,0	  }, --0
					{-sizeX	,sizeY}, --1
					{sizeX	,sizeY}, --2
				}	
Triangle.indices	= { 0,1,2,}
Triangle.init_pos       	= pos
Triangle.init_rot			= rot
Triangle.parent_element 	= parent
Triangle.use_mipfilter 		= true
Triangle.additive_alpha 	= false
Triangle.h_clip_relation 	= h_clip_relations.COMPARE
Triangle.level 				= DEFAULT_LEVEL
Add(Triangle)	
return Triangle
end

function addDiamond(name, pos, size, _thickness, parent)
local thickness = _thickness or 2 --thickness of lines
		
local Diamond	 = CreateElement "ceMeshPoly"
Diamond.name	 = name 
Diamond.material = white_material	
Diamond.vertices={ {0 			 		 ,0		     			}, --0
					{0 					 ,thickness				}, --1
					
					{-size*0.5+thickness*0.66 ,0.866*size			}, --2
					{-size*0.5  	 	 ,0.866*size 			}, --3
	
					{size*0.5 			 ,0.866*size			}, --4
					{size*0.5-thickness*0.66  ,0.866*size 			}, --5
					
					{0			 		 ,0.866*size*2			 }, --6
					{0					 ,0.866*size*2-thickness }, --7
				}	
Diamond.indices	= { 0,3,2,	0,2,1,
						2,3,6,	2,6,7,
						5,6,7,	4,5,6,
						0,1,5,	0,4,5,
						}
Diamond.init_pos       	= pos
Diamond.parent_element 	= parent
Diamond.use_mipfilter 	= true
Diamond.additive_alpha 	= false
Diamond.h_clip_relation = h_clip_relations.COMPARE
Diamond.level 			= DEFAULT_LEVEL
Add(Diamond)	
return Diamond
end

function addCrossout(name, parent)
addLine(name.."_line1", 0.017, {-.002,-.008}, -15, parent)
addLine(name.."_line2", 0.017, {.002,-.008}, 15, parent)
end

function addCrossoutHorz(name, parent)
addLine(name.."_line1", 0.017, {.008,.002}, 105, parent)
addLine(name.."_line2", 0.017, {.008,-.002}, 75, parent)
end



--[[
--text_using_parameter {element,format}
--move_up_down_using_parameter{element, amount to move when parameter=1}
--move_left_right_using_parameter
--rotate_using_parameter{element,rotaion amount}
--parameter_in_range
--change_opacity_using_parameter
--change_color_using_parameter

compare_parameters
parameter_compare_with_number
change_color_when_parameter_equal_to_number
change_texture_state_using_parameter
fov_control
utility_set_origin_to_cockpit_shape
increase_render_target_counter
]]