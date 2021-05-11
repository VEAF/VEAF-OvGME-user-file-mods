dofile(LockOn_Options.script_path.."Displays/MFDDefs.lua")

local origin	         = CreateElement "ceSimple"
origin.name 		     = "menu_origin"
origin.element_params 	 = {"MFDR_ONOFF","MFDR_PAGE"} 
origin.controllers   	 = {{"parameter_in_range",0,1},{"parameter_in_range",1,MENUPage}}
Add(origin)

-------- Left side ---------
addOBLabel("STRSlabel", OB20pos, "S\nT\nR\nS", origin.name)
addOBLabel("VREClabel", OB19pos, "V\nR\nE\nC", origin.name)
	addCrossout("VRECX", "VREClabel")
addOBLabel("HUDlabel", OB18pos, "H\nU\nD", origin.name)
addOBLabel("HSIlabel", OB17pos, "H\nS\nI", origin.name)
addOBLabel("ADIlabel", OB16pos, "A\nD\nI", origin.name)

-------- Right side --------
addOBLabel("ENGlabel", OB7pos, "E\nN\nG", origin.name)
addOBLabel("TRNGlabel", OB9pos, "T\nR\nN\nG", origin.name)
	addCrossout("TRNGX", "TRNGlabel")
--------- Top ------------
addOBLabel("BITlabel", OB3pos, "BIT", origin.name)
	addCrossoutHorz("BITX", "BITlabel")
	
--------- Bottom ----------
addOBLabel("DATAlabel", OB14pos, "DATA", origin.name)

local MENUlabel          = CreateElement "ceStringPoly"
MENUlabel.name           = create_guid_string()
MENUlabel.material       = display_font	
MENUlabel.alignment      = "CenterCenter"
MENUlabel.init_pos		 = {0,verticalPos(-94)}
MENUlabel.stringdefs     = {0.0035, 0.0035, 0, 0}  -- {size vertical, horizontal, 0, spacing}
MENUlabel.formats        = {"%s"} 
MENUlabel.value			 = "MENU"
MENUlabel.element_params = {"MFDR_ONOFF"} 
MENUlabel.controllers    = {{"parameter_in_range",0,1}}
AddElement(MENUlabel)

