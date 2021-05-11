
local dev = GetSelf()
local update_time_step = 0.1
make_default_activity(update_time_step) -- enables call to update
local sensor_data = get_base_data()



local test_param = get_param_handle("TEST_PARAM")
local engineTest= get_param_handle("engineTest")
local egt = get_param_handle("EGT")
local bus = get_param_handle("ESS_SERV_BUS")
function update()


    --local pluginData =  get_plugin_option_value("VNAO_T45","cockpitType","local")
	--print_message_to_user(pluginData)
	
	
	--print_message_to_user(engineTest:get())
	--print_message_to_user(get_aircraft_draw_argument_value(0))
end

need_to_be_closed = false -- close lua state after initialization
