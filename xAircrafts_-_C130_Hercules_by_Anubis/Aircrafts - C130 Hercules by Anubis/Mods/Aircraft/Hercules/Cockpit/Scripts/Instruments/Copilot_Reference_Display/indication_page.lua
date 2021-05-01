dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetScale(FOV)

DISPLAY_DEFAULT_LEVEL = 4

						

function Add_Object_Text(object, objectname, objectparent, objectmaterial, objectalignment, format_value, stringdefs_value, initpixelposx, initpixelposy, objectelementparams, objectcontrollers)
	local object           = CreateElement "ceStringPoly"
	object.name            = objectname
	object.material        = objectmaterial
	object.element_params = objectelementparams
	object.controllers = objectcontrollers
	object.init_pos = {(0.003333 * initpixelposx) - 1, ((-0.005 * initpixelposy) + 1) * GetAspect()}
	object.alignment		= objectalignment
	if format_value ~= nil then
		if type(format_value) == "table" then
			object.formats = format_value
		else
			object.value = format_value
		end
	end
	object.stringdefs		= stringdefs_value--VerticalSize, HorizontalSize, HorizontalSpacing, VerticalSpacing
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.collimated		= false
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= DISPLAY_DEFAULT_LEVEL
	object.parent_element = objectparent
    Add(object)
end

local COPILOT_RefAirspeedVal_origin	         = CreateElement "ceSimple"
COPILOT_RefAirspeedVal_origin.name 		     = "COPILOT_RefAirspeedVal_origin"
COPILOT_RefAirspeedVal_origin.init_pos        = {0,0}
COPILOT_RefAirspeedVal_origin.use_mipfilter    = true
COPILOT_RefAirspeedVal_origin.additive_alpha   = true
COPILOT_RefAirspeedVal_origin.h_clip_relation  = h_clip_relations.COMPARE
COPILOT_RefAirspeedVal_origin.level			= DISPLAY_DEFAULT_LEVEL
Add(COPILOT_RefAirspeedVal_origin)

Add_Object_Text(COPILOT_RefAirspeedVal, "COPILOT_RefAirspeedVal", COPILOT_RefAirspeedVal_origin.name,
					"font_Arial_green",--objectmaterial
					"LeftCenter",--objectalignment
					{"%.0f"},--format_value
					{0.010,0.010,  -0.0042, 0},--stringdefs_value
					160.0,--initpixelposx
					200.0,--initpixelposy
					{--params
						"COPILOT_RefAirspeedVal",
						-- "FlatscreenBrightness",
					},
					{--controllers
						{"text_using_parameter",0,0},
						-- {"opacity_using_parameter",1},
					}
				)

-- local REFSETAltitude002_origin	         = CreateElement "ceSimple"
-- REFSETAltitude002_origin.name 		     = "REFSETAltitude002_origin"
-- REFSETAltitude002_origin.init_pos        = {0,0}
-- REFSETAltitude002_origin.element_params   = {
								-- "COPILOT_REF_MODE",
										   -- } 
-- REFSETAltitude002_origin.controllers 	   = {
								-- {"parameter_in_range",0,1.1874,1.1876},
								-- }
-- AddElement(REFSETAltitude002_origin)

-- Add_Object_Text(REFSETAltitude002, "REFSETAltitude002", "REFSETAltitude002_origin",
					-- "font_Arial_green",--objectmaterial
					-- "RightCenter",--objectalignment
					-- {"%.0f"},--format_value
					-- {0.010,0.010,  -0.0042, 0},--stringdefs_value
					-- 0.9,--initpixelposx
					-- 0,--initpixelposy
					-- {--params
						-- "COPILOT_HudRefAltitudeCaretVal",
						-- "FlatscreenBrightness",
					-- },
					-- {--controllers
						-- {"text_using_parameter",0,0},
						-- {"opacity_using_parameter",1},
					-- }
				-- )

































