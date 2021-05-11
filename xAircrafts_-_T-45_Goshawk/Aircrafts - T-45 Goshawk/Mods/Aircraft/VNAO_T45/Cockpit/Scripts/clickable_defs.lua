cursor_mode = 
{ 
    CUMODE_CLICKABLE = 0,
    CUMODE_CLICKABLE_AND_CAMERA  = 1,
    CUMODE_CAMERA = 2,
};

clickable_mode_initial_status  = cursor_mode.CUMODE_CLICKABLE

direction						= 1
cyclic_by_default				= true -- to cycle two-way thumblers or not by default
anim_speed_default				= 16


function default_button(hint_,device_,command_,arg_,animation_speed_)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return  {
				class				= {class_type.BTN},
				hint				= hint_,
				device				= device_,
				action				= {command_},
				stop_action 		= {command_},
				arg					= {arg_},
				arg_value			= {1},
				arg_lim 			= {{0,1}},
				use_release_message	= {true},
				animated			= {true},
			    animation_speed		= {animation_speed_},
				sound				= {{SWITCH_SOUND_3}}
			}
end

function default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return  {
				class			= {class_type.TUMB,class_type.TUMB},
				hint			= hint_,
				device			= device_,
				action			= {command_,command_},
				arg				= {arg_,arg_},
				arg_value		= {1,-1},
				arg_lim			= {{0,1},{0,1}},
				updatable		= true,
				use_OBB			= true,
				animated		= {true,true},
			    animation_speed	= {animation_speed_,animation_speed_},
				sound			= {{SWITCH_SOUND_1}}
			}
end


function default_3_position_tumb(hint_,device_,command_,arg_,cycled_,animation_speed_,inversed_,arg_value_,arg_limit_)
	local cycled = false
	if cycled_ ~= nil then
	   cycled = cycled_
	end
	local	animation_speed_ = animation_speed_ or anim_speed_default
	local	arg_value = arg_value_ or 1
	if inversed_ then
		arg_value = -arg_value
	end
	local	arg_limit = arg_limit_ or {-1,1}
	return  {
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-arg_value, arg_value},
				arg_lim   	= {arg_limit,arg_limit},
				updatable 	= true,
				use_OBB 	= true,
				cycle       = cycled,
				animated		= {true,true},
			    animation_speed	= {animation_speed_,animation_speed_},
				sound			= {{SWITCH_SOUND_1}}
			}
end

function multiposition_switch(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,animation_speed_,cycled_)
    local	min_   = min_ or 0
	local	delta_ = delta_ or 0.5
	
	local	inversed = 1
	if	inversed_ then
		inversed = -1
	end
	local	animation_speed_ = animation_speed_ or anim_speed_default
	local	cycled = true
	if cycled_ ~= nil then
	   cycled = cycled_
	end	
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-delta_ * inversed,delta_ * inversed}, 
				arg_lim   	= {{min_, min_ + delta_ * (count_ -1)},
							   {min_, min_ + delta_ * (count_ -1)}},
				updatable 	= true, 
				use_OBB 	= true,
				cycle       = cycled,
				animated		= {true,true},
			    animation_speed	= {animation_speed_,animation_speed_},
				sound			= {{SWITCH_SOUND_1}}
			}
end

function multiposition_switch_cl(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,animation_speed_,cycled_)
    local	element = multiposition_switch(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,animation_speed_,cycled_)
	element.anim_close_ends	= {true, true}
	return  element
end

function switch_button_3pos(hint_,device_,command1_,arg_,animation_speed_) -- left click between 2 positions, right click for momentary 3rd position
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return  {
				class			= {class_type.TUMB,class_type.BTN},
				hint			= hint_,
				device			= device_,
				action			= {command1_,command1_},
				stop_action		= {0,command1_},
				arg				= {arg_,arg_},
				stop_value 		= {nil,	0.5},
				arg_value		= {0.5,1},
				arg_lim			= {{0,0.5},{0.5,1}},
				updatable		= true,
				use_release_message = {true,false},
				sound			= {{SWITCH_SOUND_2},{SWITCH_SOUND_2}}
			}
end

function springloaded_2_pos_tumb(hint_,device_,command_,arg_,animation_speed_)
    local	element = default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_)
	element.class		= {class_type.BTN,class_type.BTN}
	element.stop_action = {command_, command_}
	element.arg_value	= {1,1}
	element.sound		= {{SOUND_SW12_ON,SOUND_SW12_OFF},{SOUND_SW12_ON,SOUND_SW12_OFF}}
	return  element
end

function springloaded_3_pos_tumb(hint_,device_,command1_,command2_,arg_,animation_speed_,val1_,val2_,val3_)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	local	val1 = val1_ or -1.0
	local	val2 = val2_ or 0.0
	local	val3 = val3_ or 1.0
	return  {
				class			= {class_type.BTN,class_type.BTN},
				hint			= hint_,
				device			= device_,
				action			= {command1_,command2_},
				stop_action		= {command1_,command2_},
				arg				= {arg_,arg_},
				stop_value 		= {0,	0},
				arg_value		= {val3,val1},
				arg_lim			= {{val1,val2},{val2,val3}},
				updatable		= true,
				--use_OBB			= true,
				use_release_message = {true,true},
				--animated		= {true,true},
			    --animation_speed	= {animation_speed_,animation_speed_},
				sound			= {{SWITCH_SOUND_1}, {SWITCH_SOUND_1}}
			}
end

function UHF_selector(hint_,device_,command1_,arg_,animation_speed_) 
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return  {
				class			= {class_type.BTN,class_type.BTN},
				hint			= hint_,
				device			= device_,
				action			= {command1_,command1_},
				stop_action		= {command1_,command1_},
				arg				= {arg_,arg_},
				stop_value 		= {0,	0},
				arg_value		= {1,-1},
				arg_lim			= {{-1,0},{0,1}},
				updatable		= true,
				use_release_message = {true,false},
				sound			= {{SWITCH_SOUND_2},{SWITCH_SOUND_2}}
			}
end

function default_animated_lever(hint_,device_,command_,arg_,animation_speed_,arg_lim_)
	local	animation_speed_ = animation_speed_ or 3
	local	arg_lim__ = arg_lim_ or {0.0,1.0}
	
    local	element = default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_)
	element.arg_value		= {1, 0}
	element.animation_speed	= {animation_speed_, 0}
	element.sound			= {{SOUND_NOSOUND,SOUND_NOSOUND}}
	element.arg_lim   	= {arg_lim__}
	return	element
end

function default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycled_)
	local default = default_ or 1
	local gain = gain_ or 0.1
	local updatable = updatable_ or false
	local relative  = relative_ or false
	
	return  {	
				class 		= {class_type.LEV},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_},
				arg 	  	= {arg_},
				arg_value 	= {default}, 
				arg_lim   	= {{0,1}},
				updatable 	= updatable, 
				use_OBB 	= true,
				gain		= {gain},
				relative    = {relative},
				cycle 		= cycled_ or false,
				sound		= {{SOUND_NOSOUND}}
			}
end

function default_axis_limited(hint_,device_,command_,arg_,default_,gain_,updatable_,relative_,arg_lim_)
	local	default = default_ or 0
	local	updatable = updatable_ or false
	local	relative  = relative_ or false
	local	cycled_ = false
	local	arg_lim = arg_lim_ or {0,1}

	local	element = default_axis(hint_,device_,command_,arg_,default,gain_,updatable,relative,cycled_)
	element.arg_lim   	= {arg_lim}
	element.use_OBB 	= false
	return element
end


--IFF
function default_springloaded_switch(hint_, device_, command_, value1_, value2_, value3_, arg_)
	return	{
				class 		= {class_type.BTN, class_type.TUMB},
				hint 		= hint_, 
				device 		= device_,
				action  	= {command_ ,	command_}, 
				stop_action = {command_ , 	0}, 
				arg 		= {arg_,		arg_},
				stop_value 	= {value2_,		nil	},
				arg_value 	= {value1_, 	value2_},
				arg_lim 	= {{value1_, value2_}, {value2_, value3_}}, 
				use_release_message = {false, false},
				sound		= {{SOUND_SW1}},
				updatable		= true
			}
end

function IFF_Code4_multiposition_spring_switch(hint_,device_,command1_, arg_, command2_, arg2_)
	return  {	
				class 		= {class_type.BTN,class_type.BTN,class_type.LEV},
				hint  		= hint_,
				device 		= device_,
				action 		= {command1_,	command1_,	command2_},
				stop_action = {command1_,	nil,		nil},
				stop_value 	= {0.0,			nil,		nil},
				arg 	  	= {arg_,arg_,arg2_},
				arg_value 	= {-1,1,1}, 
				arg_lim   	= {{ -1, 0},
							   {0, 1},
							   {0, 1}},
				gain		= {1,1,-1},
				relative	= {false,false,true},
				cycle		= false,
				updatable 	= true, 
				--use_OBB 	= true,
				use_release_message = {true,true,false},
				sound		= {{SOUND_SW2}}
			}
end

function IFF_Master_multiposition_switch(hint_,device_,command_,arg_,animation_speed_,command2_,arg2_)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return  {
				class 			= {class_type.TUMB,class_type.TUMB,class_type.LEV},
				hint  			= hint_,
				device 			= device_,
				action 			= {command_,command_, command2_},
				arg 	  		= {arg_,arg_,arg2_},
				arg_value 		= {-0.1, 0.1, 1.0},
				arg_lim   		= {{0, 0.4},
								   {0, 0.4},
								   {0, 1.0}},
				gain			= {1,1,-1},
				relative		= {false,false,true},
				updatable 		= true,
				use_OBB 		= true,
				cycle			= false,
				animated		= {true,true,false},
			    animation_speed	= {animation_speed_,animation_speed_, 0},
				sound			= {{SOUND_SW2}}
			}
end


function default_trimmer_button(hint_,device_,command_,arg_,value_,animation_speed_)
	local	element = default_button(hint_,device_,command_,arg_,animation_speed_)
	local	value = value_ or 1
	local	lim_min = 0
	local	lim_max = value
	if value < 0 then
		lim_min = value
		lim_max = 0
	end
	element.arg_value	= {value}
	element.arg_lim 	= {{lim_min,lim_max}}
	element.animated	= {false}
	element.updatable	= true
	return	element
end

function default_button_axis(hint_,device_,command1_,command2_,arg1_,arg2_,animation_speed_)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return  {
				class				= {class_type.BTN,		class_type.LEV},
				hint				= hint_,
				device				= device_,
				action				= {command1_,			command2_},
				stop_action			= {command1_,			0},
				use_release_message	= {true,				false},
				arg					= {arg1_,				arg2_},
				gain				= {1.0,					0.2},
				relative			= {false,				false},
				arg_value			= {1,					1},
				arg_lim				= {{0, 1},				{0, 1}},
				animated			= {true,				false},
			    animation_speed		= {animation_speed_,	0.0},
				sound				= {{SOUND_SW1},			{SOUND_SW1}},
				updatable			= true,
				use_OBB				= true
			}
end

function default_air_inlet(hint_,device_,command_hor_,command_ver_,arg_hor_,arg_ver_)
	return  {
				class				= {class_type.LEV,	class_type.LEV},
				hint				= hint_,
				device				= device_,
				action				= {command_hor_,	command_ver_},
				arg					= {arg_hor_,		arg_ver_},
				arg_value			= {1,				-1},
				arg_lim				= {{-1, 1},			{-1, 1}},
				updatable			= true,
				use_OBB				= true,
				gain				= {1,				1},
				relative			= {false,			false},
				cycle 				= false,
			}
end