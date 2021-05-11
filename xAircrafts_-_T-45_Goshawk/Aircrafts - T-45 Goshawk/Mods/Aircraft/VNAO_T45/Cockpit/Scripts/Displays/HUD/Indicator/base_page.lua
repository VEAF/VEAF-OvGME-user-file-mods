dofile(LockOn_Options.script_path.."Displays/HUD/Indicator/definitions.lua")

dx=60	-- width of HUD field of view. Align to glass
dy =100	-- Height 
verts = {}
verts [1]= {-dx,-dy}
verts [2]= {-dx,dy}
verts [3]= {dx,dy}
verts [4]= {dx,-dy}


glass 			 	 = CreateElement "ceMeshPoly"
glass.name 			 = "glass"
glass.vertices 		 = verts
glass.indices 		 = {0,1,2, 0,2,3}
glass.init_pos		 = {0, -32, -478}-- in millimeters
glass.init_rot		 =	{0, 0, -44}-- in degrees
glass.material		 =  MakeMaterial(nil,{0,255,0,50})
glass.h_clip_relation = h_clip_relations.REWRITE_LEVEL
glass.level			 = NOCLIP_LEVEL
glass.isdraw		 = true
glass.change_opacity = false
glass.isvisible		 = false	--set to true to help with lining up to glass
Add(glass)

dx=125	-- width of HUD field of view. Align to glass
dy =160	-- Height 
verts2 = {}
verts2 [1]= {-dx,-dy}
verts2 [2]= {-dx,dy}
verts2 [3]= {dx,dy}
verts2 [4]= {dx,-dy}

total_field_of_view 				= CreateElement "ceMeshPoly"
total_field_of_view.name 			= "total_field_of_view"
total_field_of_view.vertices 		= verts2
total_field_of_view.indices			={0,1,2, 0,2,3}
total_field_of_view.init_pos		= {0,-35,0}
total_field_of_view.material		= MakeMaterial(nil,{5,5,5,200})
total_field_of_view.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
total_field_of_view.level			= NOCLIP_LEVEL
total_field_of_view.change_opacity	= false
total_field_of_view.collimated 		= true
total_field_of_view.isvisible		= false
Add(total_field_of_view)