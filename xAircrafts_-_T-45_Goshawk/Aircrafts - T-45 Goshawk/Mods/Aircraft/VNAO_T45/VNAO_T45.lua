local KG_TO_POUNDS  = 2.20462
local POUNDS_TO_KG  = 1/KG_TO_POUNDS
local FEET_TO_M     = 0.3048
local stores ={
	{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}", arg_value = 1 },	-- LAU-68 - 7 2.75' rockets M274 (Practice smoke)
	{ CLSID = "{1F7136CB-8120-4e77-B97B-945FF01FB67C}", arg_value = 1 },	-- LAU-68 - 7 2.75' rockets WTU1B (practice)
	{ CLSID = "{PMBR_6X_BDU-33}",						arg_value = 1 },	-- PMBR 6x BDU-33 practice bombs
}
local launch_bar_connected_arg_value_	= 0.86

T45 = {
	Name			=	'T-45',	
	DisplayName		=	_('T-45'),
	
	shape_table_data 	= {
		{
			file  	    = 'VNAO_T45';
			username    = 'T-45';
			desrt		= 'Fighter-2-crush';
			index       =  WSTYPE_PLACEHOLDER;
			life  	    = 180; --   The strength of the object (ie. lifebar *)
			vis   	    = 5; -- Visibility factor (For a small objects is better to put lower nr).
			fire  	    = { 300, 4}; -- Fire on the ground after destoyed: 300sec 4m
		},
		--[[{
			name  = "VNAO_T45_destr";
			file  = "VNAO_T45_destr";
			fire  = { 240, 2};
		},]]
	},
	mapclasskey			= "P0091000026",-- ref. MissionEditor/data/NewMap/images/themes/nato/P91000026.png  -- gives map symbol R
	Picture				= 'VNAO_T45.png', -- loadout picture
	WorldID				= WSTYPE_PLACEHOLDER,
	attribute 			= {wsType_Air,wsType_Airplane,wsType_Fighter,WSTYPE_PLACEHOLDER,"Fighters","Refuelable"},
	Categories 			= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},
	Rate				= 20, -- multiplayer reward rate
	Countries 			= {"USA"},
	
	-------------------- Aircraft attributes ------------------------------------------------------------------------------
	M_empty										=	10560*POUNDS_TO_KG, -- mass kg
	M_fuel_max									=	2904*POUNDS_TO_KG, -- kg 	427 gal of JP-5:6.8 lb/gal	
	M_max										=	14500*POUNDS_TO_KG, -- kg 
	M_nominal									=	12150*POUNDS_TO_KG, -- kg 
	height										=	13.416*FEET_TO_M,--m
	length										=	39.33*FEET_TO_M,--m
	wing_area									=	16.6891021,--m^2    179.64ft^2
	wing_span									=	30.83*FEET_TO_M,--m
	wing_tip_pos 								= 	{-1.93, 0.25, 4.68},	 -- {forward/back,up/down,left/right}
	wing_type           						=   0,    -- FIXED_WING = 0, VARIABLE_GEOMETRY = 1, FOLDED_WING = 2, VARIABLE_GEOMETRY_FOLDED = 3
	IR_emission_coeff							=	0.3, -- 1.0 is IR emission of Su-27
	IR_emission_coeff_ab						=	0.3,
	RCS											=	3.4, --m^2
	defFuelRatio								=	1.0, -- default fuel amount in fraction of full
	bigParkingRamp								=	false,
	brakeshute_name								=	0,
	has_afteburner								=	false, -- when set to false, a new external noise is present which isnt very pleasent so might as well keep this true
	has_differential_stabilizer					=	false,
	has_speedbrake								=	true,
	tanker_type									=	0, -- 1 boom, 2 probe
	air_refuel_receptacle_pos 					=	{0,0,0},
------------------------ Overwing Vapor -----------------------------------
		effects_presets =   { 
							{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/T45_overwingVapor.lua"},
							},	
------------------------ Gear ---------------------------------------------
	nose_gear_pos 							 = {3.7, -1.86, 0}, -- {forward/back,up/down,left/right}  used for initial aircraft placement
	nose_gear_amortizer_direct_stroke        =  0,	-- down from nose_gear_pos
	nose_gear_amortizer_reversal_stroke      = -0.14,  -- max strut compression up from nose_gear_pos
	nose_gear_amortizer_normal_weight_stroke = -0.05,
	nose_gear_wheel_diameter				 =	0.525, 
	
	tand_gear_max							 =	0.64, -- nosewheel steering angle.  (tan(32.6)=0.64  +/-32 degrees) 
	
	main_gear_pos 							 = {-0.3, -2.18, 1.76},	-- used for initial aircraft placement
	main_gear_amortizer_direct_stroke	     =  0,	--  down from main_gear_pos 
	main_gear_amortizer_reversal_stroke      = -0.48, --   max strut compression up from main_gear_pos 
	main_gear_amortizer_normal_weight_stroke = -0.4,
	main_gear_wheel_diameter				 =	0.67,
------------------------------ AI defs	-----------------------------------
	AOA_take_off								=	0.12,
	CAS_min										=	100,
	Mach_max									=	0.88,
	H_max										=	42500*FEET_TO_M,--max alititude in meters
	Ny_max										=	8,	-- max G for AI
	Ny_max_e									=	8,
	Ny_min										=	-3,	-- min G for AI
	bank_angle_max								=	60,
	V_land										=	65,
	V_max_h										=	300,--m/s
	V_max_sea_level								=	300,--m/s
	V_opt										=	200, -- cruise speed
	V_take_off									=	82,
	Vy_max										=	40,-- climb speed
	range										=	1288,
	flaps_maneuver								=	0.5,
	CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_AVERAGE, LOOK_AVERAGE, LOOK_AVERAGE),
	Sensors = { -- defines what AI is capable of
		nil
	},
	radar_can_see_ground						=	false,
	detection_range_max							=	0,--km range of radar
	thrust_sum_ab								=	5527*POUNDS_TO_KG, --?? kg doesn't seem to affect flight model
	thrust_sum_max								=	5527*POUNDS_TO_KG,
	average_fuel_consumption					=	0.86, -- kg/s TSFC? doesn't seem to affect fuel consumption  	

	launch_bar_connected_arg_value	= launch_bar_connected_arg_value_,	

	LandRWCategories = 	-- adds these takeoff and landing options avaliable in mission editor
    {	[1] = 
        {
           Name = "AircraftCarrier",
        },
		[2] = 
        {
           Name = "AircraftCarrier With Catapult",
        },
		[3] = {
            Name = "AircraftCarrier With Tramplin",
        }, 
    },
	TakeOffRWCategories = 
    {	[1] = {
           Name = "AircraftCarrier",
        },	
		[2] = 
        {
           Name = "AircraftCarrier With Catapult",
        },
		[3] = {
            Name = "AircraftCarrier With Tramplin",
        }, 
    },
	
	crew_size = 2,
	crew_members = {
		[1] =
        {
            ejection_seat_name  = 17,
            drop_canopy_name    = 0, 
            pos 				= {3.1, 0.52, 0}, -- used for ejection location for the seat model to appear. See other view settings for cockpit view
            --canopy_pos = {1.077,    0.674,    0},
			ejection_order      = 2,
			can_be_playable 	= true,
			pilot_body_arg 		= 50,
			role 				= "pilot",
			role_display_name   = _("Pilot"),
			--ejection_through_canopy = true,		
			bailout_arg 		= -1,
			
        }, 
        [2] =
        {
            ejection_seat_name  = 17,
            drop_canopy_name    = 0, 
            pos 				= {1.6,    0.86,    0}, -- pilot ejection position
            --canopy_pos = {1.077,    0.674,    0},
			can_be_playable 	= true,
			ejection_order 		= 1,
			--canopy_arg        = 38,
			pilot_body_arg		= 472,			
			role 				= "instructor",
			role_display_name   = _("Instructor"),
			--ejection_through_canopy = true,
			bailout_arg 		= -1,
        },
	}, 	
	
	stores_number =	3,
	Pylons = {  
		pylon(1, 0, 0.344, 0.189, -0.672,	-- {forward/back,up/down,left/right}
            {
			use_full_connector_position = true, connector = "Pylon_1", arg = 308, arg_value = 0,
            },
            stores
        ),
        pylon(2, 1, 0.344, 0.189, 0,
            {
			use_full_connector_position = true, connector = "Pylon_2", arg = 309, arg_value = 0,
            },
            {
				{ CLSID = "MXU-648-TP",	arg_value = 1},	-- MXU-648 Travel Pod
            }
        ),
        pylon(3, 0, 0.684, 0.281, -4.036,
            {
			use_full_connector_position = true, connector = "Pylon_3", arg = 310, arg_value = 0,
            },
            stores
        ),
		
		--[[ -- uncomment for smoke generators
		pylon(4, 2, -5.1, 0.304, -0.15,
            {
				connector = "disable", DisplayName = _("SMK")
            },
            {
				{CLSID = "{INV-SMOKE-RED}"},	--Smoke Generator - red
				{CLSID = "{INV-SMOKE-GREEN}"},	--Smoke Generator - green
				{CLSID = "{INV-SMOKE-BLUE}"},	--Smoke Generator - blue
				{CLSID = "{INV-SMOKE-WHITE}"},	--Smoke Generator - white
				{CLSID = "{INV-SMOKE-YELLOW}"},	--Smoke Generator - yellow
				{CLSID = "{INV-SMOKE-ORANGE}"},	--Smoke Generator - orange
            }
        ),
		--]]
	},
	
	Tasks = { -- defined in db_units_planes.lua
		aircraft_task(GroundAttack),
		aircraft_task(Reconnaissance),
		aircraft_task(AFAC),
	},
	DefaultTask =  aircraft_task(Reconnaissance),
	
--[[
	Damage = verbose_to_dmg_properties( --index meaning see in Scripts\Aircrafts\_Common\Damage.lua
	{
		["NOSE_CENTER"]				= {args = {146}, critical_damage = 3, deps_cells = {"NOSE_CENTER"}},-- NOSE_CENTER
		["NOSE_BOTTOM"]				= {args = {148}, critical_damage = 3},-- NOSE_BOTTOM
		["NOSE_LEFT_SIDE"]			= {args = {296}, critical_damage = 3},-- NOSE_LEFT_SIDE
		["NOSE_RIGHT_SIDE"]			= {args = {297}, critical_damage = 3},-- NOSE_RIGHT_SIDE

		--["STABILIZER_L_IN"]			= {args = {240}, critical_damage = 2},-- STABILIZER_L_IN
		["STABILIZER_R_IN"]			= {args = {238}, critical_damage = 2},-- STABILIZER_R_IN
		
	}),-- end of Damage
--]]
	DamageParts = { -- parts that fall off when aircraft is hit/damaged
			--[1] = "_wing_R",  -- wing right
			--[2] = "_wing_R",  -- wing left
			--[3] = "_nose",    -- nose part
			--[4] = "_tail",    -- tail part
	},

	SFM_Data ={
		aerodynamics = -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
        {
            Cy0         = 0.0,      -- zero AoA lift coefficient
            Mzalfa      = 3.9,      -- coefficients for pitch agility  4.2
            Mzalfadt    = 0.6,      -- coefficients for pitch agility
            kjx         = 3.75,      -- Inertia parametre X - Dimension (clean) airframe drag coefficient at X (Top) Simply the wing area in square meters (as that is a major factor in drag calculations) - smaller = massive inertia
            kjz         = 0.00125,  -- Inertia parametre Z - Dimension (clean) airframe drag coefficient at Z (Front) Simply the wing area in square meters (as that is a major factor in drag calculations)
            Czbe        = -0.016,   -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
            cx_gear     = 0.05,     -- coefficient, drag created by gear
            cx_flap     = 0.07,     -- coefficient, drag created by flaps
            cy_flap     = 0.20,   -- coefficient, lift created by flaps  
            cx_brk      = 0.08,     -- coefficient, drag speedbrake 

            table_data = {
            --       M       Cx0        Cya      B      B4          Omxmax      Aldop       Cymax
                    {0.00,   0.0140,    0.087,   0.149,  0.00,         0.25,    29.91,      1.50, },
                    {0.15,   0.0140,    0.087,   0.149,  0.00,         0.75,     23.91,      1.55, },   -- 20 degree slat extension at sea level
                    {0.30,   0.0110,    0.061,   0.149,  0.00,         1.75,     23.91,      1.60, },   -- 0 degree slat extension at sea level
                    {0.40,   0.0110,    0.060,   0.149,  0.00,         2.75,    25.91,      1.5, },
                    {0.48,   0.0110,    0.060,   0.149,  0.00,         3.25,     26.91,      1.35, },
                    {0.50,   0.0110,    0.060,   0.149,  0.00,         4.5,     18.34,      1.20, },
                    {0.55,   0.0110,    0.060,   0.149,  0.00,         4.65,    16.91,      1.06, },
                    {0.60,   0.0120,    0.060,   0.149,  0.00,         4.65,     16.33,      1.01, },
                    {0.65,   0.0150,    0.061,   0.149,  0.00,         5.2,     18.63,      0.99, },
                    {0.70,   0.0160,    0.062,   0.149,  0.00,         4.3,     23.21,      0.98, },
                }
            -- M - Mach number
            -- Cx0 - Coefficient, drag, profile, of the airplane
            -- Cya - Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
            -- B2 - Polar 2nd power coeff
            -- B4 - Polar 4th power coeff
            -- Omxmax - roll rate, rad/s
            -- Aldop - Alfadop Max AOA at current M - departure threshold
            -- Cymax - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)
        }, -- end of aerodynamics
		engine =
		{
			Nmg		=	55,		-- RPM at idle
			MinRUD	=	0,	-- Min state of the throttle
			MaxRUD	=	1,
			MaksRUD	=	1,	-- Military power state of the throttle
			ForsRUD	=	1.1,	-- Afterburner state of the throttle
			type	=	"TurboFan",
			hMaxEng	=	12.950,		-- Max altitude for safe engine operation in km
			dcx_eng	=	0.012,	-- Engine drag coeficient
			cemax	=	0.037,	-- kg/s not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			cefor	=	0.037,	-- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			dpdh_m	=	4000,	--  altitude coefficient for max thrust.  Higher value means altitude decreases thrust more (which also decreases fuel consumption)
			dpdh_f	=	4000,	--  altitude coefficient for AB thrust

			table_data =
            {--   M 	Pmax	Pafb
                {0.0,   25685,	25685}, 
				{0.1,   24730,	24730}, 
				{0.175, 23030,	23030}, 
				{0.25,  22028,	22028}, 
				{0.325, 21512,	21512}, 
				{0.425, 21326,	21326}, 
				{0.5,   21498,	21498}, 
				{0.575, 21556,	21556}, 
				{0.65,  21406,	21406}, 
                {1.0,   20036,	20036},
            },
			-- M - Mach number
			-- Pmax - Engine thrust at military power in Newtons
			-- Pafb - Engine thrust at AFB
		}, -- end of engine
	},
	
	engines_count	=	1,
	engines_nozzles ={
		[1] =
		{
			pos =     {-5.9,  0.163, 0}, -- nozzle coords
            elevation    =    0.0, -- AFB cone elevation
            diameter    =    0.4, -- AFB cone diameter
            exhaust_length_ab    =    3, -- lenght in m
            exhaust_length_ab_K    =    0.607, -- AB animation
            smokiness_level     =     0.10,
		},
	},
	
	fires_pos = {
		[1] = 	{0.048,	1.008,	0},-- Fuselage
		[2] = 	{0.048,	1.008,	2.322},-- wing inner right
		[3] = 	{0.048,	1.008,	-2.322},-- wing inner left
		[4] = 	{-0.82,	0.265,	2.774},-- Wing center Right
		[5] = 	{-0.82,	0.265,	-2.774},-- Wing center Left
		[6] = 	{-0.82,	0.255,	4.274},-- Wing outer Right
		[7] = 	{-0.82,	0.255,	-4.274},-- Wing outer Left
		[8] = 	{-0.267,	0.054,	3.293},-- engine contrail positions, engines 1?
		[9] = 	{-0.267,	0.054,	-3.293},-- engine 2?
		[10] = 	{-0.267,	0.054,	3.293},
		[11] = 	{-0.267,	0.054,	-3.293},
	}, 

	net_animation = -- transmit animations over network (multiplayer)
	{
          0, -- nose gear
		1, -- nose suspension
		2, -- nose wheel steering
        3, -- right gear
		4, -- right suspension
        5, -- left gear
		6, -- left suspension
        9, -- right flap
        10, -- left flap
        11, -- right aileron
        12, -- left aileron
        13, -- right slat
        14, -- left slat
        15, -- right elevator
        16, -- left elevator
        17, -- rudder
        25, -- tail hook
        38, -- canopy
		50, -- ejection seat, pilot and instructor ejection vis
		60, -- RAT Doors
		61, -- RAT Propeller
		76, -- nose wheel turn
		77, -- main gear turn
		85, -- launch bar
		102, -- right main wheel rotation
		103, -- left main wheel rotation
		189, -- launch bar
		190, -- launch bar
		191, -- launch bar
		192, -- launch bar
		193, -- launch bar
		194, -- launch bar
		195, -- launch bar
		196, -- AoA Indexer
		197, -- AoA Indexer		
		198, -- AoA Indexer
		337, -- instructor look left/right
		399, -- instructor look up/down
		472, -- instructor vis
		500, --  air brake
		501, -- eject canopy glass
	},
--
	mechanimations = {
		Door0 = {
			--{Transition = {"Open", "Bailout"},Sequence = {{C = {{"TearCanopy", 0}, {"Arg", 501, "set", 1.0},},},},},
			--{Transition = {"Taxi", "Bailout"},Sequence = {{C = {{"TearCanopy", 0}, {"Arg", 501, "set", 1.0},},},},},
			{Transition = {"Any", "Bailout"}, Sequence = {{C = {{"Origin", "x", 3.458, "y", 0.703, "z", 0.0}, {"Impulse", 1, "tertiary", 1.0}, {"Impulse", 2, "tertiary", 10.5}, {"Sleep", "for", 0.005},},}, {C = {{"Arg", 501, "set", 1.0},},},},},
			--{Transition = {"Any", "Bailout"}, Sequence = {{C = {{"TearCanopy", 0}}}, {C = {{"Sleep", "for", 0.275}}}, {C = {{"Arg", 501, "set", 1.0}}}}},
		},
        LaunchBar = {
            {Transition = {"Retract", "Extend"}, Sequence = {{C = {{"ChangeDriveTo", "HydraulicGravityAssisted"}, {"VelType", 3}, {"Arg", 85, "to", 0.99, "in", 4.4}}}}},
            {Transition = {"Retract", "Stage"},  Sequence = {{C = {{"ChangeDriveTo", "HydraulicGravityAssisted"}, {"VelType", 3}, {"Arg", 85, "to", launch_bar_connected_arg_value_, "in", 4.4}}}}},
            {Transition = {"Any", "Retract"},  Sequence = {{C = {{"ChangeDriveTo", "Hydraulic"}, {"VelType", 2}, {"Arg", 85, "to", 0.000, "in", 4.5}}}}},
            {Transition = {"Extend", "Stage"},   Sequence = {
                    {C = {{"ChangeDriveTo", "Mechanical"}, {"Sleep", "for", 0.000}}},
                    {C = {{"Arg", 85, "from", 0.9, "to", 0.72, "in", 0.600}}},
                    {C = {{"Arg", 85, "from", 0.72, "to", 0.76, "in", 0.300}}},
                    {C = {{"Sleep", "for", 0.45}}},
                    {C = {{"Arg", 85, "from", 0.76, "to", .81, "in", 0.1, "sign", 2}}},
                    {C = {{"Arg", 85, "from", 0.81, "to", launch_bar_connected_arg_value_, "in", 1.0}}},
                    },
            },
            {Transition = {"Stage", "Pull"},  Sequence = {
                    {C = {{"ChangeDriveTo", "Mechanical"}, {"VelType", 2}, {"Arg", 85, "to", launch_bar_connected_arg_value_, "in", 0.15}}},
                    {C = {{"ChangeDriveTo", "Mechanical"}, {"VelType", 2}, {"Arg", 85, "to", 0.92, "speed", 0.1}}},
                    {C = {{"ChangeDriveTo", "Mechanical"}, {"VelType", 2}, {"Arg", 85, "to", 0.92, "speed", 0.02}}},
                    }
            },
            {Transition = {"Stage", "Extend"},   Sequence = {{C = {{"ChangeDriveTo", "HydraulicGravityAssisted"}, {"VelType", 3}, {"Arg", 85, "from", launch_bar_connected_arg_value_, "to", .94, "in", 0.2}}}}},
        },
		FoldableWings = {-- necessary for AI to not get stuck at end of cat launch
            {Transition = {"Retract", "Extend"}, Sequence = {{C = {{"Arg", 85, "to", 0.0, "in", 5.0}}}}, Flags = {"Reversible"}},
            {Transition = {"Extend", "Retract"}, Sequence = {{C = {{"Arg", 85, "to", 1.0, "in", 5.0}}}}, Flags = {"Reversible", "StepsBackwards"}},
        },
    },
	
	Failures = {nil
	--[[
			-- electric system
			{ id = 'esf_LeftGenerator',			label = _('Electricity: Left Generator'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'esf_RightGenerator',		label = _('Electricity: Right Generator'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'esf_LeftRectifier',			label = _('Electricity: Left Rectifier'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'esf_RightRectifier',		label = _('Electricity: Right Rectifier'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'esf_StaticInverter',		label = _('Electricity: Static Inverter'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			-- fuel system
			{ id = 'fsf_AutoBalance',			label = _('Fuel System: Fuel Autobalance'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'fsf_LeftBoostPump',			label = _('Fuel System: Left Fuel Boost Pump'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'fsf_RightBoostPump',		label = _('Fuel System: Right Fuel Boost Pump'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'fsf_CrossfeedValve',		label = _('Fuel System: Crossfeed Valve'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			-- hydraulic system
			{ id = 'hsf_UtilityHydraulic',		label = _('Hydraulic: Utility Hydraulic System'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'hsf_ControlHydraulic',		label = _('Hydraulic: Flight Control Hydraulic System'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			-- control system
			{ id = 'csf_PitchDamper',			label = _('Control: Pitch Damper'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'csf_YawDamper',				label = _('Control: Yaw Damper'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'csf_PitchTrim',				label = _('Control: Pitch Trim'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'csf_AutoFlap',				label = _('Control: Auto Flap System'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			-- sensors system
			{ id = 'sensf_CADC',				label = _('Sensors: Central Air Data Computer'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'sensf_PITOT_DAMAGE',		label = _('Sensors: Pitot-static System Leakage'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			-- power plant
			{ id = 'ppf_LeftGearbox',			label = _('Power Plant: Left Gearbox'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ppf_RightGearbox',			label = _('Power Plant: Right Gearbox'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ppf_FireLeft',				label = _('Power Plant: Fire Left Engine'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ppf_FireRight',				label = _('Power Plant: Fire Right Engine'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ppf_LeftNozzleControl',		label = _('Power Plant: Left Nozzle Control System'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ppf_RightNozzleControl',	label = _('Power Plant: Right Nozzle Control System'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ppf_LeftOil',				label = _('Power Plant: Left Oil System'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ppf_RightOil',				label = _('Power Plant: Right Oil System'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			-- oxygen system
			{ id = 'oxy_FAILURE_TOTAL',			label = _('Oxygen System: Total Failure'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			--]]
		},

	HumanRadio 	={
        frequency     = 305.0,
        editable     = true,
        minFrequency     = 30.000,
        maxFrequency     = 399.975,
		rangeFrequency = {
			{min = 30.0,  max = 87.975},
			{min = 108.0, max = 173.975},
			{min = 225.0, max = 399.975},
		},
        modulation     = MODULATION_AM
	},
	
	panelRadio = {
			[1] = {  
				name = _("VHF/UHF AN/ARC-182"),
				range = {{min = 30.0, max = 87.975},
					 {min = 108.0, max = 173.975},
					 {min = 225.0, max = 399.975}},
				channels = {
                [1] = { name = _("Channel 1"), default = 225.0, connect = true}, -- default
                [2] = { name = _("Channel 2"), default = 258.0},
                [3] = { name = _("Channel 3"), default = 260.0},-- batumi : 131.0, 260.0
                [4] = { name = _("Channel 4"), default = 270.0},-- beslan : 141.0, 270.0
                [5] = { name = _("Channel 5"), default = 255.0},-- gelenjik : 126.0, 255.0
                [6] = { name = _("Channel 6"), default = 259.0},-- gudauta : 130.0, 259.0
                [7] = { name = _("Channel 7"), default = 262.0},-- kabuleti : 133.0, 262.0
                [8] = { name = _("Channel 8"), default = 257.0},-- krasnodar-pashk. : 128.0, 257.0
                [9] = { name = _("Channel 9"), default = 253.0},-- krymsk : 124.0, 253.0
                [10] = { name = _("Channel 10"), default = 263.0},-- kutaisi : 134.0, 263.0
                [11] = { name = _("Channel 11"), default = 267.0},	-- lochini : 138.0, 267.0
                [12] = { name = _("Channel 12"), default = 254.0},-- maykop : 125.0, 254.0
                [13] = { name = _("Channel 13"), default = 264.0},-- min. water : 135.0, 264.0
                [14] = { name = _("Channel 14"), default = 266.0},-- mozdok : 137.0, 266.0
                [15] = { name = _("Channel 15"), default = 265.0},-- nalchik : 136.0, 265.0
                [16] = { name = _("Channel 16"), default = 252.0},
                [17] = { name = _("Channel 17"), default = 268.0},-- soginlug : 139.0, 268.0
                [18] = { name = _("Channel 18"), default = 269.0},-- vaziani : 140.0, 269.0
                [19] = { name = _("Channel 19"), default = 268.0},
                [20] = { name = _("Channel 20"), default = 269.0},
                [21] = { name = _("Channel 21"), default = 225.0},
                [22] = { name = _("Channel 22"), default = 258.0},
                [23] = { name = _("Channel 23"), default = 260.0},
                [24] = { name = _("Channel 24"), default = 270.0},
                [25] = { name = _("Channel 25"), default = 255.0},
                [26] = { name = _("Channel 26"), default = 259.0},
                [27] = { name = _("Channel 27"), default = 262.0},
                [28] = { name = _("Channel 28"), default = 257.0},
                [29] = { name = _("Channel 29"), default = 253.0},
                [30] = { name = _("Channel 30"), default = 263.0},
				
				}
			},
		},

	lights_data ={
		typename =	"collection",
		lights 	 = 
		{
			[1]	= {typename	=	"collection", -- strobe
					lights = {	{typename = "argnatostrobelight", argument_1 = 191, period = 1.2, phase_shift = 0},	-- strobe light top
								--[2] = {typename = "natostrobelight", argument_1 = 192, period = 1.2, phase_shift = 0, connector = "STROBE2",color = {0.8,0,0}},	-- beacon light bottom
					},
			},
			[2]	= {typename = "collection", -- spot
					lights = {	{typename  = "argumentlight",	argument  = 189},
					},
			},
			[3]	= {typename = "collection", -- nav
					lights = {	{typename  = "argumentlight",	argument  = 190}, -- wing tips
								{typename  = "argumentlight",	argument  = 193}, -- tail
					},
			},
			[4]	= {typename = "collection", -- formation
					lights = {	-- {typename  = "argumentlight",	argument  = 88},		-- formation lights
					},
			},
			[5] = {}, -- tips
            [6] = {}, -- refuel
            [7] = {},  -- Anti-Collision
		}, -- end of lights
	},-- end of lights_data
	
	AddPropAircraft = {
		{id = "SoloFlight", control = 'checkbox' , label = _('Solo Flight'), defValue = false, weightWhenOn = -80},
		{id = "NetCrewControlPriority" , control = 'comboList', label = _('Aircraft Control Priority'), playerOnly = true,
		  values = {{id =  0, dispName = _("Pilot")},
					{id =  1, dispName = _("Instructor")},
					{id = -1, dispName = _("Ask Always")},
					{id = -2, dispName = _("Equally Responsible")}},
		  defValue  = -2,
		  wCtrl     = 150
		},
	},
}
add_aircraft(T45)