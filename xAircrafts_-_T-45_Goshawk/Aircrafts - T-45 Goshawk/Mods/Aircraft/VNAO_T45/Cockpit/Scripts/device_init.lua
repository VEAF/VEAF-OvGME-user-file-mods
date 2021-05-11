dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")
dofile(LockOn_Options.script_path.."materials.lua")


MainPanel = {"ccMainPanel",LockOn_Options.script_path.."mainpanel_init.lua"}

-- Avionics devices initialization example
--	items in <...> are optional
--
-- creators[DEVICE_ID] = {"NAME_OF_CONTROLLER_CLASS",
--						  <"CONTROLLER_SCRIPT_FILE",>
--						  <{devices.LINKED_DEVICE1, devices.LINKED_DEVICE2, ...},>
--						  <"INPUT_COMMANDS_SCRIPT_FILE",>
--						  <{{"NAME_OF_INDICATOR_CLASS", "INDICATOR_SCRIPT_FILE"}, ...}>
--						 }
creators    = {}
creators[devices.WEAPON_SYSTEM] = {"avSimpleWeaponSystem"   ,LockOn_Options.script_path.."Systems/WeaponSystem.lua"}
creators[devices.AVIONICS]      = {"avLuaDevice"            ,LockOn_Options.script_path.."Systems/avionics.lua"}
creators[devices.CLOCK]         = {"avLuaDevice"            ,LockOn_Options.script_path.."Systems/clock.lua"}
creators[devices.HUD]           = {"avLuaDevice"            ,LockOn_Options.script_path.."Displays/HUD/device/HUD.lua"}
creators[devices.MFDL]          = {"avLuaDevice"            ,LockOn_Options.script_path.."Displays/MFDL/device/MFDL.lua"}
creators[devices.MFDR]          = {"avLuaDevice"            ,LockOn_Options.script_path.."Displays/MFDR/device/MFDR.lua"}
creators[devices.DISPLAYCOMPUTER] = {"avLuaDevice"          ,LockOn_Options.script_path.."Displays/DisplayElectronicsUnit.lua"}
creators[devices.RADIO1]    	= {"avUHF_ARC_164"          ,LockOn_Options.script_path.."Systems/Radio1.lua", {devices.INTERCOM} }
creators[devices.RADIO2]    	= {"avUHF_ARC_164"          ,LockOn_Options.script_path.."Systems/Radio2.lua"}
creators[devices.INTERCOM]      = {"avIntercom"             ,LockOn_Options.script_path.."Systems/Intercom.lua", {devices.RADIO1} }
creators[devices.COMM1]         = {"avLuaDevice"            ,LockOn_Options.script_path.."Systems/COMM1Controls.lua"}
creators[devices.COMM2]         = {"avLuaDevice"            ,LockOn_Options.script_path.."Systems/COMM2Controls.lua"}
creators[devices.DEP]           = {"avLuaDevice"            ,LockOn_Options.script_path.."Systems/DataEntryPanel.lua"}
creators[devices.TACAN]         = {"avLuaDevice"			,LockOn_Options.script_path.."Nav/TACAN.lua"}
creators[devices.VOR_ILS]       = {"avLuaDevice"			,LockOn_Options.script_path.."Nav/VOR_ILS.lua"}
creators[devices.NAV]           = {"avLuaDevice"            ,LockOn_Options.script_path.."Nav/Nav.lua"}
creators[devices.EFM]           = {"avLuaDevice"            ,LockOn_Options.script_path.."Systems/EFM.lua"} -- script to help key presses control cockpit switches
creators[devices.ConnectorUpdater]           = {"avLuaDevice"            ,LockOn_Options.script_path.."Systems/ConnectorUpdate.lua"} 

creators[devices.EXTANIM]       = {"avLuaDevice"            ,LockOn_Options.script_path.."Systems/test_device.lua"} -- for testing

-- Indicators
indicators = {}
indicators[#indicators + 1] = {"ccIndicator" ,LockOn_Options.script_path.."Displays/HUD/Indicator/init.lua"}	-- HUD
indicators[#indicators + 1] = {"ccIndicator" ,LockOn_Options.script_path.."Displays/UHFdisplay1/init.lua"} -- Front center radio
indicators[#indicators + 1] = {"ccIndicator" ,LockOn_Options.script_path.."Displays/UHFdisplay2/init.lua"} -- Front right radio
indicators[#indicators + 1] = {"ccIndicator" ,LockOn_Options.script_path.."Displays/UHFdisplay1/init.lua",nil,-- Rear center radio
{	
	{nil,nil,nil}, -- initial geometry anchor , triple of connector names 
	{sx_l =  -1.432,  -- center position correction in meters (forward , backward) 
	 sy_l =  0.316,  -- center position correction in meters (up , down)
	 sz_l =  0,  -- center position correction in meters (left , right)
	 sh   =  0,  -- half height correction 
	 sw   =  0,  -- half width correction 
	 rz_l =  0,  -- rotation corrections in degrees
	 rx_l =  0,
	 ry_l =  0}
  }
} 
indicators[#indicators + 1] = {"ccIndicator" ,LockOn_Options.script_path.."Displays/UHFdisplay2/init.lua",nil,-- Rear right radio
{	
	{nil,nil,nil}, -- initial geometry anchor , triple of connector names 
	{sx_l =  -1.4275,  -- center position correction in meters (forward , backward) 
	 sy_l =  0.31,  -- center position correction in meters (up , down)
	 sz_l =  0,  -- center position correction in meters (left , right)
	 sh   =  0,  -- half height correction 
	 sw   =  0,  -- half width correction 
	 rz_l =  0,  -- rotation corrections in degrees
	 rx_l =  0,
	 ry_l =  0}
  }
} 
  
indicators[#indicators + 1] = {"ccIndicator" ,LockOn_Options.script_path.."Displays/MFDL/Indicator/init.lua",nil,{{"FP_LMFD_Center","FP_LMFD_Bot","FP_LMFD_Right"}} }-- Front left MFD
indicators[#indicators + 1] = {"ccIndicator" ,LockOn_Options.script_path.."Displays/MFDR/Indicator/init.lua",nil,{{"FP_RMFD_Center","FP_RMFD_Bot","FP_RMFD_Right"}} }-- Front Right MFD

indicators[#indicators + 1] = {"ccIndicator" ,LockOn_Options.script_path.."Displays/MFDL/Indicator/init.lua",nil, {{"RP_LMFD_Center","RP_LMFD_Bot","RP_LMFD_Right"}} }-- Rear left MFD
indicators[#indicators + 1] = {"ccIndicator" ,LockOn_Options.script_path.."Displays/MFDR/Indicator/init.lua",nil, {{"RP_RMFD_Center","RP_RMFD_Bot","RP_RMFD_Right"}} }-- Rear right MFD

dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
