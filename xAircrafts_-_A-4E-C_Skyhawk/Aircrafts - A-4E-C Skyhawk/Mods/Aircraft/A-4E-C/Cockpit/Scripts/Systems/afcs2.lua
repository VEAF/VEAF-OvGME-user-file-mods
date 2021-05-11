dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."Systems/stores_config.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path.."Systems/hydraulic_system_api.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")

local dev = GetSelf()

local update_time_step = 0.02
make_default_activity(update_time_step) --update will be called 50 times per second

local sensor_data = get_efm_sensor_data_overrides()
local efm_data_bus = get_efm_data_bus()

local optionsData_ffbCSSActivate = get_plugin_option_value("A-4E-C", "cssActivate", "local")


--[[
Control_Channel = {}
Control_Channel.__index = Control_Channel

--Set Control_Channel() operator to be the new function
setmetatable(Control_Channel, {
    __call = function(cls, ...)
    return cls.new(...)
    end,
})

function Control_Channel.new(Kp, Ki, Kd, umin, umax, uscale)
    local self = setmetatable({}, Control_Channel)

    self.m_pid = PID(Kp, Ki, Kd, umin, umax, uscale)
    self.m_activated = false
    self.m_setpoint = 0.0
end
]]--
local meters_to_feet = 3.2808399
local GALLON_TO_KG = 3.785 * 0.8
local KG_TO_POUNDS = 2.20462
local MPS_TO_KNOTS = 1.94384
local RADIANS_TO_DEGREES = 57.2958



local roll_trim_handle = get_param_handle("ROLL_TRIM")
local pitch_trim_handle = get_param_handle("PITCH_TRIM")

--AFCS PID
local roll_pid = PID(3, 0.01, 0.9, -100, 100, 0.004)   -- create the PID for bank angle control (aileron trim), values found experimentally
local pitch_pid = PID(6, 0.05, 0.2, -100, 100, 0.01)   -- create the PID for pitch angle control (elevator trim), values found experimentally
local altitude_pid = PID(1.5, 0.01, 0.11, -100, 100, 0.01)   -- create the PID for altitude control (elevator trim), values found experimentally

--APC PID
local apc_pid = PID(5, 0.02, 0.1, -100, 40, 0.01)   -- create the PID for the APC, values found experimentally

--APC control numbers
local ThrottleUp = 1032
local ThrottleDown = 1033
local ThrottleAxis = 2004

--AFCS Heading Indicator
local AFCS_HDG_100s_param = get_param_handle("AFCS_HDG_100s")
local AFCS_HDG_10s_param = get_param_handle("AFCS_HDG_10s")
local AFCS_HDG_1s_param = get_param_handle("AFCS_HDG_1s")

--Commands AFCS
dev:listen_command(device_commands.afcs_standby)
dev:listen_command(device_commands.afcs_engage)
dev:listen_command(device_commands.afcs_hdg_sel)
dev:listen_command(device_commands.afcs_alt)
dev:listen_command(device_commands.afcs_hdg_set)
dev:listen_command(device_commands.afcs_stab_aug)
dev:listen_command(device_commands.afcs_ail_trim)

--Keys to manipulate the panel
dev:listen_command(Keys.AFCSOverride)
dev:listen_command(Keys.AFCSStandbyToggle)
dev:listen_command(Keys.AFCSStabAugToggle)
dev:listen_command(Keys.AFCSEngageToggle)
dev:listen_command(Keys.AFCSAltitudeToggle)
dev:listen_command(Keys.AFCSHeadingToggle)
dev:listen_command(Keys.AFCSHeadingInc)
dev:listen_command(Keys.AFCSHeadingDec)
--These appear to be shortcuts for certain combinations
dev:listen_command(Keys.AFCSHotasMode)      -- for warthog
dev:listen_command(Keys.AFCSHotasPath)      -- for warthog
dev:listen_command(Keys.AFCSHotasAltHdg)    -- for warthog
dev:listen_command(Keys.AFCSHotasAlt)       -- for warthog
dev:listen_command(Keys.AFCSHotasEngage)    -- for warthog

--Commands APC
dev:listen_command(device_commands.apc_engagestbyoff)
dev:listen_command(device_commands.apc_hotstdcold)
dev:listen_command(Keys.APCEngageStbyOff)
dev:listen_command(Keys.APCHotStdCold)

-- AFCS States
AFCS_STATE_OFF = 0
AFCS_STATE_WARMUP = 1
AFCS_STATE_STBY = 2
AFCS_STATE_ATTITUDE_ONLY = 3
AFCS_STATE_ATTITUDE_HDG = 4
AFCS_STATE_ALTITUDE_ONLY = 5
AFCS_STATE_ALTITUDE_HDG = 6
AFCS_STATE_CSS = 7

--Special Control State
AFCS_CONTROL_PATH = 0
AFCS_CONTROL_ALT_HDG = 1
AFCS_CONTROL_ALT = 2

--Constant
local afcs_warmup_time = 90 --seconds

-- AFCS initialization
local afcs_standby_enabled = false
local afcs_engage_enabled = false
local afcs_engage_enabled_switch = false --switch position can be different from the engaged state
local afcs_hdg_sel_enabled = false
local afcs_alt_hold_enabled = false
local afcs_ail_trim_enabled = true
local afcs_stab_aug_enabled = false
local afcs_css_enabled = false
local afcs_control_state = AFCS_CONTROL_ALT_HDG


--State information
local afcs_state = AFCS_STATE_OFF
local afcs_warmup_count = 0
local afcs_warmed_up = false

--Current targets
local afcs_bank_angle_hold = 0
local afcs_pitch_angle_hold = 0
local afcs_altitude_hold = 0
local afcs_heading_hold = 0

-- APC initialization
local apc_enabled = false
local apc_inputlist = {"OFF", "STBY", "ENGAGE"}     -- -1,0,1
local apc_input = "OFF"
local apc_modelist = {"COLD", "STD", "HOT"}         -- -1,0,1
local apc_warmup_timer = 99999
local apc_warm = false
local apc_state = "apc-off"
local speedHold = -100
local apc_light = get_param_handle("APC_LIGHT")

--APC States
APC_OFF = 0
APC_STBY = 1
APC_ACTIVE = 2

--APC modes
APC_MODE_COLD = 0
APC_MODE_STD = 1
APC_MODE_HOT = 2

--[[
The commands are handled somewhat differently in this file.

To avoid this becoming a rats nest of if statements a table is instead used with the command number as the key to a function.
The function is then called with the value for that command.

The table command_table has the key,value pairs for commands,function ptrs.
]]
--AFCS COMMAND CALLBACKS
function afcs_standby(value)
    afcs_standby_enabled = (value == 1)
end

function afcs_hdg_set(value)
    if value > 0 then
        afcs_heading_hold = afcs_heading_hold + 1
    elseif value < 0 then
        afcs_heading_hold = afcs_heading_hold - 1
    end

    if afcs_heading_hold >= 360 then
        afcs_heading_hold = afcs_heading_hold - 360
    end

    if afcs_heading_hold < 0 then
        afcs_heading_hold = afcs_heading_hold + 360
    end
end

function afcs_engage(value)
    afcs_engage_enabled = (value == 1)
    afcs_engage_enabled_switch = afcs_engage_enabled

    if not afcs_engage_enabled then
        dev:performClickableAction(device_commands.afcs_hdg_sel,0,false)
        dev:performClickableAction(device_commands.afcs_alt,0,false)
    end
end

function afcs_heading(value)
    afcs_hdg_sel_enabled = (value == 1)
end

function afcs_altitude(value)
    afcs_alt_hold_enabled = (value == 1)
end

function afcs_stab_aug(value)
    afcs_stab_aug_enabled = (value == 1)
end

function afcs_override(value)
    dev:performClickableAction(device_commands.afcs_engage, 0, false)
end

function afcs_ail_trim(value)
    afcs_ail_trim_enabled = (value == 1)
end

--AFCS Callbacks that manipulate the panel only.
function afcs_standby_toggle()
    dev:performClickableAction(device_commands.afcs_standby,afcs_standby_enabled and 0 or 1,false)
end

function afcs_stab_aug_toggle()
    dev:performClickableAction(device_commands.afcs_stab_aug,afcs_stab_aug_enabled and 0 or 1,false)
end

function afcs_engage_toggle()
    dev:performClickableAction(device_commands.afcs_engage,afcs_engage_enabled_switch and 0 or 1,false)
end

function afcs_altitude_toggle()
    dev:performClickableAction(device_commands.afcs_alt,afcs_alt_hold_enabled and 0 or 1,false)
end

function afcs_heading_toggle()
    dev:performClickableAction(device_commands.afcs_hdg_sel,afcs_hdg_sel_enabled and 0 or 1,false)
end

--AFCS Callbacks that input special combinations
function afcs_hotas_path()
    afcs_control_state = AFCS_CONTROL_PATH
    dev:performClickableAction(device_commands.afcs_hdg_sel, 0, false)
    dev:performClickableAction(device_commands.afcs_alt, 0, false)
end

function afcs_hotas_alt_hdg()
    afcs_control_state = AFCS_CONTROL_ALT_HDG
    dev:performClickableAction(device_commands.afcs_hdg_sel, 1, false)
    dev:performClickableAction(device_commands.afcs_alt, 1, false)
end

function afcs_hotas_alt()
    afcs_control_state = AFCS_CONTROL_ALT
    dev:performClickableAction(device_commands.afcs_hdg_sel, 0, false)
    dev:performClickableAction(device_commands.afcs_alt, 1, false)
end

function afcs_hotas_engage()
    if afcs_engage_enabled_switch then
        dev:performClickableAction(device_commands.afcs_engage, 0, false)
    else
        if afcs_control_state == AFCS_CONTROL_PATH then
            dev:performClickableAction(device_commands.afcs_hdg_sel, 0, false)
            dev:performClickableAction(device_commands.afcs_alt, 0, false)
            dev:performClickableAction(device_commands.afcs_engage, 1, false)
        elseif afcs_control_state == AFCS_CONTROL_ALT_HDG then
            dev:performClickableAction(device_commands.afcs_hdg_sel, 1, false)
            dev:performClickableAction(device_commands.afcs_alt, 1, false)
            dev:performClickableAction(device_commands.afcs_engage, 1, false)
        elseif afcs_control_state == AFCS_CONTROL_ALT then
            dev:performClickableAction(device_commands.afcs_hdg_sel, 0, false)
            dev:performClickableAction(device_commands.afcs_alt, 1, false)
            dev:performClickableAction(device_commands.afcs_engage, 1, false)
        end
    end
end

--APC COMMAND CALLBACKS
function apc_engagestbyoff(value)
    apc_input = apc_inputlist[ round(value+2) ] -- convert -1,0,1 to 1,2,3
end

function apc_hotstdcold(value)
    apc_mode = apc_modelist[ round(value+2) ]   -- convert -1,0,1 to 1,2,3
end

function APCEngageStbyOff(value)
    dev:performClickableAction(device_commands.apc_engagestbyoff, value, false)
end

function APCHotStdCold(value)
    dev:performClickableAction(device_commands.apc_hotstdcold, value, false)
end

--Table of functions for each possible input as a key.
--This must be defined below any functions that are included such that the correct function ptr is not nil.
local command_table = {
    --[<command number>] = <function callback>
    [device_commands.afcs_standby] = afcs_standby,
    [device_commands.afcs_hdg_set] = afcs_hdg_set,
    [device_commands.afcs_engage] = afcs_engage,
    [device_commands.afcs_alt] = afcs_altitude,
    [device_commands.afcs_hdg_sel] = afcs_heading,
    [device_commands.afcs_stab_aug] = afcs_stab_aug,
    [device_commands.afcs_ail_trim] = afcs_ail_trim,

    --Keys
    [Keys.AFCSOverride] = afcs_override,
    [Keys.AFCSStandbyToggle] = afcs_standby_toggle,
    [Keys.AFCSStabAugToggle] = afcs_stab_aug_toggle,
    [Keys.AFCSEngageToggle] = afcs_engage_toggle,
    [Keys.AFCSAltitudeToggle] = afcs_altitude_toggle,
    [Keys.AFCSHeadingToggle] = afcs_heading_toggle,
    --Special Hotas Keys
    [Keys.AFCSHotasPath] = afcs_hotas_path,
    [Keys.AFCSHotasAltHdg] = afcs_hotas_alt_hdg,
    [Keys.AFCSHotasAlt] = afcs_hotas_alt,
    [Keys.AFCSHotasEngage] = afcs_hotas_engage,

    [device_commands.apc_engagestbyoff] = apc_engagestbyoff,
    [device_commands.apc_hotstdcold] = apc_hotstdcold,
    [Keys.APCEngageStbyOff] = APCEngageStbyOff,
    [Keys.APCHotStdCold] = APCHotStdCold,
}


function post_initialize()

    afcs_engage_enabled = false
    afcs_engage_enabled_switch = false
    afcs_hdg_sel_enabled = false
    afcs_alt_hold_enabled = false
    afcs_ail_trim_enabled = false
    afcs_css_enabled = false
    
    afcs_heading_hold = 0
    
    local birth = LockOn_Options.init_conditions.birth_place
    if birth == "GROUND_HOT" or birth == "AIR_HOT" then
        --Enable the afcs and stab aug switches
        afcs_standby_enabled = true
        afcs_stab_aug_enabled = true
        afcs_state = AFCS_STATE_STBY

        --Set AFCS to be warmed up.
        afcs_warmup_count = afcs_warmup_time
        afcs_warmed_up = true

    elseif birth == "GROUND_COLD" then
        afcs_standby_enabled = false
        afcs_stab_aug_enabled = false
        afcs_state = AFCS_STATE_OFF
    end

    dev:performClickableAction(device_commands.apc_engagestbyoff,-1,true) --disable APC by default

    --Switches are synced to the states stored in this file on load.
    sync_switches()
end

function SetCommand(command, value)
    --print_message_to_user("AFCS ".. command .. "," .. tostring(value))
    if command_table[command] == nil then
        return
    end
    --get the callback and call it with the value
    command_table[command](value)
end

function sync_switches()
    dev:performClickableAction(device_commands.afcs_standby,   afcs_standby_enabled and 1 or 0,  false)
    dev:performClickableAction(device_commands.afcs_engage,    afcs_engage_enabled and 1 or 0,   false)
    dev:performClickableAction(device_commands.afcs_stab_aug,  afcs_stab_aug_enabled and 1 or 0, false)
    dev:performClickableAction(device_commands.afcs_hdg_sel,   afcs_hdg_sel_enabled and 1 or 0,  false)
    dev:performClickableAction(device_commands.afcs_alt,       afcs_alt_hold_enabled and 1 or 0, false)
    dev:performClickableAction(device_commands.afcs_ail_trim,  afcs_ail_trim_enabled and 1 or 0, false)
end

--AFCS Functions
function afcs_check_engage_params()

    local state = afcs_get_current_state()

    local bank_angle = math.deg(sensor_data.getRoll())
    local pitch_angle = math.deg(sensor_data.getPitch())
    if math.abs(bank_angle) > 70.0 or math.abs(pitch_angle) > 60.0 then
        --print_message_to_user("Override Off")
        return false
    end

    if state == AFCS_STATE_ALTITUDE_HDG or state == AFCS_STATE_ALTITUDE_ONLY then
        --20 m/s = 4000 ft/min
        if math.abs(sensor_data.getVerticalVelocity()) > 20.0 then
            --print_message_to_user("Override Off")
            return false
        end
    end

    return true

end

function afcs_check_switches()
    if afcs_state == AFCS_STATE_OFF then
        dev:performClickableAction(device_commands.afcs_engage,0,false)
        dev:performClickableAction(device_commands.afcs_stab_aug,0,false)
        dev:performClickableAction(device_commands.afcs_hdg_sel,0,false)
        dev:performClickableAction(device_commands.afcs_alt,0,false)
    end

    if afcs_ail_trim_enabled then
        dev:performClickableAction(device_commands.afcs_engage,0,false)
    end
end


--Returns the current state of the autopilot based on the state of each setting.
function afcs_get_current_state()

    if not afcs_standby_enabled or not get_elec_primary_ac_ok() or not get_elec_mon_dc_ok() then
        return AFCS_STATE_OFF
    elseif not afcs_warmed_up then
        return AFCS_STATE_WARMUP
    elseif not afcs_engage_enabled or not get_hyd_utility_ok() then
        return AFCS_STATE_STBY
    elseif afcs_css_enabled then
        return AFCS_STATE_CSS
    elseif afcs_hdg_sel_enabled then
        if afcs_alt_hold_enabled then
            return AFCS_STATE_ALTITUDE_HDG
        else
            return AFCS_STATE_ATTITUDE_HDG
        end
    else
        if afcs_alt_hold_enabled then
            return AFCS_STATE_ALTITUDE_ONLY
        else
            return AFCS_STATE_ATTITUDE_ONLY
        end
    end
end

function print_state(state)
    state_names = {}

    state_names[AFCS_STATE_OFF] = "AFCS_STATE_OFF"
    state_names[AFCS_STATE_STBY] = "AFCS_STATE_STBY"
    state_names[AFCS_STATE_ATTITUDE_ONLY] = "AFCS_STATE_ATTITUDE_ONLY"
    state_names[AFCS_STATE_ATTITUDE_HDG] = "AFCS_STATE_ATTITUDE_HDG"
    state_names[AFCS_STATE_ALTITUDE_ONLY] = "AFCS_STATE_ALTITUDE_ONLY"
    state_names[AFCS_STATE_ALTITUDE_HDG] = "AFCS_STATE_ALTITUDE_HDG"
    state_names[AFCS_STATE_CSS] = "AFCS_STATE_CSS"
    state_names[AFCS_STATE_WARMUP] = "AFCS_STATE_WARMUP"

    print_message_to_user(state_names[state])
end

function print_state_transition(from, to)
    state_names = {}

    state_names[AFCS_STATE_OFF] = "AFCS_STATE_OFF"
    state_names[AFCS_STATE_STBY] = "AFCS_STATE_STBY"
    state_names[AFCS_STATE_ATTITUDE_ONLY] = "AFCS_STATE_ATTITUDE_ONLY"
    state_names[AFCS_STATE_ATTITUDE_HDG] = "AFCS_STATE_ATTITUDE_HDG"
    state_names[AFCS_STATE_ALTITUDE_ONLY] = "AFCS_STATE_ALTITUDE_ONLY"
    state_names[AFCS_STATE_ALTITUDE_HDG] = "AFCS_STATE_ALTITUDE_HDG"
    state_names[AFCS_STATE_CSS] = "AFCS_STATE_CSS"
    state_names[AFCS_STATE_WARMUP] = "AFCS_STATE_WARMUP"
    
    print_message_to_user(tostring(state_names[from]).." -> "..tostring(state_names[to]))
end

function afcs_transition_state(from, to)

    
    --print_state_transition(from, to)

    if to == AFCS_STATE_ALTITUDE_ONLY then
        afcs_bank_angle_hold = math.deg(sensor_data.getRoll())
        roll_pid:reset(roll_trim_handle:get())

        --Don't reset altitude if we are comming from another mode with altitude
        if from ~= AFCS_STATE_ALTITUDE_HDG then
            altitude_pid:reset(pitch_trim_handle:get())
            afcs_altitude_hold = sensor_data.getBarometricAltitude()
        end

    elseif to == AFCS_STATE_ALTITUDE_HDG then
        afcs_bank_angle_hold = 0
        roll_pid:reset(roll_trim_handle:get())

        --Don't reset altitude if we are comming from another mode with altitude
        if from ~= AFCS_STATE_ALTITUDE_ONLY then
            altitude_pid:reset(pitch_trim_handle:get())
            afcs_altitude_hold = sensor_data.getBarometricAltitude() 
        end

    elseif to == AFCS_STATE_ATTITUDE_ONLY then

        afcs_bank_angle_hold = math.deg(sensor_data.getRoll())
        afcs_pitch_angle_hold = math.deg(sensor_data.getPitch())

        pitch_pid:reset(pitch_trim_handle:get())
        roll_pid:reset(roll_trim_handle:get())

    elseif to == AFCS_STATE_ATTITUDE_HDG then
        afcs_bank_angle_hold = 0
        afcs_pitch_angle_hold = math.deg(sensor_data.getPitch())
        pitch_pid:reset(pitch_trim_handle:get())
        roll_pid:reset(roll_trim_handle:get())

    elseif to == AFCS_STATE_STBY then
        --Not sure whether to reset the roll trim here. Some people may want it
        --to preserve the trim after the attitude control has corrected others
        --may want to reset.
        --roll_trim_handle:set(0.0)
    elseif to == AFCS_STATE_OFF then
        --print_message_to_user("AFCS Warmup Count "..tostring(afcs_warmup_count))
    end
end

function afcs_hold_bank(angle)
    local bank_angle = math.deg(sensor_data.getRoll())
    local roll_trim = clamp(roll_pid:run(angle, bank_angle), -1, 1)
    roll_trim_handle:set(roll_trim)
end

function afcs_hold_pitch(angle)
    local pitch_angle = math.deg(sensor_data.getPitch())
    local pitch_trim = clamp(pitch_pid:run(angle, pitch_angle), -1, 1)
    pitch_trim_handle:set(pitch_trim)
end

function afcs_hold_altitude(altitude_hold_m)
    -- first calculate desired rate of climb, based on delta between target and current altitude  (cannot directly control elevator to altitude)
    -- TODO: integrate with trim system (provide offset inputs)
    local cur_altitude_m

    radarHold = 0
    if radarHold > 0 then
        cur_altitude_m = sensor_data.getRadarAltitude()
    else
        cur_altitude_m = sensor_data.getBarometricAltitude()
    end

    local alt_delta = altitude_hold_m-cur_altitude_m
    local ias = sensor_data.getIndicatedAirSpeed() * MPS_TO_KNOTS
    local target_climb_rate
    if alt_delta >= 0 then
        target_climb_rate = 30  -- 30m/s == 5905ft/min
    else
        target_climb_rate = -30  -- -30m/s == -5905/min
    end
    if math.abs(alt_delta)<(600/3.28084) then  -- start levelling out below 600ft delta
        target_climb_rate = target_climb_rate * (math.abs(alt_delta)/(600/3.28084))
    end
    -- now control elevators to get desired climb rate
    local cur_climb_rate = sensor_data.getVerticalVelocity()
    --debug_print_afcs("t.climb:"..string.format("%.2f",target_climb_rate).."m/s,c.climb:"..string.format("%.2f",cur_climb_rate).."m/s,t.alt:"..string.format("%.2f",altitude_hold_m)..",c.alt:"..string.format("%.2f",cur_altitude_m))
    if ias > 450 then
        altitude_pid:set_Kp(0.5)
        altitude_pid:set_Ki(0.007)
    else
        altitude_pid:set_Kp(1.5)
        altitude_pid:set_Ki(0.01)
    end

    local altitude_trim = altitude_pid:run( target_climb_rate, cur_climb_rate )
    if altitude_trim>1 then
        altitude_trim=1
    elseif altitude_trim<-1 then
        altitude_trim=-1
    end

    pitch_trim_handle:set(altitude_trim)
end

function afcs_auto_trim_pitch()
    local current_pitch_trim = pitch_trim_handle:get()
    local current_stick = efm_data_bus.fm_getPitchInput()

    local desired_g = current_stick * 9.0 + 1.0
    local current_g = sensor_data.getVerticalAcceleration()

    --Trim to minimise pitch to zero
    local new_pitch_trim = current_pitch_trim + (desired_g - current_g)/300.0
    pitch_trim_handle:set(new_pitch_trim)
end

function afcs_find_heading_desired_bank_angle()
    
    local current_state = afcs_get_current_state()

    local desired_heading_hold = afcs_heading_hold

    --Are we rolling out because we are no longer in heading mode.
    local rolling_out = false
    if current_state ~= AFCS_STATE_ATTITUDE_HDG and current_state ~= AFCS_STATE_ALTITUDE_HDG then
        desired_heading_hold = math.deg(sensor_data.getMagneticHeading())
        rolling_out = true
    end
    
    local heading = math.deg(sensor_data.getMagneticHeading()) % 360

    local left = (heading - desired_heading_hold) % 360
    local right = (desired_heading_hold - heading) % 360

    local bank_angle
    local delta_hdg

    local current_bank_angle = math.deg(sensor_data.getRoll())

    local bank_rate = 1

    if left < right then
        delta_hdg = -left
        bank_angle = clamp(current_bank_angle - bank_rate, -27, 27)
    else
        delta_hdg = right
        bank_angle = clamp(current_bank_angle + bank_rate, -27, 27)
    end
    

    --bank_angle = bank_angle * (clamp(math.abs(current_bank_angle / 27.5), 0.0, 1.0) + 0.1)

    if (math.abs(delta_hdg) < 4 and not rolling_out ) then
        bank_angle = bank_angle * math.abs(delta_hdg) / 5.0 --this is just a P from a PID loop
        --bank_angle = bank_angle + (desired_bank_angle - bank_angle) / 100.0
    end

    return bank_angle
end


--Switch between these if the user is using FFB.
DEFAULT_CSS_DEFLECTION = 0.03
FFB_CSS_DEFLECTION = optionsData_ffbCSSActivate or 0.15

function afcs_check_for_css()

    local required_css_deflection = DEFAULT_CSS_DEFLECTION

    if efm_data_bus.fm_getUsingFFB() == 1.0 then
        required_css_deflection = FFB_CSS_DEFLECTION
    end

    if math.abs(efm_data_bus.fm_getPitchInput()) > required_css_deflection or math.abs(efm_data_bus.fm_getRollInput()) > required_css_deflection  then
        afcs_css_enabled = true
        dev:performClickableAction(device_commands.afcs_hdg_sel,0,false)
        dev:performClickableAction(device_commands.afcs_alt,0,false)
    else
        --We must try and disengage the css mode.
        --We must check if this is allowed so disable afcs_ccs_enabled to check the state.
        afcs_css_enabled = false

        --If we cannot disable the css mode then we most go back to css.
        if not afcs_check_engage_params() then
            afcs_css_enabled = true
        end

    end
end

function afcs_check_limits()
    g_force = sensor_data.getVerticalAcceleration()


    --TODO adjust this for centerline stores
    --[[
    The AFCS is automatically disengaged and the engage switch automatically moved to the OFF position when
    normal load factor approaches 4 +/- 0.5 positive-g or 1.5 +/- 0.5 negative-g, or when the aileron surface displacement exceeds 20 degrees,
    one-half lateral stick displacement from neutral. Normal acceleration values are reduced to 3.5 +/- 0.5 positive-g and 1 +/- 0.5 negative-g
    when a centreline store is carried, except when operating in CSS mode. (Refer to Control Stick Steering Mode.)

    The AFCS is also disengaged when the ailerons are deflected more than 50%, in this case the stick deflection is used.
    TODO: change to aileron deflection.
    ]]--
    if g_force > 4 or g_force < -1.5 then
        dev:performClickableAction(device_commands.afcs_engage,0,false)
    elseif math.abs(efm_data_bus.fm_getRollInput()) > 0.5 then
        dev:performClickableAction(device_commands.afcs_engage,0,false)
        roll_trim_handle:set(0.0)
    end



end

--Are we allowed to engage from this state
function afcs_allowed_to_engage_from_state(from)
    --There is only one disallowed transition: from AFCS_STATE_WARMUP -> any engaged state.
    --This transition must always go to standby first.
    if from == AFCS_STATE_WARMUP then
        return false
    else
        return true
    end
end

function update_afcs()

    --enable/disable the afcs stability augmentation
    --Don't need to check AFCS_STATE_OFF because this switch cannot be on with that set to off.
    --Do however need to check AFCS_STATE_WARMUP because it's possible to have this switch on in that state.
    if afcs_stab_aug_enabled and afcs_state ~= AFCS_STATE_WARMUP and get_hyd_utility_ok() and get_elec_primary_dc_ok() and get_elec_primary_ac_ok() then
        efm_data_bus.fm_setYawDamper(1.0)
    else
        efm_data_bus.fm_setYawDamper(0.0)
    end

    --switch based on the state and apply the various types of hold
    --early return for stdby/off positions
    if afcs_state == AFCS_STATE_OFF then
        
        --Degrade the warmup at 3 times the rate of warmup
        --This is a made up value, it just makes sense that the warmup
        --wouldn't take 90 seconds after switching it off and then back off
        --again very quickly.
        if afcs_warmup_count >= 0 then
            --print_message_to_user("AFCS Warmup count: "..afcs_warmup_count)
            afcs_warmup_count = afcs_warmup_count - update_time_step * 3
        end

        if afcs_warmup_count < afcs_warmup_time then
            afcs_warmed_up = false
        end
        return
    elseif afcs_state == AFCS_STATE_STBY then
        return
    elseif afcs_state == AFCS_STATE_WARMUP then
        afcs_warmup_count = afcs_warmup_count + update_time_step
        --print_message_to_user("AFCS Warmup count: "..afcs_warmup_count)
        if afcs_warmup_count > afcs_warmup_time then
            --print_message_to_user("AFCS_WARMED_UP")
            afcs_warmed_up = true
        end
        return
    elseif afcs_state == AFCS_STATE_ATTITUDE_ONLY then
        afcs_hold_bank(afcs_bank_angle_hold)
        afcs_hold_pitch(afcs_pitch_angle_hold)
    elseif afcs_state == AFCS_STATE_ATTITUDE_HDG then
        afcs_hold_bank(afcs_find_heading_desired_bank_angle())
        afcs_hold_pitch(afcs_pitch_angle_hold)
    elseif afcs_state == AFCS_STATE_ALTITUDE_ONLY then
        afcs_hold_bank(afcs_bank_angle_hold)
        afcs_hold_altitude(afcs_altitude_hold)
    elseif afcs_state == AFCS_STATE_ALTITUDE_HDG then
        afcs_hold_bank(afcs_find_heading_desired_bank_angle())
        afcs_hold_altitude(afcs_altitude_hold)
    elseif afcs_state == AFCS_STATE_CSS then
        afcs_auto_trim_pitch()
    end


    --see if we should enter into css mode
    afcs_check_for_css()

    --see if we should disengage
    afcs_check_limits()

    
end

function afcs_update_transition(from, to)

    if to == AFCS_STATE_ALTITUDE_ONLY then
        if from == AFCS_STATE_ALTITUDE_HDG and math.abs(sensor_data.getRoll()) > 0.01 then
            return false
        end
    elseif to == AFCS_STATE_ATTITUDE_ONLY then
        if from == AFCS_STATE_ATTITUDE_HDG and math.abs(sensor_data.getRoll()) > 0.01 then
            return false
        end
    end

    return true
end

function update()

    afcs_check_switches()
    local temp_state = afcs_get_current_state()

    --State change
    if temp_state ~= afcs_state then
        --Check if this state change is allowed with the current condition
        afcs_engage_enabled = afcs_engage_enabled and afcs_allowed_to_engage_from_state(afcs_state) and afcs_check_engage_params()

        --Update the possible new state
        temp_state = afcs_get_current_state()
        --Actually transition if this state is not the same as our current state.
        if temp_state ~= afcs_state and afcs_update_transition(afcs_state, temp_state) then
            afcs_transition_state(afcs_state, temp_state)
            --Update state after transition
            afcs_state = temp_state
        end
    end
    
    

    --Calculate heading rotarys
    local hdg=afcs_heading_hold
    local _100s=math.floor(hdg/100)/10
    local _10s=math.floor((hdg%100)/10)/10
    local _1s=math.floor(hdg%10)/10

    --Set in-cockpit display
    AFCS_HDG_100s_param:set(_100s)
    AFCS_HDG_10s_param:set(_10s)
    AFCS_HDG_1s_param:set(_1s)

    --Calculate inputs
    update_afcs()
    update_apc()
    update_throttle_buttons()

end

--Update throttle clickables based on throttle position
local prev_throttle_lever=0
function update_throttle_buttons()
    local throttle_lever=get_cockpit_draw_argument_value(80)
    if prev_throttle_lever ~= throttle_lever then
        local lights_clickable_ref = get_clickable_element_reference("PNT_83")
        lights_clickable_ref:update() -- ensure the connector moves too
        local speedbrake_clickable_ref = get_clickable_element_reference("PNT_85")
        speedbrake_clickable_ref:update() -- ensure the connector moves too
        prev_throttle_lever = throttle_lever
    end
end

function debug_print_apc(s)
    --stub
end

function update_apc()
    local timenow = get_model_time()

    --apc_throttle = apc_pid(sensor_data.getAngleOfAttack())
    local aoadeg
    local apc_target

    if speedHold > 0 then
        tas = -math.sqrt(sensor_data.getTrueAirSpeed())
        tastarget = -math.sqrt(speedHold)
    else
        aoadeg = efm_data_bus.fm_getAOAUnits()
        apc_target = 306.25  -- (8.75^2)
    end

    if apc_mode == "HOT" then
        apc_target = 324      -- (9)^2
    elseif apc_mode == "COLD" then
        apc_target = 289       -- (8.5)^2
    end

    if speedHold > 0 then
        apc_throttle = apc_pid:run( tastarget, tas )
        --print_message_to_user(tastarget.." "..tas.." "..apc_throttle)
    else
        apc_throttle = apc_pid:run( apc_target, aoadeg*aoadeg )
    end

    if not get_elec_mon_dc_ok() then
        apc_light:set(0.0)
        apc_warm = false
        apc_warmup_timer = 99999
        if apc_state ~= "apc-off" then
            debug_print_apc("APC: 28V monitored DC power lost, disabling system")
            dev:performClickableAction(device_commands.apc_engagestbyoff, 0, false)
            apc_state = "apc-off"
        end
        return
    end

    if not apc_warm and timenow >= apc_warmup_timer and apc_state == "apc-standby" then
        apc_warm = true
        debug_print_apc("APC: warmup complete, time:"..timenow)
    end

    if apc_state == "apc-off" then
        apc_light:set(0.0)
        apc_warm = false
        if apc_input == "STBY" then
            debug_print_apc("APC: warmup starting, time:"..timenow)
            apc_warmup_timer = timenow+15
            apc_state = "apc-standby"
        elseif apc_input == "ENGAGE" then apc_state = "apc-disengage"
        end
    elseif apc_state == "apc-standby" then
        apc_light:set(1.0)
        if apc_input == "OFF" then apc_state = "apc-off"
        elseif apc_input == "ENGAGE" then apc_state = "apc-engaged"
        end
    elseif apc_state == "apc-disengage" then
        debug_print_apc("APC: disengaged")
        apc_state = "apc-standby"
        apc_input = "STBY"
        dev:performClickableAction(device_commands.apc_engagestbyoff, 0, true) -- bounces switch back to middle
    elseif apc_state == "apc-engaged" then
        if apc_input == "OFF" then apc_state = "apc-off"
        elseif apc_input == "STBY" then apc_state = "apc-standby"
        elseif not apc_warm then apc_state = "apc-disengage"
        else
            local tpos = sensor_data.getThrottleLeftPosition()
            local wow = sensor_data.getWOW_LeftMainLandingGear()
            if tpos < 0.25 or wow > 0 then
                apc_state = "apc-disengage"     -- kick APC to standby if pilot adjusts throttle below 25% or weight on wheels
            end
            -- APC will now operate
            apc_light:set(0.0)
            dispatch_action(nil, ThrottleAxis, (apc_throttle * 0.999))
        end
    end
end

need_to_be_closed = false -- close lua state after initialization