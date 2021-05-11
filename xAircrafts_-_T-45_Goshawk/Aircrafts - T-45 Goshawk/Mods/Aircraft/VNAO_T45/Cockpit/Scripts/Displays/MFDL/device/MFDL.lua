dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Displays/MFDPages.lua")

local dev = GetSelf()
local update_time_step = 0.05
make_default_activity(update_time_step)
local sensor_data = get_base_data()
local ESbus = get_param_handle("ESS_SERV_BUS")
--------------------------------------------------------------------------
local masterMode = get_param_handle("MASTER_MODE")
local MFDL_ONOFF = get_param_handle("MFDL_ONOFF")
local MFDL_Brightness = get_param_handle("MFDL_BRIGHTNESS")
local MFDL_page = get_param_handle("MFDL_PAGE")
MFDL_page:set(MENUPage)
local ripple_mode = get_param_handle("RIPPLE_MODE") -- 0 single, 1 ripple
ripple_mode:set(0)
local gun_select = get_param_handle("GUN_SELECT") 
gun_select:set(0)
local ccip_mode = get_param_handle("CCIP_MODE") -- 1 CCIP, 0 manual
ccip_mode:set(0)
local station_selected = get_param_handle("STATION_SELECTED") -- 0 none, 1 L RKT, 2 L BOMB, 3 R BOMB, 4 R RKT
station_selected:set(0)
local weapon_type = get_param_handle("WEAPON_TYPE") -- 0 none, 1 Bomb, 2 rocket   for HUD indication
weapon_type:set(0)
local HSI_scale = get_param_handle("HSI_SCALE") 
HSI_scale:set(40)
local tacan_selected = get_param_handle("TACAN_SELECTED") 
tacan_selected:set(0)
local vor_selected = get_param_handle("VOR_SELECTED") 
vor_selected:set(0)
local ils_selected = get_param_handle("ILS_SELECTED") 
ils_selected:set(0)
local HDG = get_param_handle("HSI_HDG_SET") -- Also set in DataEntryPanel.lua
local CRS = get_param_handle("HSI_CRS_SET") -- Also set in DataEntryPanel.lua 
local hdg_selected = get_param_handle("HDG_SELECTED") 
hdg_selected:set(0)
local crs_selected = get_param_handle("CRS_SELECTED") 
crs_selected:set(1)
local bingo = get_param_handle("BINGO") -- Also set in DataEntryPanel.lua
local LAW = get_param_handle("LAW") -- Also set in DataEntryPanel.lua
local bingo_selected = get_param_handle("BINGO_SELECTED") 
bingo_selected:set(0)
local law_selected = get_param_handle("LAW_SELECTED") 
law_selected:set(0)
local pt_selected = get_param_handle("PT_SELECTED") 
pt_selected:set(0)
local pitch_trim = get_param_handle("PITCH_TRIM")
--local hsi_mode = get_param_handle("HSI_MODE") -- 1: CDI, 2: PLAN
--hsi_mode:set(0)
local active_waypoint = get_param_handle("ACTIVE_WAYPOINT") 
active_waypoint:set(0)
local waypoint_selected = get_param_handle("WAYPOINT_SELECTED") 
waypoint_selected:set(0)
local vorILS_type = get_param_handle("VOR_ILS_TYPE") -- 0:none, 1:VOR, 2:ILS input
local cdi_selected = get_param_handle("CDI_SELECTED")
cdi_selected:set(0)
local plan_selected = get_param_handle("PLAN_SELECTED") 
plan_selected:set(1)

local VELVECCage		= get_param_handle("VELVECCage") --also set in HUD device


dev:listen_command(MFDL_commands.dayPower)
dev:listen_command(MFDL_commands.nightPower)
dev:listen_command(MFDL_commands.offSwitch)
dev:listen_command(MFDL_commands.brightnessUp)
dev:listen_command(MFDL_commands.brightnessDown)
dev:listen_command(MFDL_commands.PB1)
dev:listen_command(MFDL_commands.PB2)
dev:listen_command(MFDL_commands.PB3)
dev:listen_command(MFDL_commands.PB4)
dev:listen_command(MFDL_commands.PB5)
dev:listen_command(MFDL_commands.PB6)
dev:listen_command(MFDL_commands.PB7)
dev:listen_command(MFDL_commands.PB8)
dev:listen_command(MFDL_commands.PB9)
dev:listen_command(MFDL_commands.PB10)
dev:listen_command(MFDL_commands.PB11)
dev:listen_command(MFDL_commands.PB12)
dev:listen_command(MFDL_commands.PB13)
dev:listen_command(MFDL_commands.PB14)
dev:listen_command(MFDL_commands.PB15)
dev:listen_command(MFDL_commands.PB16)
dev:listen_command(MFDL_commands.PB17)
dev:listen_command(MFDL_commands.PB18)
dev:listen_command(MFDL_commands.PB19)
dev:listen_command(MFDL_commands.PB20)

local MFDLpower = 1
local page=MENUPage
local brightnessMode = 1 -- 1:day, 0.65:night
local brightnessSetting = 1
function post_initialize()
	local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
        MFDLpower = 1	
    elseif birth=="GROUND_COLD" then
        MFDLpower = 0		
    end
	
end

function update()	
	if	ESbus:get()>21 then	--make sure there is power for the MFD to work or else it will be off		
		MFDL_ONOFF:set(MFDLpower)	
		MFDL_page:set(page)
	else  
		MFDL_ONOFF:set(0)		
	end
	
	if brightnessSetting > 1 then
		brightnessSetting = 1
	elseif brightnessSetting < 0 then
		brightnessSetting = 0
	end
	MFDL_Brightness:set(brightnessSetting*brightnessMode)
end


function SetCommand(command,value)   
	if command == MFDL_commands.dayPower then      
        MFDLpower = 1
		brightnessMode = 1
	elseif command == MFDL_commands.nightPower then 
		MFDLpower = 1
		brightnessMode = 0.65
	elseif command == MFDL_commands.offSwitch then    
		MFDLpower = 0
	elseif command == MFDL_commands.brightnessUp and value==1 then
		brightnessSetting = brightnessSetting+0.05
	elseif command == MFDL_commands.brightnessDown and value==1 then
		brightnessSetting = brightnessSetting-0.05
	elseif command == MFDL_commands.PB13 then
		page = MENUPage
	end
if value == 1 then -- this is to prevent duplicate clicks
	if page == MENUPage then
		setMENU(command)
	elseif page == ADIPage then
		setADI(command)
	elseif page == HSIPage then
		setHSI(command)
	elseif page == STRSPage then
		setSTRS(command)
	elseif page == ENGPage then
		setENG(command)
	elseif page == DATAPage then
		setDATA(command)
	elseif page == ACFTDATAPage then
		setACFT(command)
	elseif page == GPSDATAPage then
		setGPS(command)
	elseif page == HUDPage then
		setHUD(command)
	end
end

end

function setMENU(command)
	if command == MFDL_commands.PB3 then
		--page = BITPage
	elseif command == MFDL_commands.PB7 then
		page = ENGPage
	elseif command == MFDL_commands.PB14 then
		page = DATAPage
	elseif command == MFDL_commands.PB16 then
		page = ADIPage
	elseif command == MFDL_commands.PB17 then
		page = HSIPage
	elseif command == MFDL_commands.PB18 then
		page = HUDPage
	elseif command == MFDL_commands.PB20 then
		page = STRSPage
    end
end

function setADI(command)
	if command == MFDL_commands.PB9 then
		if bingo_selected:get()==1 then
			if bingo:get()>=3000 then bingo:set(2900) end
			bingo:set(bingo:get()+100)
		elseif law_selected:get()==1 then
			if LAW:get()>=5000 then LAW:set(4990) end
			LAW:set(LAW:get()+10)
		elseif pt_selected:get()==1 then
			if pitch_trim:get()>=5 then pitch_trim:set(4) end
			pitch_trim:set(pitch_trim:get()+1)
		end
	elseif command == MFDL_commands.PB10 then
		if bingo_selected:get()==1 then
			if bingo:get()<=0 then bingo:set(100) end
			bingo:set(bingo:get()-100)
		elseif law_selected:get()==1 then
			if LAW:get()<=0 then LAW:set(10) end
			LAW:set(LAW:get()-10)
		elseif pt_selected:get()==1 then
			if pitch_trim:get()<=-5 then pitch_trim:set(-4) end
			pitch_trim:set(pitch_trim:get()-1)
		end
	elseif command == MFDL_commands.PB11 then
		law_selected:set(1-law_selected:get())
		bingo_selected:set(0)
		pt_selected:set(0)
	elseif command == MFDL_commands.PB12 then
		bingo_selected:set(1-bingo_selected:get())
		law_selected:set(0)
		pt_selected:set(0)	
	elseif command == MFDL_commands.PB14 then
		page = DATAPage
	elseif command == MFDL_commands.PB15 then
		pt_selected:set(1-pt_selected:get())
		law_selected:set(0)
		bingo_selected:set(0)
	elseif command == MFDL_commands.PB17 then
		page = HSIPage
    end
end

function setHSI(command)
	if command == MFDL_commands.PB3 then
		if HSI_scale:get()==160 then
			HSI_scale:set(80)
		elseif HSI_scale:get()==80 then
			HSI_scale:set(40)
		elseif HSI_scale:get()==40 then
			HSI_scale:set(20)
		elseif HSI_scale:get()==20 then
			HSI_scale:set(10)
		elseif HSI_scale:get()==10 then
			HSI_scale:set(160)
		end
	elseif command == MFDL_commands.PB6 then
		waypoint_selected:set(1-waypoint_selected:get())
		tacan_selected:set(0)
		vor_selected:set(0)
		ils_selected:set(0)
	elseif command == MFDL_commands.PB7 then
		active_waypoint:set(active_waypoint:get()+1)
		if active_waypoint:get()>10 then active_waypoint:set(10) end
	elseif command == MFDL_commands.PB8 then
		active_waypoint:set(active_waypoint:get()-1)
		if active_waypoint:get()<0 then active_waypoint:set(0) end
	elseif command == MFDL_commands.PB9 then
		if hdg_selected:get()==1 then
			if HDG:get()==359 then HDG:set(-1) end
			HDG:set(HDG:get()+1)
		elseif crs_selected:get()==1 then
			if CRS:get()==359 then CRS:set(-1) end
			CRS:set(CRS:get()+1)
		end
	elseif command == MFDL_commands.PB10 then
		if hdg_selected:get()==1 then
			if HDG:get()==0 then HDG:set(360) end
			HDG:set(HDG:get()-1)
		elseif crs_selected:get()==1 then
			if CRS:get()==0 then CRS:set(360) end
			CRS:set(CRS:get()-1)
		end
	elseif command == MFDL_commands.PB11 then
		crs_selected:set(1-crs_selected:get())
		hdg_selected:set(0)
	elseif command == MFDL_commands.PB12 then
		hdg_selected:set(1-hdg_selected:get())
		crs_selected:set(0)
	elseif command == MFDL_commands.PB14 then
		page = DATAPage
	elseif command == MFDL_commands.PB16 then -- ADI
		page = ADIPage
	elseif command == MFDL_commands.PB17 then -- CDI
		cdi_selected:set(1)
		plan_selected:set(0)
	elseif command == MFDL_commands.PB18 then -- PLAN
		plan_selected:set(1)
		cdi_selected:set(0)
	elseif command == MFDL_commands.PB19 then
		if vorILS_type:get()==1 then
			vor_selected:set(1-vor_selected:get())
		elseif vorILS_type:get()==2 then
			ils_selected:set(1-ils_selected:get())
		end
		waypoint_selected:set(0)
		tacan_selected:set(0)
	elseif command == MFDL_commands.PB20 then
		tacan_selected:set(1-tacan_selected:get())
		waypoint_selected:set(0)
		vor_selected:set(0)
		ils_selected:set(0)
    end
end

function setSTRS(command)
	if command == MFDL_commands.PB16 then
		page = ADIPage
	elseif command == MFDL_commands.PB17 then
		page = HSIPage
	elseif command == MFDL_commands.PB18 then
		masterMode:set(1)
	elseif command == MFDL_commands.PB19 then
		masterMode:set(2)
	elseif command == MFDL_commands.PB20 then
		masterMode:set(0)
    end
	if masterMode:get()==1 then -- A/G mode
		if command == MFDL_commands.PB11 then
			ripple_mode:set(1-ripple_mode:get())
		elseif command == MFDL_commands.PB3 then
			gun_select:set(1-gun_select:get())
		elseif command == MFDL_commands.PB8 then
			ccip_mode:set(0)
		elseif command == MFDL_commands.PB9 then
			ccip_mode:set(1)
		elseif command == MFDL_commands.PB1 then
			if station_selected:get()==1 then
				station_selected:set(0)
				weapon_type:set(0)
			else
				station_selected:set(1)
				weapon_type:set(2)
			end
		elseif command == MFDL_commands.PB2 then
			if station_selected:get()==2 then
				station_selected:set(0)
				weapon_type:set(0)
			else
				station_selected:set(2)
				weapon_type:set(1)
			end
		elseif command == MFDL_commands.PB4 then
			if station_selected:get()==3 then
				station_selected:set(0)
				weapon_type:set(0)
			else
				station_selected:set(3)
				weapon_type:set(1)
			end
		elseif command == MFDL_commands.PB5 then
			if station_selected:get()==4 then
				station_selected:set(0)
				weapon_type:set(0)
			else
				station_selected:set(4)
				weapon_type:set(2)
			end
		end
	elseif masterMode:get()==2 then -- A/A mode
		if command == MFDL_commands.PB3 then
			gun_select:set(1-gun_select:get())
		end
	end
end

function setDATA(command)
	if command == MFDL_commands.PB16 then
		page = ADIPage
	elseif command == MFDL_commands.PB17 then
		page = HSIPage
	elseif command == MFDL_commands.PB12 then
		page = GPSDATAPage
	elseif command == MFDL_commands.PB15 then
		page = ACFTDATAPage
    end
end

function setACFT(command)
	if command == MFDL_commands.PB16 then
		page = ADIPage
	elseif command == MFDL_commands.PB17 then
		page = HSIPage
	elseif command == MFDL_commands.PB12 then
		page = GPSDATAPage
	elseif command == MFDL_commands.PB14 then
		page = DATAPage
    end
end

function setGPS(command)
	if command == MFDL_commands.PB16 then
		page = ADIPage
	elseif command == MFDL_commands.PB17 then
		page = HSIPage
	elseif command == MFDL_commands.PB14 then
		page = DATAPage
	elseif command == MFDL_commands.PB15 then
		page = ACFTDATAPage
    end
end

function setHUD(command)
	if command == MFDL_commands.PB16 then
		page = ADIPage
	elseif command == MFDL_commands.PB17 then
		page = HSIPage
	elseif command == MFDL_commands.PB8 then
		VELVECCage:set(1-VELVECCage:get())
    end
end

function setENG(command)
	if command == MFDL_commands.PB16 then
		page = ADIPage
	elseif command == MFDL_commands.PB17 then
		page = HSIPage
    end
end

need_to_be_closed = false