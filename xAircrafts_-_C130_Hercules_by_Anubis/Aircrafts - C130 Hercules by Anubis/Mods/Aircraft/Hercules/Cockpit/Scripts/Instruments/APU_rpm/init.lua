

dofile(LockOn_Options.common_script_path.."devices_defs.lua")
-- dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

indicator_type       = indicator_types.COMMON----------------------
purposes = {render_purpose.GENERAL}
init_pageID     = 1
-- purposes 	   = {render_purpose.GENERAL}
--subset ids
BASE    = 1
INDICATION = 2

page_subsets  = {
[BASE]    		= LockOn_Options.script_path.."Display_DC_base_page.lua",
[INDICATION]    = LockOn_Options.script_path.."Instruments/APU_rpm/indication_page.lua",
}
pages = 
{
	{
	 BASE,
	 INDICATION
	 },
}


-- update_screenspace_diplacement(SelfWidth/SelfHeight,false)
-- dedicated_viewport_arcade = dedicated_viewport
