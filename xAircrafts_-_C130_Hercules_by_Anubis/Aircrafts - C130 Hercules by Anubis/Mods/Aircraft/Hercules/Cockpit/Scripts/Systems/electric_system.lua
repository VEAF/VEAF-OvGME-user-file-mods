dofile(LockOn_Options.script_path.."devices.lua")

local dev = GetSelf()
local electric_system

-- local efm_data_bus = get_efm_data_bus()

local update_time_step = 0.02 --EFM rate (0.006 s) or multible of 0.006 s (fastest), 0.012 s, 0.024 s, etc
make_default_activity(update_time_step)

function update()
	-- print_message_to_user(string.format("DC_Battery_voltage: %.2f", electric_system:get_DC_Bus_1_voltage()))
	-- print_message_to_user(string.format("AC_Bus_1_voltage: %.2f", electric_system:get_AC_Bus_1_voltage()))
end

local ptr_elec = get_param_handle("THIS_ELEC_PTR")

function post_initialize()
	electric_system = GetDevice(devices.ELECTRIC_SYSTEM)

    -- str_ptr = string.sub(tostring(dev.link),10)
    -- -- efm_data_bus.fm_setElecPTR(str_ptr)
	-- ptr_elec:set(str_ptr)

    electric_system:AC_Generator_1_on(true) -- A-4E generator is automatic and cannot be controlled by switches
    electric_system:AC_Generator_2_on(true) -- A-4E doesn't have a 2nd generator (since no second engine)
    electric_system:DC_Battery_on(true) -- A-4E doesn't have a battery
end

-- dev:listen_command(711)
-- dev:listen_command(712)
function SetCommand(command,value)

	-- print_message_to_user(string.format("DC_Battery_voltage: %.2f", electric_system:get_DC_Bus_1_voltage()))
	-- print_message_to_user(string.format("AC_Bus_1_voltage: %.2f", electric_system:get_AC_Bus_1_voltage()))
  -- if command == 711 then   
	-- print_message_to_user(string.format("command: %.2f", command))
	-- print_message_to_user(string.format("value: %.2f", value))
   -- electric_system:DC_Battery_on(1.0)
   -- electric_system:AC_Generator_1_on(1.0)
   -- electric_system:AC_Generator_2_on(1.0)
  -- end
  -- if command == 712 then   
	-- print_message_to_user(string.format("command: %.2f", command))
	-- print_message_to_user(string.format("value: %.2f", value))
   -- electric_system:DC_Battery_on(0.0)
   -- electric_system:AC_Generator_1_on(0.0)
   -- electric_system:AC_Generator_2_on(0.0)
  -- end
end

need_to_be_closed = false -- close lua state after initialization

