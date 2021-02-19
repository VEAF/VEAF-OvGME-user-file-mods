dofile(LockOn_Options.script_path.."HDD/definitions.lua")


local width  	   					= 1.0
local height 	   					= width * GetAspect()
local initpixelposx
local initpixelposy
local imagepixelsizex
local imagepixelsizey
local full_turn 			= math.pi * 2

local infinity = 2^53

local windowCenterY = 0.5806

--------------------------------------------------------------------------------------------------------------------------------------------HDD001_PFD

local HDD001_PFD_origin	         	= CreateElement "ceSimple"
HDD001_PFD_origin.name 		     	= "HDD001_PFD_origin"
HDD001_PFD_origin.init_pos        	= {0,0}
HDD001_PFD_origin.element_params   	=	{
											"DC",
										} 
HDD001_PFD_origin.controllers 	   	=	{
											{"parameter_in_range",0,22,28.05},
										}
AddElement(HDD001_PFD_origin)

local HDD001_PFD					= CreateElement "ceTexPoly"
HDD001_PFD.name 					= "HDD001_PFD"
HDD001_PFD.material   				= "black"
HDD001_PFD.vertices 				= {
										{-width, height},
					  					{ width, height},
					  					{ width,-height},
										{-width,-height}
									}
HDD001_PFD.indices					= default_box_indices	
HDD001_PFD.tex_coords 				= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos   				= {0,0}
HDD001_PFD.element_params			= {
										"hdd_001_brightness",
										"HDD001_PFD",
									}
HDD001_PFD.controllers				= {
										BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
										{"parameter_in_range", 1, 0.95, 1.05},
									}
HDD001_PFD.blend_mode				= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element			= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--================================================================================
--DURHAM HDD AMENDMENT REGION
--------------------------------------------------------------------------------------------------------------------------------------------HDDColors

local width, height			= 2, 3
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_Color"
HDD001_PFD.material       	= "HDD_Color"
HDD001_PFD.vertices       	= {
								{-width, height},
								{ width, height},
								{ width,-height},
								{-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       	= {0, windowCenterY - 0.013}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
								"HDD_ROLL",
								"HDD_PITCH",
                            }
HDD001_PFD.controllers    	= {
                            -- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",           1, 0.95, 1.05},
								{"rotate_using_parameter",       2, 1.0},
								{"move_up_down_using_parameter", 3, -full_turn / 4, full_turn / 4},

                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--------------------------------------------------------------------------------------------------------------------------------------------HDDLadder
local dimension 			= 0.6275 -- = 0.6447249
local width, height			= dimension, 4 * dimension		--2.72, 2.72
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_Color"
HDD001_PFD.material       	= "HDD_Ladder_Lines"
HDD001_PFD.vertices       	= {
								{-width, height},
								{ width, height},
								{ width,-height},
								{-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
-- HDD001_PFD.init_pos       = {0,-0.005} -- ADI_mask.dds
HDD001_PFD.init_pos       	= {-0.065, windowCenterY - 0.013}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
								"HDD_ROLL",
								"HDD_PITCH",
                            }
HDD001_PFD.controllers    	= {
                            -- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",           1, 0.95, 1.05},
								{"rotate_using_parameter",       2, 1.0},
								{"move_up_down_using_parameter", 3, -full_turn / 4, full_turn / 4},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--------------------------------------------------------------------------------------------------------------------------------------------HDDFPM
local dimension 			= 0.1725--0.6275 -- = 0.6447249
local width, height			= dimension, dimension		--2.72, 2.72
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD_FPM"
HDD001_PFD.material       	= "HDD_FPM"
HDD001_PFD.vertices       	= {
								{-width, height},
								{ width, height},
								{ width,-height},
								{-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
-- HDD001_PFD.init_pos       = {0,-0.005} -- ADI_mask.dds
HDD001_PFD.init_pos       	= { -0.065, windowCenterY + 0.0} --0.60 } --x=-.0825
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
								--"HDD_FPM_VERT",
								"HDD_FPM_HORZ",
                            }
HDD001_PFD.controllers    	= {
                            -- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range"				, 1, 0.95, 1.05},
								--{"move_left_right_using_parameter"	, 2, 1.0 },
								{"move_up_down_using_parameter"		, 2, 1.0 },
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
-- AddElement(HDD001_PFD)

--------------------------------------------------------------------------------------------------------------------------------------------HDDBankIndicator
local dim 					= 0.71 --0.71
local width, height			= dim, dim
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_BankInd"
HDD001_PFD.material       	= "HDD_BankIndicator"
HDD001_PFD.vertices       	= {
								{-width, height},
								{ width, height},
								{ width,-height},
								{-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
-- HDD001_PFD.init_pos       = {0,-0.005} -- ADI_mask.dds
HDD001_PFD.init_pos       	= { -0.06, windowCenterY} --0.60 }
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
								"HDD_BANK",
                            }
HDD001_PFD.controllers    	= {
                            -- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",           1, 0.95, 1.05},
								{"rotate_using_parameter",       2, 1.0},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--------------------------------------------------------------------------------------------------------------------------------------------HDDBankIndicatorFill
local dim 					= 0.71 --0.71
local width, height			= dim, dim
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_BankFill"
HDD001_PFD.material       	= "HDD_BankIndicator_Fill"
HDD001_PFD.vertices       	= {
								{-width, height},
								{ width, height},
								{ width,-height},
								{-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
-- HDD001_PFD.init_pos       = {0,-0.005} -- ADI_mask.dds
HDD001_PFD.init_pos       	= { -0.06, windowCenterY} --0.60 }
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
								"HDD_BANK",
								"HDD_BANK_FILL",
                            }
HDD001_PFD.controllers    	= {
                            -- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",           1, 0.95, 1.05},
								{"rotate_using_parameter",       2, 1.0},
								{"opacity_using_parameter",      3}, --turns on the opacity when 1
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--------------------------------------------------------------------------------------------------------------------------------------------ADI MASK
local maskDim				= 0.7125
local width, height       	= 2* maskDim, 4 * maskDim -- ADI_mask.dds
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_ADI_Mask"
HDD001_PFD.material       	= "HDD_ADI_Mask"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       = {-0.065, -1.52} -- ADI_mask.dds
HDD001_PFD.element_params 	= {
                            "hdd_001_brightness",
                            "HDD001_PFD",
                            }
HDD001_PFD.controllers    	= {
                           -- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
                            {"parameter_in_range",1,0.95,1.05},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--------------------------------------------------------------------------------------------------------------------------------------------COMPASS ROSE
local maskDim				= 0.605
local width, height       	= maskDim, maskDim -- ADI_mask.dds
--local width, height			= 1.1, 1.1
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_CompassRose"
HDD001_PFD.material       	= "HDD_CompassRose"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       = {-0.065, -0.785} -- ADI_mask.dds
--HDD001_PFD.init_pos       	= { -0.08, 0.63 }
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
								"HDD_HEADING"
                            }
HDD001_PFD.controllers    	= {
								--BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",1,0.95,1.05},
								{"rotate_using_parameter", 2, 1.0},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--------------------------------------------------------------------------------------------------------------------------------------------HEADING BUG
local maskDim				= 0.40
local width, height       	= maskDim, maskDim -- ADI_mask.dds
--local width, height			= 1.1, 1.1
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_CompassHeading"
HDD001_PFD.material       	= "HDD_CompassHeading"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       = {-0.065, -0.6225} -- ADI_mask.dds
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
                            }
HDD001_PFD.controllers    	= {
								BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",1,0.95,1.05},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)
-----------------------------------------------------------------------------------------------------------------GRINNELLI HERE
-----------------------------------------------------------------------------------------------------------------Clipping CLEAR AREA
--888888888888888888888888888888888888888888888888888888888888888888|| LEVEL 5 ||888888888888888888888888888888888888888888888888888888888888888888888
local PFD_MASK_BASE_1 	= MakeMaterial(nil,{255,0,0,127})--Red Color Clipping Mask using RGB
local PFD_MASK_BASE_2 	= MakeMaterial(nil,{0,0,255,255})--Blue Color Clipping Masks using RGB
local ClippingPlaneSize = 0.495 --Height 0.5
local ClippingWidth 	= 0.12 --Width
--default level is 4?
----------------------------------------------------------------------------------
local SPEED_MASK_AREA           = CreateElement "ceMeshPoly"
SPEED_MASK_AREA.name            = "SPEED_MASK_AREA"
SPEED_MASK_AREA.primitivetype   = "triangles"
SPEED_MASK_AREA.vertices        = {
										{-1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 * ClippingWidth,1 * ClippingPlaneSize},
										{-1 * ClippingWidth,1 * ClippingPlaneSize},										
									}
SPEED_MASK_AREA.material        = PFD_MASK_BASE_1
SPEED_MASK_AREA.indices         = {0,1,2,2,3,0}
SPEED_MASK_AREA.init_pos        = {-0.88, 0.6, 0}
SPEED_MASK_AREA.init_rot        = {0, 0, 0} -- NOTE:degree NOT rad
SPEED_MASK_AREA.h_clip_relation = h_clip_relations.REWRITE_LEVEL
SPEED_MASK_AREA.level           = 5
SPEED_MASK_AREA.collimated      = false
SPEED_MASK_AREA.isvisible       = false
Add(SPEED_MASK_AREA)
---------------------------------------------------------------------------------------------Clipping MASK
local SPEED_CLIP_MASK               = CreateElement "ceMeshPoly"
SPEED_CLIP_MASK.name                = "SPEED_CLIP_MASK"
SPEED_CLIP_MASK.primitivetype       = "triangles"
SPEED_CLIP_MASK.init_pos            = {-0.88, 0.6, 0}
SPEED_CLIP_MASK.init_rot            = { 0, 0, 0} -- degree NOT rad
SPEED_CLIP_MASK.vertices            = {
											{-1 * ClippingWidth,-1 * ClippingPlaneSize},
											{1 * ClippingWidth,-1 * ClippingPlaneSize},
											{1 * ClippingWidth,1 * ClippingPlaneSize},
											{-1 * ClippingWidth,1 * ClippingPlaneSize},										
									}
SPEED_CLIP_MASK.indices             = {0,1,2,2,3,0}
SPEED_CLIP_MASK.material            = PFD_MASK_BASE_2
SPEED_CLIP_MASK.h_clip_relation     = h_clip_relations.INCREASE_IF_LEVEL
SPEED_CLIP_MASK.level               = 5
SPEED_CLIP_MASK.collimated          = false
SPEED_CLIP_MASK.isvisible           = false
Add(SPEED_CLIP_MASK)
--------------------------------------------------------------------------------------------------------------------------

--==============================================================================================================GREEN=AIRSPEED=NUMBERS
--numbers running alongside airspeed tape
local tapeCenter_y = -0.64
local tapeNumberOffset = -0.825 - tapeCenter_y -- -0.73 starting value too close together
local tapeNumber_x = -0.84
local tick_y_shift = -0.005
local tick_x = -0.799
local IAS_tape_number_size = 0.005

local IAS_tape_level = 6
local IAS_numbers_below_base = 3

--base number for tape
for i = 1, 7 do
	local current_tape_number_y = tapeCenter_y + (i - 1 - IAS_numbers_below_base) * tapeNumberOffset
	local IAS_number_parameter = "HDD_IAS_TAPE" .. i
	Add_Text_With_Level("HDD_IAS_TAPE" .. i,
		"font_HDD_green",
		"RightCenter",
		HDD001_PFD_origin.name,
		{--params
			"hdd_001_brightness",
			IAS_number_parameter,
			"HDD_IAS_TAPE_SHIFT",
		},
		{--controllers
		-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
			{"text_using_parameter",1,0},
			{"move_up_down_using_parameter", 2, 1.0 },
			{"parameter_in_range", 1, -0.1, infinity},
		},
		{"%.0f"}, {IAS_tape_number_size, IAS_tape_number_size, 0, 0},
		tapeNumber_x,--initpixelposx
		current_tape_number_y, --initpixelposy
		IAS_tape_level
	)

	--add the tick markers to IAS tape
	for j = 1, 2 do
		Add_Thick_Line("HDD_IAS_TICK_" .. i .. "_" .. j, "green", 8, 200,
			tick_x, -(current_tape_number_y + (j - 1) * tapeNumberOffset / 2) + tick_y_shift, HDD001_PFD_origin.name,
			{"HDD_IAS_TAPE_SHIFT", IAS_number_parameter},
			{
				{"move_up_down_using_parameter", 0, 1.0 },
				{"parameter_in_range", 1, -0.1, infinity},
			},
			IAS_tape_level
		)
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------AIRSPEED TAPE MASK
local maskDim				= 0.3425
local width, height       	= maskDim, 2 * maskDim 
--local width, height			= 1.1, 1.1
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_Airspeed"
HDD001_PFD.material       	= "HDD_Airspeed"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       = {-0.8125, 0.64}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range", 1, 0.95, 1.05},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--fixed position top number in block
Add_Text("HDD_IAS_TAPE_MAX",
		 "font_HDD_green",
		 "RightCenter",
		 HDD001_PFD_origin.name,
		{--params
			"hdd_001_brightness",
			"HDD_IAS_TAPE_MAX",
		},
		{--controllers
		-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
			{"text_using_parameter", 1, 0},
		},
		{"%.0f"}, {IAS_tape_number_size, IAS_tape_number_size, 0, 0},
		tapeNumber_x,--initpixelposx
		tapeCenter_y + (2.725 * tapeNumberOffset) --initpixelposy
)
--------------------------------------------------------------------------------------------------------------------------------------------AIRSPEED ARROW MASK
local maskDim				= 0.3425
local width, height       	= maskDim, 2 * maskDim 
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_Airspeed"
HDD001_PFD.material       	= "HDD_Airspeed_Arrow"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       = {-0.8125, 0.64}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",1,0.95,1.05},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
-- HDD001_PFD.level			= 6
--HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD, 6)
------------------------------------------------------------------------CLIPPING HERE

-----------------------------------------------------------------------------------------------------------------Clipping CLEAR AREA
--888888888888888888888888888888888888888888888888888888888888888888|| LEVEL 7 ||888888888888888888888888888888888888888888888888888888888888888888888
local PFD_MASK_BASE_3 	= MakeMaterial(nil,{255,0,0,127})--Red Color Clipping Mask using RGB
local PFD_MASK_BASE_4 	= MakeMaterial(nil,{0,0,255,255})--Blue Color Clipping Masks using RGB
local ClippingPlaneSize = 0.08 --Height --d likes 0.083
local ClippingWidth 	= 0.1 --Width
local arrow_mask_pos = {-0.9, 0.64, 0}
----------------------------------------------------------------------------------
local ARROW_MASK_AREA           = CreateElement "ceMeshPoly"
ARROW_MASK_AREA.name            = "ARROW_MASK_AREA"
ARROW_MASK_AREA.primitivetype   = "triangles"
ARROW_MASK_AREA.vertices        = {
										{-1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 * ClippingWidth,1 * ClippingPlaneSize},
										{-1 * ClippingWidth,1 * ClippingPlaneSize},										
									}
ARROW_MASK_AREA.material        = PFD_MASK_BASE_3
ARROW_MASK_AREA.indices         = {0,1,2,2,3,0}
ARROW_MASK_AREA.init_pos        = arrow_mask_pos
ARROW_MASK_AREA.init_rot        = {0, 0, 0} -- NOTE:degree NOT rad
ARROW_MASK_AREA.h_clip_relation = h_clip_relations.REWRITE_LEVEL
ARROW_MASK_AREA.level           = 7
ARROW_MASK_AREA.collimated      = false
ARROW_MASK_AREA.isvisible       = false
Add(ARROW_MASK_AREA)
---------------------------------------------------------------------------------------------Clipping MASK
local ARROW_CLIP_MASK               = CreateElement "ceMeshPoly"
ARROW_CLIP_MASK.name                = "ARROW_CLIP_MASK"
ARROW_CLIP_MASK.primitivetype       = "triangles"
ARROW_CLIP_MASK.init_pos            = arrow_mask_pos
ARROW_CLIP_MASK.init_rot            = { 0, 0, 0} -- degree NOT rad
ARROW_CLIP_MASK.vertices            = {
											{-1 * ClippingWidth,-1 * ClippingPlaneSize},
											{1 * ClippingWidth,-1 * ClippingPlaneSize},
											{1 * ClippingWidth,1 * ClippingPlaneSize},
											{-1 * ClippingWidth,1 * ClippingPlaneSize},										
									}
ARROW_CLIP_MASK.indices             = {0,1,2,2,3,0}
ARROW_CLIP_MASK.material            = PFD_MASK_BASE_4
ARROW_CLIP_MASK.h_clip_relation     = h_clip_relations.INCREASE_IF_LEVEL
ARROW_CLIP_MASK.level               = 7
ARROW_CLIP_MASK.collimated          = false
ARROW_CLIP_MASK.isvisible           = false
Add(ARROW_CLIP_MASK)
------------------------------------------------------------------------CLIPPING END
--------------------------------------------------------------------------------------------------------------------------------------------AIRSPEED INDICATOR
local offset = 0.013
local IAS_ones_level = 8
Add_Text_With_Level("HDD_IAS_HUNDREDS",
		 "font_HDD_white",
		 "RightCenter",
		 HDD001_PFD_origin.name,
		{--params
			"hdd_001_brightness",
			"HDD_IAS_HUNDYS",
		},
		{--controllers
		-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
			{"text_using_parameter",1,0},
		},
		{"%.0f"}, {0.00625,0.00625, 0, 0},
		-0.90 + offset,--initpixelposx
		-0.64, --initpixelposy
		IAS_ones_level
)

-- Rolling airspeed ones place
local center_number_pos_x = -0.865 + offset
local center_number_pos_y = -0.64
local number_offset = -0.73 - center_number_pos_y
local ias_ones_below_base = 1
for i = 1, 4 do
	Add_Text_With_Level("HDD_IAS_ONES" .. i,
		"font_HDD_white",
		"CenterCenter",
		HDD001_PFD_origin.name,
		{--params
			"hdd_001_brightness",
			"HDD_IAS_ONES" .. i,
			"HDD_IAS_ONES_Y",
		},
		{--controllers
		-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
			{"text_using_parameter", 1, 0},
			{"move_up_down_using_parameter", 2, 1.0 },
		},
		{"%.0f"}, {0.00625,0.00625, 0, 0},
		center_number_pos_x,--initpixelposx
		center_number_pos_y + number_offset * (i - 1 - ias_ones_below_base),--initpixelposy
		IAS_ones_level
	)
end

--------------------------------------------------------------------------------------------------------------------------------------------AIRSPEED NUMBER MASK
local maskDim				= 0.3425
local width, height       	= maskDim, 2 * maskDim
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_AirspeedMask"
HDD001_PFD.material       	= "HDD_AirspeedNumberMask"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       = {-0.8125, 0.64}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",1,0.95,1.05},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
--AddElement(HDD001_PFD)
--------------------------------------------------------------------------------------ALL GREEEN ALT NUMBERS HERE



-----------------------------------------------------------------------------------------------------------------Clipping CLEAR AREA
--888888888888888888888888888888888888888888888888888888888888888888|| LEVEL 9 ||888888888888888888888888888888888888888888888888888888888888888888888
local ALT_MASK 		= MakeMaterial(nil,{255,0,0,127})--Red Color Clipping Mask using RGB
local ALT_MASK_2 	= MakeMaterial(nil,{0,0,255,255})--Blue Color Clipping Masks using RGB
local ClippingPlaneSize = 0.545 --Height
local ClippingWidth 	= 0.15 --Width
--default level is 4?
----------------------------------------------------------------------------------
local ALT_MASK_AREA           = CreateElement "ceMeshPoly"
ALT_MASK_AREA.name            = "ALT_MASK_AREA"
ALT_MASK_AREA.primitivetype   = "triangles"
ALT_MASK_AREA.vertices        = {
										{-1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 * ClippingWidth,1 * ClippingPlaneSize},
										{-1 * ClippingWidth,1 * ClippingPlaneSize},										
									}
ALT_MASK_AREA.material        = ALT_MASK
ALT_MASK_AREA.indices         = {0,1,2,2,3,0}
ALT_MASK_AREA.init_pos        = {0.85, 0.6395, 0}
ALT_MASK_AREA.init_rot        = {0, 0, 0} -- NOTE:degree NOT rad
ALT_MASK_AREA.h_clip_relation = h_clip_relations.REWRITE_LEVEL
ALT_MASK_AREA.level           = 5
ALT_MASK_AREA.collimated      = false
ALT_MASK_AREA.isvisible       = false
Add(ALT_MASK_AREA)
---------------------------------------------------------------------------------------------Clipping MASK
local ALT_CLIP_MASK               = CreateElement "ceMeshPoly"
ALT_CLIP_MASK.name                = "ALT_CLIP_MASK"
ALT_CLIP_MASK.primitivetype       = "triangles"
ALT_CLIP_MASK.init_pos            = {0.85, 0.6395, 0}
ALT_CLIP_MASK.init_rot            = { 0, 0, 0} -- degree NOT rad
ALT_CLIP_MASK.vertices            = {
											{-1 * ClippingWidth,-1 * ClippingPlaneSize},
											{1 * ClippingWidth,-1 * ClippingPlaneSize},
											{1 * ClippingWidth,1 * ClippingPlaneSize},
											{-1 * ClippingWidth,1 * ClippingPlaneSize},										
									}
ALT_CLIP_MASK.indices             = {0,1,2,2,3,0}
ALT_CLIP_MASK.material            = ALT_MASK_2
ALT_CLIP_MASK.h_clip_relation     = h_clip_relations.INCREASE_IF_LEVEL
ALT_CLIP_MASK.level               = 5
ALT_CLIP_MASK.collimated          = false
ALT_CLIP_MASK.isvisible           = false
Add(ALT_CLIP_MASK)
--------------------------------------------------------------------------------------------------------------------------------------------ALTITUDE TAPE NUMBERS
--position for tape numbers
local alt_thous_size = 0.00625
local small_alt_size = alt_thous_size * 25 / 34
local alt_tape_x_thousands = 0.875
local alt_tape_x_hundreds = 0.925
local small_tape_size = small_alt_size * 20/24
local alt_tape_increment = 0.2958
local alt_tape_base_y = -0.633
local alt_tape_tick_base_y = -alt_tape_base_y
local alt_tape_level = 6
local alt_tape_numbers_below_base = 1

--numbers in 500 ft increments
for i = 1, 4 do
	local current_offset = (i - 1 - alt_tape_numbers_below_base) * alt_tape_increment
	Add_Text_With_Level("HDD_ALT_TAPE_HUNDYS"..i,
			"font_HDD_green",
			"CenterCenter",
			HDD001_PFD_origin.name,
			{--params
				"hdd_001_brightness",
				"HDD_ALT_TAPE_HUNDYS"..i,
				"HDD_ALT_TAPE_Y",
				"HDD_ALT_TAPE"..i,
			},
			{--controllers
			-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
				{"text_using_parameter", 1, 0},
				{"move_up_down_using_parameter", 2, 1.0},
				{"parameter_in_range", 3, 99, infinity},
			},
			{"%03.0f"}, {small_tape_size, small_tape_size, 0, 0},
			alt_tape_x_hundreds, --initpixelposx
			alt_tape_base_y - current_offset, --initpixelposy
			alt_tape_level
	)
	--thousands
	Add_Text_With_Level("HDD_ALT_TAPE_THOUSANDS"..i,
			"font_HDD_green",
			"RightCenter",
			HDD001_PFD_origin.name,
			{--params
				"hdd_001_brightness",
				"HDD_ALT_TAPE_THOUSANDS"..i,
				"HDD_ALT_TAPE_Y",
				"HDD_ALT_TAPE"..i,
			},
			{--controllers
			-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
				{"text_using_parameter", 1, 0},
				{"move_up_down_using_parameter", 2, 1.0 },
				{"parameter_in_range", 3, 999, infinity},
			},
			{"%.0f"}, {small_alt_size, small_alt_size, 0, 0},
			alt_tape_x_thousands, --initpixelposx
			alt_tape_base_y - 0.0042 - current_offset,--initpixelposy
			alt_tape_level
	)
	--add the tick markers to the 500's
	Add_Thick_Line("Alt_500_Tick_"..i, "green", 8, 320, 0.7, alt_tape_tick_base_y + current_offset, HDD001_PFD_origin.name, {"HDD_ALT_TAPE_Y"}, {{"move_up_down_using_parameter", 0, 1.0 }}, alt_tape_level)
	
	--loop to add the hundred ticks
	for j = 1, 4 do
		Add_Thick_Line("Alt_100_Tick_"..i.."_"..j, "green", 8, 160, 0.7, alt_tape_tick_base_y + current_offset + (alt_tape_increment * j / 5), HDD001_PFD_origin.name, {"HDD_ALT_TAPE_Y"}, {{"move_up_down_using_parameter", 0, 1.0 }}, alt_tape_level)
	end

	--adds the ticks below the bottom 500 displayed
	if i == 1 then
		for j = 1, 4 do
			Add_Thick_Line("Alt_100_Tick_0_"..j, "green", 8, 160, 0.7, alt_tape_tick_base_y + current_offset + (alt_tape_increment * j / 5) - alt_tape_increment, HDD001_PFD_origin.name, {"HDD_ALT_TAPE_Y"}, {{"move_up_down_using_parameter", 0, 1.0 }}, alt_tape_level)
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------ALTITUDE ARROW MASK
local maskDim				= 0.3425
local width, height       	= maskDim, 2 * maskDim 
--local width, height			= 1.1, 1.1
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_Altitude_Arrow"
HDD001_PFD.material       	= "HDD_Altitude_Arrow"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       = {0.815, 0.64}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",1,0.95,1.05},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
--HDD001_PFD.parent_element 	= HDD001_PFD_origin.name

AddElement(HDD001_PFD, alt_tape_level)

-----------------------------------------------------------------------------------------------------------------Clipping CLEAR AREA
--888888888888888888888888888888888888888888888888888888888888888888|| LEVEL 7 ||888888888888888888888888888888888888888888888888888888888888888888888
local ALT_MASK 		= MakeMaterial(nil,{255,0,0,127})--Red Color Clipping Mask using RGB
local ALT_MASK_2 	= MakeMaterial(nil,{0,0,255,255})--Blue Color Clipping Masks using RGB
local ClippingPlaneSize = 0.06 --Height
local ClippingWidth 	= 0.15 --Width
----------------------------------------------------------------------------------
local ALT_MASK_AREA           = CreateElement "ceMeshPoly"
ALT_MASK_AREA.name            = "ALT_MASK_AREA"
ALT_MASK_AREA.primitivetype   = "triangles"
ALT_MASK_AREA.vertices        = {
										{-1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 * ClippingWidth,1 * ClippingPlaneSize},
										{-1 * ClippingWidth,1 * ClippingPlaneSize},										
									}
ALT_MASK_AREA.material        = ALT_MASK
ALT_MASK_AREA.indices         = {0,1,2,2,3,0}
ALT_MASK_AREA.init_pos        = {0.85, 0.6395, 0}
ALT_MASK_AREA.init_rot        = {0, 0, 0} -- NOTE:degree NOT rad
ALT_MASK_AREA.h_clip_relation = h_clip_relations.REWRITE_LEVEL
ALT_MASK_AREA.level           = 7
ALT_MASK_AREA.collimated      = false
ALT_MASK_AREA.isvisible       = false
Add(ALT_MASK_AREA)
---------------------------------------------------------------------------------------------Clipping MASK
local ALT_CLIP_MASK               = CreateElement "ceMeshPoly"
ALT_CLIP_MASK.name                = "ALT_CLIP_MASK"
ALT_CLIP_MASK.primitivetype       = "triangles"
ALT_CLIP_MASK.init_pos            = {0.85, 0.6395, 0}
ALT_CLIP_MASK.init_rot            = { 0, 0, 0} -- degree NOT rad
ALT_CLIP_MASK.vertices            = {
											{-1 * ClippingWidth,-1 * ClippingPlaneSize},
											{1 * ClippingWidth,-1 * ClippingPlaneSize},
											{1 * ClippingWidth,1 * ClippingPlaneSize},
											{-1 * ClippingWidth,1 * ClippingPlaneSize},										
									}
ALT_CLIP_MASK.indices             = {0,1,2,2,3,0}
ALT_CLIP_MASK.material            = ALT_MASK_2
ALT_CLIP_MASK.h_clip_relation     = h_clip_relations.INCREASE_IF_LEVEL
ALT_CLIP_MASK.level               = 7
ALT_CLIP_MASK.collimated          = false
ALT_CLIP_MASK.isvisible           = false
Add(ALT_CLIP_MASK)

--------------------------------------------------------------------------------------------------------------------------------------------ALTITUDE INDICATOR
--local offset = 0.0125
--THOUSANDS - TWO DIGITS AS CEILING < 100,000FT
local alt_arrow_level = 8
Add_Text("HDD_ALT_THOUSANDS",
		 "font_HDD_white",
		 "RightCenter",
		 HDD001_PFD_origin.name,
		{--params
			"hdd_001_brightness",
			"HDD_ALT_GRANDS",
			"HDD_ALT",
		},
		{--controllers
		-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
			{"text_using_parameter",1,0},
			{"parameter_in_range", 2, 999.9, infinity},
		},
		{"%.0f"}, {alt_thous_size, alt_thous_size, 0, 0},
		0.854, --initpixelposx
		-0.64,--initpixelposy
		alt_arrow_level
)

local small_alt_y = -0.635
--HUNDREDS - ONE DIGIT 0-9
Add_Text("HDD_ALT_HUNDREDS",
		 "font_HDD_white",
		 "RightCenter",
		 HDD001_PFD_origin.name,
		{--params
			"hdd_001_brightness",
			"HDD_ALT_HUNDYS",
			"HDD_ALT",
		},
		{--controllers
		-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
			{"text_using_parameter",1,0},
			{"parameter_in_range", 2, 99.9, infinity},
		},
		{"%.0f"}, {small_alt_size, small_alt_size, 0, 0},
		0.902, --initpixelposx
		small_alt_y,--initpixelposy
		alt_arrow_level
)

local alt_twenties_up1_pos = -0.70 
local alt_offset = alt_twenties_up1_pos - small_alt_y
local alt_twenties_below_base = 1
for i = 1, 4 do
	Add_Text("HDD_ALT_TWENTIES" .. i,
		"font_HDD_white",
		"CenterCenter",
		HDD001_PFD_origin.name,
		{--params
			"hdd_001_brightness",
			"HDD_ALT_TWENTIES" .. i,
			"HDD_ALT_TWENTIES_Y",
		},
		{--controllers
		-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
			{"text_using_parameter",1,0},
			{"move_up_down_using_parameter", 2, 1.0 },
		},
		{"%02.0f"}, {small_alt_size, small_alt_size, 0, 0},
		0.95, --initpixelposx
		small_alt_y + alt_offset * (i - alt_twenties_below_base - 1),--initpixelposy
		alt_arrow_level
	)
end

--------------------------------------------------------------------------------------------------------------------------------------------ALTITUDE TAPE INDICATOR MASK
--surrounding rectangle
local maskDim				= 0.3425
local width, height       	= maskDim, 2 * maskDim 
--local width, height			= 1.1, 1.1
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_Altitude"
HDD001_PFD.material       	= "HDD_Altitude"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       	= {0.815, 0.64}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",1,0.95,1.05},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)


--------------------------------------------------------------------------------------------------------------------------------------------VVI TAPE
local maskDim				= 0.3425
local width, height       	= maskDim, 2 * maskDim 
--local width, height			= 1.1, 1.1
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_VVI"
HDD001_PFD.material       	= "HDD_VVI_Tape"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       	= {0.60, 0.64}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",1,0.95,1.05},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--------------------------------------------------------------------------------------------------------------------------------------------VVI INDICATOR BOX
local maskDim				= 0.3425
local width, height       	= maskDim, 2 * maskDim 
--local width, height			= 1.1, 1.1
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_VVI_Box"
HDD001_PFD.material       	= "HDD_VVI_Box"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       	= {0.60, 0.64}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
								"HDD_VVI_INDEXER",
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",1,0.95,1.05},
								{"move_up_down_using_parameter", 2, 1.0 },
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--------------------------------------------------------------------------------------------------------------------------------------------VVI UPPER ARROW
local maskDim				= 0.3425
local width, height       	= maskDim, 2 * maskDim 
--local width, height			= 1.1, 1.1
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_VVI_UpArrow"
HDD001_PFD.material       	= "HDD_VVI_TopArrow"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       	= {0.60, 0.64}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
								"HDD_VVI_UP",
								"HDD_VVI_INDEXER",
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",1,0.95,1.05},
								{"opacity_using_parameter",      2}, --turns on the opacity when 1
								{"move_up_down_using_parameter", 3, 1.0 },
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--------------------------------------------------------------------------------------------------------------------------------------------VVI LOWER ARROW
local maskDim				= 0.3425
local width, height       	= maskDim, 2 * maskDim 
--local width, height			= 1.1, 1.1
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PFD_VVI_DnArrow"
HDD001_PFD.material       	= "HDD_VVI_BottomArrow"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       	= {0.60, 0.64}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
								"HDD_VVI_DN",
								"HDD_VVI_INDEXER",
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",1,0.95,1.05},
								{"opacity_using_parameter",      2}, --turns on the opacity when 1
								{"move_up_down_using_parameter", 3, 1.0 },
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--------------------------------------------------------------------------------------------------------------------------------------------GROUND SPEED BOX
local maskDim				= 0.17125
local width, height       	= maskDim, maskDim 
--local width, height			= 1.1, 1.1
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_GS_Box"
HDD001_PFD.material       	= "HDD_GS_Box"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       	= {-0.75, -0.13}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",1,0.95,1.05},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--------------------------------------------------------------------------------------------------------------------------------------------GROUND SPEED DISPLAY
Add_Text("HDD_GS_VALUE",
		 "font_HDD_white_mono",
		 "RightCenter",
		 HDD001_PFD_origin.name,
		{--params
			"hdd_001_brightness",
			"HudGS",
		},
		{--controllers
		-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
			{"text_using_parameter",1,0},
		},
		{"%.0f"}, {0.008,0.008, 0, 0},
		-0.63, --initpixelposx
		0.13 --initpixelposy
)


--------------------------------------------------------------------------------------------------------------------------------------------HEADING BOX
local maskDim				= 0.17125
local width, height       	= maskDim, maskDim 
--local width, height			= 1.1, 1.1
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_HDG_Box"
HDD001_PFD.material       	= "HDD_HDG_Box"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       	= {-0.064, -0.18}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range",1,0.95,1.05},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)
--------------------------------------------------------------------------------------------------------------------------------------------HEADING DISPLAY
Add_Text("HDD_HDG_VALUE",
		 "font_HDD_white_mono",
		 "CenterCenter",
		 HDD001_PFD_origin.name,
		{--params
			"hdd_001_brightness",
			"HDD_HDG_IND",
		},
		{--controllers
		-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
			{"text_using_parameter",1,0},
		},
		{"%03.0f"}, {0.008,0.008, 0, 0},
		-0.0625, --initpixelposx
		0.18 --initpixelposy
)
--------------------------------------------------------------------------------------------------------------------------------------------G METER
Add_Text("HDD_G_VALUE",
		 "font_HDD_white",
		 "RightCenter",
		 HDD001_PFD_origin.name,
		{--params
			"hdd_001_brightness",
			"Gforce",
		},
		{--controllers
		-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
			{"text_using_parameter",1,0},
		},
		{"%01.1fG"}, {0.006,0.006, 0, 0},
		-0.65, --initpixelposx
		0.25 --initpixelposy
)
--------------------------------------------------------------------------------------------------------------------------------------------RADALT BOX
local AGL_y                 = -0.325
local AGL_shift 			= 0.1

--AGL label
local maskDim				= 0.17125
local width, height       	= maskDim, maskDim
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_AGL_Label"
HDD001_PFD.material       	= "HDD_AGL_Label"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       	= {0.385 + AGL_shift, AGL_y + 0.015}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range", 1, 0.95, 1.05},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--small box for 4 digits
local maskDim				= 0.17125
local width, height       	= maskDim, maskDim
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_AGL_Box"
HDD001_PFD.material       	= "HDD_AGL_Box"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       	= {0.385 + AGL_shift, AGL_y}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
								"HDD_AGL"
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range", 1, 0.95, 1.05},
								{"parameter_in_range", 2, -1, 10000},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--big box for 5 digits
local maskDim				= 0.17125
local width, height       	= maskDim, maskDim
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_AGL_Box"
HDD001_PFD.material       	= "HDD_AGL_Box_Big"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       	= {0.385 + AGL_shift - 0.03, AGL_y}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
								"HDD_AGL"
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range", 1, 0.95, 1.05},
								{"parameter_in_range", 2, 10000, 50000},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--------------------------------------------------------------------------------------------------------------------------------------------RADALT DISPLAY
Add_Text("HDD_RADALT_VALUE",
		 --"font_PFD_white",
		 "font_HDD_white_mono",
		 "RightCenter",
		 HDD001_PFD_origin.name,
		{--params
			"hdd_001_brightness",
			"HDD_AGL",
		},
		{--controllers
		-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
			{"text_using_parameter", 1, 0},
		},
		{"%.0f"}, {0.008,0.008, 0, 0},
		0.525 + AGL_shift, --initpixelposx
		-AGL_y --initpixelposy
)

--------------------------------------------------------------------------------------------------------------------------------------------Pressure
local pressure_font_size = 0.005
local pressure_x = 0.9
local pressure_value_y = -0.36

--IN HG label
local maskDim				= 0.17125
local width, height       	= maskDim, maskDim
local HDD001_PFD          	= CreateElement "ceTexPoly"
HDD001_PFD.name           	= "HDD001_PRESSURE_LABEL"
HDD001_PFD.material       	= "HDD_ALTPRESS_LBL"
HDD001_PFD.vertices       	= {
							  {-width, height},
							  { width, height},
							  { width,-height},
							  {-width,-height}
						  	}
HDD001_PFD.indices        	= default_box_indices
HDD001_PFD.tex_coords     	= {{0,0},{1,0},{1,1},{0,1}}
HDD001_PFD.init_pos       	= {pressure_x, pressure_value_y - 0.04}
HDD001_PFD.element_params 	= {
								"hdd_001_brightness",
								"HDD001_PFD",
                            }
HDD001_PFD.controllers    	= {
							-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
								{"parameter_in_range", 1, 0.95, 1.05},
                            }
HDD001_PFD.blend_mode     	= blend_mode.IBM_REGULAR_RGB_ONLY
HDD001_PFD.parent_element 	= HDD001_PFD_origin.name
AddElement(HDD001_PFD)

--pressure value
Add_Text("HDD_PRESSURE",
	--"font_PFD_white",
	"font_HDD_white",
	"RightCenter",
	HDD001_PFD_origin.name,
	{--params
		"hdd_001_brightness",
		"QNH_inHg",
	},
	{--controllers
	-- BCont[1],BCont[2],BCont[3],BCont[4],BCont[5],BCont[6],BCont[7],BCont[8],BCont[9],BCont[10],
		{"text_using_parameter", 1, 0},
	},
	{"%.2f"}, {pressure_font_size, pressure_font_size, 0, 0},
	pressure_x, --initpixelposx
	-pressure_value_y --initpixelposy
)