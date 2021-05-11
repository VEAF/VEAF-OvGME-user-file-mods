dofile(LockOn_Options.common_script_path.."devices_defs.lua")
indicator_type    = indicator_types.COMMON
init_pageID     = 1
purposes 	   = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}

--subset ids
BASE    = 1
MENU	= 2
STORES 	= 3
HSI		= 4
ADI		= 5
ENGINE	= 6
DATA	= 7
HUD		= 8
ACFT	= 9
GPS		= 10
BIT		= 11


page_subsets  = {
[BASE]    	= LockOn_Options.script_path.."Displays/MFDR/Indicator/base_page.lua",
[MENU]    	= LockOn_Options.script_path.."Displays/MFDR/Indicator/menu_page.lua",
[STORES]    = LockOn_Options.script_path.."Displays/MFDR/Indicator/stores_page.lua",
[HSI]    	= LockOn_Options.script_path.."Displays/MFDR/Indicator/hsi_page.lua",
[ADI]    	= LockOn_Options.script_path.."Displays/MFDR/Indicator/adi_page.lua",
[ENGINE]    = LockOn_Options.script_path.."Displays/MFDR/Indicator/eng_page.lua",
[DATA]      = LockOn_Options.script_path.."Displays/MFDR/Indicator/data_page.lua",
[ACFT]      = LockOn_Options.script_path.."Displays/MFDR/Indicator/acft_page.lua",
[GPS]       = LockOn_Options.script_path.."Displays/MFDR/Indicator/gps_page.lua",
[HUD]       = LockOn_Options.script_path.."Displays/MFDR/Indicator/hud_page.lua",
}


pages ={{BASE,MENU,STORES,HSI,ADI,ENGINE,DATA,ACFT,GPS,HUD},}

dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
try_find_assigned_viewport("MFDR")