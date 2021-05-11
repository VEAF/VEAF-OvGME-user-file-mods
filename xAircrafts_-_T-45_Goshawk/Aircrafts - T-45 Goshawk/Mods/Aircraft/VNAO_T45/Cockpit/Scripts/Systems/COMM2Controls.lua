dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.common_script_path..'Radio.lua')

dev = GetSelf()
local update_time_step = 0.1 --update will be called once per second
make_default_activity(update_time_step) 

local display_on = get_param_handle("COMM2_ON")
display_on:set(0)
local brightness = get_param_handle("COMM2_BRIGHTNESS")
brightness:set(1)
local display_frequency = get_param_handle("COMM2_FREQUENCY") -- for digital freqency readout
local frequency = 249000
display_frequency:set(frequency)
local freqTens = 240000
local freqOnes = 9000
local freqTenths = 0
local freqHundredths = 0



function post_initialize()
	dev:performClickableAction(device_commands.COMM2AMFM, 1, false)
	dev:performClickableAction(device_commands.COMM2vol, 0.8, false)
	dev:performClickableAction(device_commands.COMM2brightness, 1, false)

end

dev:listen_command(device_commands.COMM2freqTens)
dev:listen_command(device_commands.COMM2freqOnes)
dev:listen_command(device_commands.COMM2freqTenths)
dev:listen_command(device_commands.COMM2freqHundredths)
dev:listen_command(device_commands.COMM2AMFM)
dev:listen_command(device_commands.COMM2mode) 
dev:listen_command(device_commands.COMM2brightness) 



function SetCommand(command,value)
local radioDevice = GetDevice(devices.RADIO2)
	if command == device_commands.COMM2freqTens then
		freqTens = freqTens + 10000*value
		freqTens = limit(freqTens, 0, 400000)
		--print_message_to_user(value)
	elseif command == device_commands.COMM2freqOnes then
		freqOnes = freqOnes + 1000*value
		freqOnes = limit(freqOnes, 0, 9000)
	elseif command == device_commands.COMM2freqTenths then
		freqTenths = freqTenths + 100*value
		freqTenths = limit(freqTenths, 0, 900)
	elseif command == device_commands.COMM2freqHundredths then
		freqHundredths = freqHundredths + 25*value
		freqHundredths = limit(freqHundredths, 0, 75)
	elseif command == device_commands.COMM2AMFM then
		radioDevice:set_modulation(1- value) 
	elseif command == device_commands.COMM2mode then
		if value > 0 then
			display_on:set(1)
		else
			display_on:set(0)
		end
	elseif command == device_commands.COMM2brightness then
		brightness:set(value)
		
	end
	
	frequency = freqTens + freqOnes + freqTenths + freqHundredths
	display_frequency:set(frequency)
	
    radioDevice:set_frequency(frequency*1000)
   

end

function limit(input, lowerLimit, upperLimit)
	if input > upperLimit then
		input = upperLimit
	elseif input < lowerLimit then
		input = lowerLimit
	end
	return input
end


function update()
	
end

need_to_be_closed = false