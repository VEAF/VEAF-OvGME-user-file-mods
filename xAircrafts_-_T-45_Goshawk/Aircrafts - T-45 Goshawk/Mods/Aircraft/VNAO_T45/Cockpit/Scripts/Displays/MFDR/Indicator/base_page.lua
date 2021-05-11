dofile(LockOn_Options.script_path.."Displays/MFDDefs.lua")

local screen = MakeMaterial(nil,{4,4,4,100})

verts = {}
verts [1]= {-MFDHalfSize,-MFDHalfSize}
verts [2]= {-MFDHalfSize,MFDHalfSize}
verts [3]= {MFDHalfSize,MFDHalfSize}
verts [4]= {MFDHalfSize,-MFDHalfSize}

base 			 	 = CreateElement "ceMeshPoly"
base.name 			 = "base"
base.vertices 		 = verts
base.indices 		 = {0,1,2, 0,2,3}
base.material		 = screen
base.h_clip_relation = h_clip_relations.REWRITE_LEVEL 
base.level			 = NOCLIP_LEVEL 
base.isdraw			 = true
base.change_opacity  = false
base.isvisible		 = false
Add(base)


background					= CreateElement "ceMeshPoly"
background.name			 	= "background"
background.primitivetype 	= "triangles"
background.vertices 		= verts
background.indices			= {0,1,2, 0,2,3}
background.material			= screen
background.element_params 	= {"MFDR_ONOFF","MFDR_BRIGHTNESS"} 
background.controllers   	= {{"parameter_in_range",0,1},{"opacity_using_parameter",1}}
background.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL  
background.level			= NOCLIP_LEVEL   
background.change_opacity	= false
background.isvisible		= true
Add(background)

