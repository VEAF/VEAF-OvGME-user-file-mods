local self_ID = "T-45"
declare_plugin(self_ID,
{
dirName			= current_mod_path,
displayName		= _("VNAO T-45 Goshawk"),
fileMenuName	= _("T-45"),
--version 		= "0.76",
state			= "installed",
developerName	= _("VNAO  |  Particleman"),
info			= _("VNAO T-45 Goshawk, Navy jet trainer."),
encyclopedia_path = current_mod_path..'/Encyclopedia',

binaries	 =
{ 
'VNAOT45FM',
},
Skins =
{
	{
		name	= "T-45",
		dir		= "Theme"
	},
},
Missions =
{
	{
		name	= _("T-45"),
		dir		= "Missions",
	},
},
LogBook =
{
	{
		name	= _("T-45"),
		type	= "T-45",
	},
},
--[[Options =
{
	{
		name		= _("T-45"),
		nameId		= "VNAO_T45",
		dir			= "Options",
		CLSID		= "{VNAO_T45 options}"
	},
},]]
InputProfiles = 
{
	["T-45"]		= current_mod_path .. '/Input',	
},

})

mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/t45_textures")
mount_vfs_texture_path  (current_mod_path.."/Textures/t45_ejection_seat")
mount_vfs_texture_path  (current_mod_path.."/Textures/t45_pilots")
mount_vfs_texture_path  (current_mod_path.."/Cockpit/AvionicsTextures")
mount_vfs_texture_path  (current_mod_path.."/Theme/ME")

dofile(current_mod_path..'/Weapons/VNAO_T45_Weapons.lua')
dofile(current_mod_path..'/UnitPayloads/VNAO_T45_Payloads.lua')
dofile(current_mod_path..'/VNAO_T45.lua')
dofile(current_mod_path..'/Views.lua')
make_view_settings('T-45', ViewSettings, SnapViews)

local FM =
{
	[1] = self_ID,
	[2] = "VNAOT45FM", -- name of dll
	center_of_mass 	  = {0.0, 0.0, 0.0},  -- center of mass position relative to object 3d model center for empty aircraft  -- {forward/back,up/down,left/right} 
	moment_of_inertia = {10247, 28268.8, 30032.72, 300}, -- moment of inertia of empty (Ix,Iy,Iz,Ixy)	in kgm^2 
	
	suspension 			= {
		{ -- NOSE WHEEL
			pos = {3.7, -1.855, 0},
			damage_element					= 83,
			wheel_axle_offset				= 0.08,
			self_attitude					= false,
			yaw_limit						= math.rad(65.0), -- doesn't appear to affect steering angle
			moment_limit					= 750.0,
			damper_coeff					= 300.0,
			filter_yaw						= false,
			influence_of_pos_z_to_V_l_z		= false,

			amortizer_min_length					= 0.0,
			amortizer_max_length					= 0.195,	-- total suspension distance
			amortizer_basic_length					= 0.195,	-- absorber + tire
			amortizer_spring_force_factor			= 5e10,-- force = amortizer_spring_force_factor * pow(amortizer_reduce_length, amortizer_spring_force_factor_rate)
			amortizer_spring_force_factor_rate		= 9,
			amortizer_static_force					= 10000.0,
			amortizer_reduce_length					= 0.14,
			amortizer_direct_damper_force_factor	= 40000,
			amortizer_back_damper_force_factor		= 20000,
			allowable_hard_contact_length			= 0.1,

			anti_skid_installed = false,

			wheel_radius					= 0.2625,
			wheel_static_friction_factor	= 0.85, -- friction when not moving
			wheel_glide_friction_factor		= 0.35, -- sliding aircraft
			wheel_side_friction_factor		= 0.75,
			wheel_roll_friction_factor		= 0.1, -- rolling friction when wheel moving
			wheel_damage_force_factor		= 450.0, -- hard landing force
			wheel_kz_factor					= 0.3,
			noise_k							= 0.2,
			wheel_damage_speedX				= 97.5,
			wheel_damage_delta_speedX		= 11.5,

			arg_post			= 0,
			arg_amortizer		= 1,
			arg_wheel_yaw		= 2,
			arg_wheel_rotation	= 76,
			arg_wheel_damage	= 135
		},
		{ -- LEFT WHEEL
			pos = {-0.3, -2.14, -1.76},
			damage_element							= 3,

			amortizer_min_length					= 0.0,
			amortizer_max_length					= 0.37,	-- absorber + tire
			amortizer_basic_length					= 0.37,	-- absorber + tire
			amortizer_spring_force_factor			= 350e6, -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
			amortizer_spring_force_factor_rate		= 9,
			amortizer_static_force					= 10000.0,
			amortizer_reduce_length					= 0.28,
			amortizer_direct_damper_force_factor	= 40000.0, 
			amortizer_back_damper_force_factor		= 20000.0,
			
			allowable_hard_contact_length			= 0.1,

			--amortizer_spring2_max_length					= 0.20565,
			--amortizer_spring2_basic_length					= 0.20565,
			--amortizer_spring2_spring_force_factor			= 1500000.0, -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
			--amortizer_spring2_spring_force_factor_rate		= 1.5,
			--amortizer_direct_damper2_force_factor			= 300000.0,
			--amortizer_back_damper2_force_factor				= 150000.0,

			anti_skid_installed = true,

			crossover_locked_wheel_protection			= true,
			crossover_locked_wheel_protection_wheel		= 1,
			crossover_locked_wheel_protection_speed_min	= 18.0,
			anti_skid_improved							= true,
			anti_skid_gain								= 200.0,

			wheel_radius					= 0.325,
			wheel_static_friction_factor	= 0.95,
			wheel_side_friction_factor		= 0.65,
			wheel_roll_friction_factor		= 0.09,
			wheel_glide_friction_factor		= 0.4,
			wheel_damage_force_factor		= 450.0,
			wheel_brake_moment_max			= 5000.0,
			wheel_kz_factor					= 0.25,
			noise_k							= 0.4,
			wheel_damage_speedX				= 108,
			wheel_damage_delta_speedX		= 15,

			arg_post			= 5,
			arg_amortizer		= 6,
			arg_wheel_rotation	= 103,
			--arg_wheel_damage	= 136
		},
		{  -- RIGHT WHEEL
			pos = {-0.3, -2.14, 1.76},
			damage_element							= 5,

			amortizer_min_length					= 0.0,
			amortizer_max_length					= 0.37,	-- absorber + tire
			amortizer_basic_length					= 0.37,	-- absorber + tire
			amortizer_spring_force_factor			= 350e6, -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
			amortizer_spring_force_factor_rate		= 9,
			amortizer_static_force					= 10000.0,
			amortizer_reduce_length					= 0.28,
			amortizer_direct_damper_force_factor	= 40000.0, 
			amortizer_back_damper_force_factor		= 20000.0,
			
			allowable_hard_contact_length			= 0.1,

			--amortizer_spring2_max_length					= 0.20565,
			--amortizer_spring2_basic_length					= 0.20565,
			--amortizer_spring2_spring_force_factor			= 1500000.0, -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
			--amortizer_spring2_spring_force_factor_rate		= 1.5,
			--amortizer_direct_damper2_force_factor			= 300000.0,
			--amortizer_back_damper2_force_factor				= 150000.0,

			anti_skid_installed = true,

			crossover_locked_wheel_protection			= true,
			crossover_locked_wheel_protection_wheel		= 1,
			crossover_locked_wheel_protection_speed_min	= 18.0,
			anti_skid_improved							= true,
			anti_skid_gain								= 200.0,

			wheel_radius					= 0.325,
			wheel_static_friction_factor	= 0.95,
			wheel_side_friction_factor		= 0.65,
			wheel_roll_friction_factor		= 0.09,
			wheel_glide_friction_factor		= 0.4,
			wheel_damage_force_factor		= 450.0,
			wheel_brake_moment_max			= 5000.0,
			wheel_kz_factor					= 0.25,
			noise_k							= 0.4,
			wheel_damage_speedX				= 108,
			wheel_damage_delta_speedX		= 15,

			arg_post			= 3,
			arg_amortizer		= 4,
			arg_wheel_rotation	= 102,
			--arg_wheel_damage	= 136
		},
	},
	disable_built_in_oxygen_system	= false,
}

make_flyable('T-45', current_mod_path..'/Cockpit/Scripts/',FM, current_mod_path..'/comm.lua')
plugin_done()
