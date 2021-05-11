dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.common_script_path..'Radio.lua')

dev = GetSelf()
local update_time_step = 0.1 --update will be called once per second
make_default_activity(update_time_step) 

local display_on = get_param_handle("COMM1_ON")
display_on:set(0)
local brightness = get_param_handle("COMM1_BRIGHTNESS")
brightness:set(1)
local display_frequency = get_param_handle("COMM1_FREQUENCY") -- for digital freqency readout
local frequency = 249000
display_frequency:set(frequency)
local freqTens = 240000
local freqOnes = 9000
local freqTenths = 0
local freqHundredths = 0

local INTERCOM_PTT = get_param_handle("INTERCOM_PTT")

function post_initialize()
	dev:performClickableAction(device_commands.COMM1AMFM, 1, false)
	dev:performClickableAction(device_commands.COMM1vol, 0.8, false)
	dev:performClickableAction(device_commands.COMM1brightness, 1, false)
	dev:performClickableAction(device_commands.ICSvol, 0.8, false)
end

dev:listen_command(device_commands.COMM1freqTens)
dev:listen_command(device_commands.COMM1freqOnes)
dev:listen_command(device_commands.COMM1freqTenths)
dev:listen_command(device_commands.COMM1freqHundredths)
dev:listen_command(device_commands.COMM1AMFM)
dev:listen_command(device_commands.COMM1mode) 
dev:listen_command(device_commands.COMM1brightness) 


dev:listen_command(Keys.IntercomPTT) 

function SetCommand(command,value)
local radioDevice = GetDevice(devices.RADIO1)
	if command == device_commands.COMM1freqTens then
		freqTens = freqTens + 10000*value
		freqTens = limit(freqTens, 0, 400000)
		--print_message_to_user(value)
	elseif command == device_commands.COMM1freqOnes then
		freqOnes = freqOnes + 1000*value
		freqOnes = limit(freqOnes, 0, 9000)
	elseif command == device_commands.COMM1freqTenths then
		freqTenths = freqTenths + 100*value
		freqTenths = limit(freqTenths, 0, 900)
	elseif command == device_commands.COMM1freqHundredths then
		freqHundredths = freqHundredths + 25*value
		freqHundredths = limit(freqHundredths, 0, 75)
	elseif command == device_commands.COMM1AMFM then
		radioDevice:set_modulation(1- value) 
	elseif command == device_commands.COMM1mode then
		if value > 0 then
			display_on:set(1)
		else
			display_on:set(0)
		end
	elseif command == device_commands.COMM1brightness then
		brightness:set(value)
		

	elseif command == Keys.IntercomPTT then
		INTERCOM_PTT:set(value)
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