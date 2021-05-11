-- View scripts 
-- Copyright (C) 2004, Eagle Dynamics.

-- Global view configuration
-- Update for DCS 1.5.3
local gEyePoint                 = {0.05, 0.08, 0.00}                    -- Front/back, up/down, lef/right {0.08, 0.10, 0.00} {0.16, 0.1}
local gCameraViewAngleLimits    = {20.000000, 100.000000}               -- Field of view, zoom min and max. consider setting it so that min + (max-min)/2 = default viewAngle (index 13) from snap views. This will result in the default zoom being located in the midle position of the zoom slider, for instance on the TM W . Note that Mi-8 is an exception from this rule as it uses a "Max FOV adjustment" from "Special" to override the max value. Setting max value to default FOV - viewAngle from SnapViews will remove the zoom-out effect at cokpit enter.
local gCameraAngleLimits        = {200.000000, -90.000000, 90.000000}   -- Maximum head movement angles: left/right, down, up. Not applicable for Mi-8
local gShoulderSize             = 0.25                                  -- 0.25 Shift head left/right when view angle is more than 90 degrees 

-- ORIGINAL VALUES from "default_fighter_player"
-- CameraViewAngleLimits		= {50.000000,140.000000},
-- CameraAngleRestriction		= {false	   ,90.000000,0.500000},
-- Allow360rotation				= false,
-- CameraAngleLimits			= {200,-80.000000,110.000000},
-- ShoulderSize					= 0.25,  -- move body when azimuth value more then 90 degrees

--DisableCombatViews				= false -- F5 & Ctrl-F5
--ExternalObjectsLockDistance 	= 10000.0
--ShowTargetInfo 					= false
--CameraTerrainRestriction 		= true
--hAngleRearDefault 				=  180
--vAngleRearDefault 				= -8.0
--vAngleRearMin    				= -90 -- -8.0
--vAngleRearMax    				= 90.0

--dbg_shell    = "weapons.shells.PKT_7_62_T" -- 23mm shell
-- dbg_shell    = "weapons.shells.2A64_152" -- 152mm shell
--dbg_shell_v0 = -1 -- Muzzle speed m/s (-1 - speed from shall database)
--dbg_shell_fire_rate = 60
--reformatted per-unit data to be mod system friendly 
--this file is no longer should be edited for adding new flyable aircraft , DCS automatically check core database (i.e. where you define your aircraft in aircraft table just define ViewSettings and SnapViews tables)

function default_fighter_player(t)
	local res = { 
		CameraViewAngleLimits  = gCameraViewAngleLimits,
		CameraAngleRestriction = {false, 90.0, 0.5},
		EyePoint               = gEyePoint,
		Allow360rotation	   = false,
		CameraAngleLimits      = gCameraAngleLimits,
		ShoulderSize 		   = gShoulderSize,
	}
	if t then 
		for i,o in pairs(t) do
			res[i] = o
		end
	end
	return res
end

function fulcrum()
	return {
		Cockpit = {
		default_fighter_player({CockpitLocalPoint = {4.71,1.28,0.000000},
								limits_6DOF       = {x = {-0.050000,0.4500000},y ={-0.300000,0.100000},z = {-0.220000,0.220000},roll = 90.000000}}),
		},
		Chase   = {
			LocalPoint      = {1.220000,3.750000,0.000000},
			AnglesDefault   = {180.000000,-8.000000},
		}, -- Chase 
		Arcade = {
			LocalPoint      = {-15.080000,6.350000,0.000000},
			AnglesDefault   = {0.000000,-8.000000},
		}, -- Arcade 
	}
end

ViewSettings = {}
ViewSettings["A-10A"] = {
	Cockpit = {
	[1] = default_fighter_player({CockpitLocalPoint	=  {4.300000,1.282000,0.000000},
								  limits_6DOF       =  {x 	 = {-0.050000,0.600000},
														y 	 = {-0.300000,0.100000},
														z 	 = {-0.250000,0.250000},
														roll =  90.000000}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {0.600000,3.682000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-27.000000,12.000000,0.000000},
		AnglesDefault   = {0.000000,-12.000000},
	}, -- Arcade 
}
ViewSettings["A-10C"] = {
	Cockpit = {
	[1] = default_fighter_player({CockpitLocalPoint      = {4.300000,1.282000,0.000000},
								  limits_6DOF            = {x 	 = {-0.050000,0.600000},
															y 	 = {-0.300000,0.100000},
															z 	 = {-0.250000,0.250000},
															roll =  90.000000}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {0.600000,3.682000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-27.000000,12.000000,0.000000},
		AnglesDefault   = {0.000000,-12.000000},
	}, -- Arcade 
}
ViewSettings["F-15C"] = {
	Cockpit = {  
	[1] = default_fighter_player({	
			CockpitLocalPoint	= {6.210000,1.204000,0.000000},
			limits_6DOF			= {x = {-0.05,0.45}, y = {-0.3,0.1}, z = {-0.22,0.22}, roll = 90}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {2.510000,3.604000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-13.790000,6.204000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["Hawk"] = {
 Cockpit = {
 [1] = {-- player slot 1
  CockpitLocalPoint      = {0.000,0.000,0.000},
  limits_6DOF            = {x = {-0.050000,0.450000},y ={-0.100000,0.100000},z = {-0.30000,0.30000},roll = 90.000000},
 },
 }, -- Cockpit 
 Chase = {
  LocalPoint      = {0.200000,-0.652000,-0.650000},
  AnglesDefault   = {0.000000,0.000000},
 }, -- Chase 
 Arcade = {
  LocalPoint      = {-21.500000,5.618000,0.000000},
  AnglesDefault   = {0.000000,-8.000000},
 }, -- Arcade 
}
ViewSettings["Ka-50"] = {
	Cockpit = {
	[1] = default_fighter_player({-- player slot 1
		CockpitLocalPoint      = {3.188000,0.390000,0.000000},
		--CameraViewAngleLimits  = {20.000000,120.000000},
		--CameraAngleRestriction = {false,60.000000,0.400000},
		--CameraAngleLimits      = {140.000000,-65.000000,90.000000},
		limits_6DOF            = {x = {-0.020000,0.350000},y ={-0.150000,0.165000},z = {-0.170000,0.170000},roll = 90.000000}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {-0.512000,2.790000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-16.812000,5.390000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["MiG-29A"] = fulcrum()
ViewSettings["MiG-29G"] = fulcrum()
ViewSettings["MiG-29S"] = fulcrum()
ViewSettings["P-51D"] = {
	Cockpit = {
	[1] = default_fighter_player({-- player slot 1
		CockpitLocalPoint      = {-1.500000,0.618000,0.000000},
		limits_6DOF            = {x = {-0.050000,0.450000},y ={-0.200000,0.200000},z = {-0.220000,0.220000},roll = 90.000000}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {0.200000,-0.652000,-0.650000},
		AnglesDefault   = {0.000000,0.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500000,5.618000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["TF-51D"] = {
	Cockpit = {
	[1] = {-- player slot 1
		CockpitLocalPoint      = {-1.500000,0.618000,0.000000},
		limits_6DOF            = {x = {-0.050000,0.450000},y ={-0.200000,0.200000},z = {-0.220000,0.220000},roll = 90.000000},
	},
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {0.200000,-0.652000,-0.650000},
		AnglesDefault   = {0.000000,0.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500000,5.618000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["Su-25"] = {
	Cockpit = {
	[1] = default_fighter_player({CockpitLocalPoint = {3.352000,0.506000,0.000000},
									limits_6DOF     = {x = {-0.050000,0.4500000},y ={-0.300000,0.100000},z = {-0.220000,0.220000},roll = 90.000000}}),-- player slot 1
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {-0.348000,2.906000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-16.648001,5.506000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["Su-25T"] = {
	Cockpit = {
		[1] = default_fighter_player({	CockpitLocalPoint	= {3.352,0.506,0},
										limits_6DOF 		= {	x = {-0.05,0.36},y = {-0.20,0.08},z = {-0.20,0.20}, roll = 90}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {-0.294000,2.866000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-16.594000,5.466000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["Su-25TM"] = {
	Cockpit = {
	[1] = default_fighter_player({-- player slot 1
		CockpitLocalPoint      = {4.000000,1.000000,0.000000},
		CameraViewAngleLimits  = {20.000000,140.000000},
		CameraAngleRestriction = {true,90.000000,0.400000},
		--CameraAngleLimits      = {160.000000,-70.000000,90.000000},
		limits_6DOF            = {x = {-0.200000,0.200000},y ={-0.200000,0.200000},z = {-0.200000,0.200000},roll = 60.000000}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {4.000000,2.000000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {4.000000,2.000000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["Su-27"] = {
	Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint = {7.959000,1.419000,0.000000},
									limits_6DOF       = {x = {-0.050000,0.4500000},y ={-0.300000,0.100000},z = {-0.220000,0.220000},roll = 90.000000}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {4.259000,3.819000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-12.041000,6.419000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["Su-33"] = ViewSettings["Su-27"]
ViewSettings["Mi-8MT"] = {
	Cockpit = {
	[1] = {-- player slot 1
		CockpitLocalPoint      = {3.916, -0.11 , 0.0},
		CameraViewAngleLimits  = gCameraViewAngleLimits,
		CameraAngleRestriction = {false,90.000000,0.400000},
		--CameraAngleLimits      = {140.000000,-65.000000,90.000000},
		EyePoint               = gEyePoint,
		ShoulderSize 		   = gShoulderSize,
		limits_6DOF            = {x = {-0.200000,0.400000},y ={-0.200000,0.25000},z = {-0.650000,1.0},roll = 90.000000},
	},
	
	[2] = {-- player slot 2
		CockpitLocalPoint      = {3.916, -0.11 , 0.0},
		CameraViewAngleLimits  = gCameraViewAngleLimits,
		CameraAngleRestriction = {false,90.000000,0.400000},
		--CameraAngleLimits      = {140.000000,-65.000000,90.000000},
		EyePoint               = gEyePoint,
		ShoulderSize 		   = gShoulderSize,
		limits_6DOF            = {x = {-0.200000,0.350000},y ={-0.200000,0.25000},z = {-0.400000,1.0},roll = 90.000000},
	},
	
	[3] = {-- player slot 3
		CockpitLocalPoint      = {3.916, -0.11 , 0.0},
		CameraViewAngleLimits  = gCameraViewAngleLimits,
		CameraAngleRestriction = {false,90.000000,0.400000},
		--CameraAngleLimits      = {140.000000,-65.000000,90.000000},
		EyePoint               = gEyePoint,
		ShoulderSize 		   = gShoulderSize,
		limits_6DOF            = {x = {-0.200000,0.400000},y ={-0.200000,0.30000},z = {-0.400000,0.4},roll = 90.000000},
	},
	
	[4] = {-- player slot 4
		CockpitLocalPoint      = {3.916, -0.11 , 0.0},
		CockpitLocalPointAzimuth  = 90,
		CameraViewAngleLimits  = gCameraViewAngleLimits,
		CameraAngleRestriction = {false,90.000000,0.400000},
		--CameraAngleLimits      = {140.000000,-65.000000,90.000000},
		EyePoint               = gEyePoint,
		limits_6DOF            = {x = {-1.8, 0.2}, y = {-0.6,0.5}, z = {-0.95,0.25}, roll = 90.000000},
	},

	
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {-5.700000,1.400000,-3},
		AnglesDefault   = {0,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-20.000000,5.000000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["UH-1H"] = {
	Cockpit = {
	[1] = {-- player slot 1
		CockpitLocalPoint      = {2.34, 0.37 , 0.0},
		CameraViewAngleLimits  = gCameraViewAngleLimits,
		CameraAngleRestriction = {false,90.000000,0.400000},
		--CameraAngleLimits      = {140.000000,-65.000000,90.000000},
		EyePoint               = gEyePoint,
		ShoulderSize 		   = gShoulderSize,
		limits_6DOF            = {x = {-0.100000,0.500000},
								  y = {-0.200000,0.350000},
								  z = {-0.200000,0.750000},
								  roll = 90.000000},
	},
	
	[2] = {-- player slot 2
		CockpitLocalPoint      = {2.34, 0.37 , 0.0},
		CameraViewAngleLimits  = gCameraViewAngleLimits,
		CameraAngleRestriction = {false,90.000000,0.400000},
		--CameraAngleLimits      = {140.000000,-65.000000,90.000000},
		EyePoint               = gEyePoint,
		ShoulderSize 		   = gShoulderSize,
		limits_6DOF            = {x = {-0.100000,0.500000},
								  y = {-0.200000,0.350000},
								  z = {-0.750000,0.200000},
								  roll = 90.000000},
	},
	
	[3] = {-- player slot 3
		CockpitLocalPoint         = {2.34, 0.37 , 0.0},
		CockpitLocalPointAzimuth  = -90,
		CameraViewAngleLimits  = gCameraViewAngleLimits,
		CameraAngleRestriction = {false,90.000000,0.400000},
		--CameraAngleLimits      = {140.000000,-65.000000,90.000000},
		EyePoint               = gEyePoint,
		ShoulderSize 		   = gShoulderSize,
		limits_6DOF            = {x 	= {-3.0, 0.35} , 
								  y 	= {-0.6,0.5},
								  z 	= {-0.25,1.4},						  
								  roll  = 90.000000},
	},
	
	[4] = {-- player slot 4
		CockpitLocalPoint      = {2.34, 0.37 , 0.0},
		CockpitLocalPointAzimuth  = 90,
		CameraViewAngleLimits  = gCameraViewAngleLimits,
		CameraAngleRestriction = {false,90.000000,0.400000},
		--CameraAngleLimits      = {140.000000,-65.000000,90.000000},
		EyePoint               = gEyePoint,
		limits_6DOF            = {x 	= {-3.0, 0.35},
								  y 	= {-0.6,0.5}, 
								  z 	= {-1.4,0.25},
								  roll  = 90.000000},
	},
	
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {-3.700000,2.400000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-20.000000,5.000000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["C-101CC"] = {
	Cockpit = {
	-- player slot 1
	[1] = default_fighter_player({
		CockpitLocalPoint      = {3.326,0.526,0.0},
		limits_6DOF            = {x = {-0.050000,0.20000},y ={-0.100000,0.100000},z = {-0.22000,0.22000},roll = 90.000000}}),
	-- player slot 2
	[2] = default_fighter_player({
		CockpitLocalPoint      = {1.740,0.841,0.0},
		limits_6DOF            = {x = {-0.050000,0.20000},y ={-0.100000,0.100000},z = {-0.22000,0.22000},roll = 90.000000}}),
	}, -- Cockpit 
	Chase = {
		--LocalPoint      = {0.200000,-0.652000,-0.650000},
		--AnglesDefault   = {0.000000,0.000000},
		LocalPoint      = {-5.0,1.0,3.0},
		AnglesDefault   = {0.000000,0.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500000,5.618000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["C-101EB"] = {
	Cockpit = {
	-- player slot 1
	[1] = default_fighter_player({
		CockpitLocalPoint      = {3.326,0.526,0.0},
		limits_6DOF            = {x = {-0.050000,0.20000},y ={-0.100000,0.100000},z = {-0.22000,0.22000},roll = 90.000000}}),
	-- player slot 2
	[2] = default_fighter_player({
		CockpitLocalPoint      = {1.740,0.841,0.0},
		limits_6DOF            = {x = {-0.050000,0.20000},y ={-0.100000,0.100000},z = {-0.22000,0.22000},roll = 90.000000}}),
	}, -- Cockpit 
	Chase = {
		--LocalPoint      = {0.200000,-0.652000,-0.650000},
		--AnglesDefault   = {0.000000,0.000000},
		LocalPoint      = {-5.0,1.0,3.0},
		AnglesDefault   = {0.000000,0.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500000,5.618000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["M-2000C"] = {
	Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {0.00,0.000,0.000},
									--CameraAngleLimits         = {200,-90.000000,90.000000},
									limits_6DOF             = {x = {-0.050000,0.30000},y ={-0.500000,0.100000},z = {-0.20000,0.20000},roll = 90.000000}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {-10.0,1.0,3.0},
        AnglesDefault   = {0.000000, 0.000000},
    }, -- Chase
    Arcade = {
        LocalPoint      = {-21.500000,6.618000,0.000000},
        AnglesDefault   = {0.000000,-8.000000},
    }, -- Arcade
}
ViewSettings["MiG-21Bis"] = {
	Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {3.00, 0.94, 0.0},
									--CameraAngleLimits         = {180,-80.000000,120.000000},
									limits_6DOF               = {x = {-0.15, 0.28}, y = {-0.2, 0.06}, z = {-0.15, 0.15}, roll = 45.0}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {-10.0,1.0,3.0},
        AnglesDefault   = {0.000000, 0.000000},
    }, -- Chase
    Arcade = {
        LocalPoint      = {-21.500000,6.618000,0.000000},
        AnglesDefault   = {0.000000,-8.000000},
    }, -- Arcade
}
ViewSettings["MiG-15bis"] = {
	Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {1.829509 ,0.868164 ,0},
									--CameraAngleLimits         = {200,-90.000000,90.000000},
									limits_6DOF               = {x = {-0.15,0.25},y ={-0.15,0.075},z = {-0.170,0.170},roll = 90.000000}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {-5.0,1.0,3.0},
		AnglesDefault   = {0.000000,0.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500000,5.618000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
    }, -- Arcade
}
ViewSettings["F-86F Sabre"] = {
	Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {1.677, 1.151, 0.000000},
									--CameraAngleLimits         = {200,-90.000000,90.000000},
									limits_6DOF               = {x = {-0.2,0.30},y ={-0.15,0.10},z = {-0.15000,0.15000},roll = 90.000000}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {-5.0,1.0,3.0},
		AnglesDefault   = {0.000000,0.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500000,5.618000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
    }, -- Arcade
}
ViewSettings["SpitfireLFMkIX"] = {
	Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {-1.564, 0.567, 0.0},
									--CameraAngleLimits         = {200,-90.0,90.0},
									limits_6DOF               = {x = {-0.071, 0.220}, y = {-0.375, 0.030}, z = {-0.155, 0.155}, roll = 90.0}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {0.0, -0.191, -1.146},
		AnglesDefault   = {0.0, 0.0},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500000,5.618000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["SpitfireLFMkIXCW"] = {
	Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {-1.564, 0.567, 0.0},
									--CameraAngleLimits         = {200,-90.0,90.0},
									limits_6DOF               = {x = {-0.071, 0.220}, y = {-0.375, 0.030}, z = {-0.155, 0.155}, roll = 90.0}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {0.0, -0.191, -1.146},
		AnglesDefault   = {0.0, 0.0},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500000,5.618000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["Bf-109K-4"] = {
    Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {-1.03, 0.72, 0.0},
									--CameraAngleLimits         = {200,-90.000000,90.000000},
									limits_6DOF               = {x = {-0.06, 0.35}, y = {-0.32, 0.08}, z = {-0.17, 0.17}, roll = 90.0}}),
    }, -- Cockpit 
    Chase = {
        LocalPoint      = {0.0, -0.191, -1.146},
        AnglesDefault   = {0.0, 0.0},
    }, -- Chase 
    Arcade = {
        LocalPoint      = {-21.500000,5.618000,0.000000},
        AnglesDefault   = {0.000000,-8.000000},
    }, -- Arcade 
}
ViewSettings["FW-190D9"] = {
    Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {-0.988,0.744,0.000000},
									--CameraAngleLimits         = {200,-90.000000,90.000000},
									limits_6DOF               = {x = {-0.050000,0.30000},y ={-0.350000,0.100000},z = {-0.12000,0.12000},roll = 90.000000}}),
    }, -- Cockpit 
	Chase = {
		LocalPoint      = {0.200000,-0.652000,-0.650000},
		AnglesDefault   = {0.000000,0.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500000,5.618000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["AJS37"] = {
    Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {4.802242, 0.720387, 0.0},
									--CameraAngleLimits         = {200,-90.000000,90.000000},
									limits_6DOF               = {x = {-0.15,0.50},y = {-0.35,1.15},z = {-0.60,.60},roll = 90.000000}}),
    }, -- Cockpit 
	Chase = {
		LocalPoint      = {0.200000,1.7000,-1.300000},
		AnglesDefault   = {0.000000,-5.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-27.000000,12.000000,0.000000},
		AnglesDefault   = {0.000000,-12.000000},
	}, -- Arcade 
}
ViewSettings["L-39C"] = {
    Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {3.04, 0.68, 0.0},
									--CameraAngleLimits         = {200,-90.000000,90.000000},
									limits_6DOF               = {x = {-0.05,0.2},y ={-0.5,0.1},z = {-0.25,0.25},roll = 90.000000}}),
	[2] = default_fighter_player({	CockpitLocalPoint         = {1.5, 1.0, 0.0},
									--CameraAngleLimits         = {200,-90.000000,90.000000},
									limits_6DOF               = {x = {-0.05,0.2},y ={-0.5,0.1},z = {-0.25,0.25},roll = 90.000000}}),
    }, -- Cockpit 
	Chase = {
		LocalPoint      = {-5.0,1.0,3.0},
		AnglesDefault   = {0.000000,0.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500000,5.618000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["L-39ZA"] = {
    Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {3.04, 0.68, 0.0},
									--CameraAngleLimits         = {200,-90.000000,90.000000},
									limits_6DOF               = {x = {-0.05,0.2},y ={-0.5,0.1},z = {-0.25,0.25},roll = 90.000000}}),
	[2] = default_fighter_player({	CockpitLocalPoint         = {1.5, 1.0, 0.0},
									--CameraAngleLimits         = {200,-90.000000,90.000000},
									limits_6DOF               = {x = {-0.05,0.2},y ={-0.5,0.1},z = {-0.25,0.25},roll = 90.000000}}),
    }, -- Cockpit 
	Chase = {
		LocalPoint      = {-5.0,1.0,3.0},
		AnglesDefault   = {0.000000,0.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500000,5.618000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["F-5E-3"] = {
	Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {3.022,0.860,0.0},
									--CameraAngleLimits         = {200,-90.000000,90.000000},
									limits_6DOF               = {x = {-0.05,0.21},y ={-0.10,0.08},z = {-0.19,0.19},roll = 90.000000}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {-5.0,1.0,3.0},
		AnglesDefault   = {0.000000,0.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500000,5.618000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
    }, -- Arcade
}	
ViewSettings["AV8BNA"] = {
	Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {0.00,0.000,0.000},
									--CameraAngleLimits         = {200,-90.000000,90.000000},
									limits_6DOF               = {x = {-0.050000,0.30000},y ={-0.100000,0.100000},z = {-0.20000,0.20000},roll = 90.000000}}),
	}, -- Cockpit 
	Chase = {
        LocalPoint      = {-10.0,1.0,3.0},
        AnglesDefault   = {0.000000, 0.000000},
    }, -- Chase
    Arcade = {
        LocalPoint      = {-21.500000,6.618000,0.000000},
        AnglesDefault   = {0.000000,-8.000000},
    }, -- Arcade
}	
ViewSettings["FA-18C_hornet"] = {
	Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {3.533,1.156,0.0},
									--CameraAngleLimits         = {200,-90.000000,90.000000},
									limits_6DOF               = {x = {-0.13,0.30},y ={-0.3,0.065},z = {-0.18,0.18},roll = 90.000000}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {-5.0,1.0,3.0},
		AnglesDefault   = {0.000000,0.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500000,5.618000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}	
ViewSettings["F-14B"] = {
    Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {7.114937, 1.39846, 0.0},
									--CameraAngleLimits         = {180, -80.0, 120.0},
									limits_6DOF               = {x = {-0.3, 0.37}, y = {-0.55, 0.10}, z = {-0.25, 0.25}, roll = 45.0}}),
	[2] = default_fighter_player({	CockpitLocalPoint         = {5.596174, 1.605, 0.0},
									--CameraAngleLimits         = {180, -80.0, 120.0},
									limits_6DOF               = {x = {-0.3, 0.45}, y = {-0.55, 0.10}, z = {-0.25, 0.25}, roll = 45.0}}),
    }, -- Cockpit 
	Chase = {
		LocalPoint      = {-10.0,1.0,3.0},
		AnglesDefault   = {0.000000,0.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-25.0, 6.0, 0.0},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["F-16C_50"] = {
	Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {3.259,0.796,0.0},
									--CameraAngleLimits         = {200,-90.000000,90.000000},
									limits_6DOF               = {x = {-0.13,0.30},y ={-0.06,0.16},z = {-0.18,0.18},roll = 90.000000}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {-5.0,1.0,3.0},
		AnglesDefault   = {0.000000,0.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500000,5.618000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}
ViewSettings["P-47D-30"] = {
	Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {-1.850, 0.925, 0.000},
									--CameraAngleLimits         = {180.0, -90.0, 90.0},
									limits_6DOF               = {x = {-0.080, 0.392}, y = {-0.250, 0.080}, z = {-0.188, 0.188}, roll = 90.0}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {0.000, -0.191, -1.146},
        AnglesDefault   = {0.456, 0.437},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500, 5.618, 0.000},
        AnglesDefault   = {0.0, -8.0},
	}, -- Arcade 
}
ViewSettings["P-47D-30bl1"] = {
	Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {-1.850, 0.925, 0.000},
									--CameraAngleLimits         = {180.0, -90.0, 90.0},
									limits_6DOF               = {x = {-0.080, 0.392}, y = {-0.250, 0.080}, z = {-0.188, 0.188}, roll = 90.0}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {0.000, -0.191, -1.146},
        AnglesDefault   = {0.456, 0.437},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500, 5.618, 0.000},
        AnglesDefault   = {0.0, -8.0},
	}, -- Arcade 
}
ViewSettings["P-47D-40"] = {
	Cockpit = {
	[1] = default_fighter_player({	CockpitLocalPoint         = {-1.850, 0.925, 0.000},
									--CameraAngleLimits         = {180.0, -90.0, 90.0},
									limits_6DOF               = {x = {-0.080, 0.392}, y = {-0.250, 0.080}, z = {-0.188, 0.188}, roll = 90.0}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {0.000, -0.191, -1.146},
        AnglesDefault   = {0.456, 0.437},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-21.500, 5.618, 0.000},
        AnglesDefault   = {0.0, -8.0},
	}, -- Arcade 
}
ViewSettings["A-10C_2"] = {
	Cockpit = {
	[1] = default_fighter_player({CockpitLocalPoint      = {4.300000,1.282000,0.000000},
								  --CameraAngleLimits      = {200.0, -90.0, 90.0},
								  limits_6DOF            = {x 	 = {-0.050000,0.600000},
															y 	 = {-0.300000,0.100000},
															z 	 = {-0.250000,0.250000},
															roll =  90.000000}}),
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {0.600000,3.682000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-27.000000,12.000000,0.000000},
		AnglesDefault   = {0.000000,-12.000000},
	}, -- Arcade 
}