local count = 0
local function counter()
	count = count + 1
	return count
end
devices = {}
devices["ELECTRIC_SYSTEM"]						= counter()
devices["Network_Synchronization"]				= counter()
devices["F10_Map_Coordinates_Rectangle"]		= counter()
devices["General_Device"]						= counter()
devices["Update_Connectors"]					= counter()
devices["Pylon_Release_System"]					= counter()
devices["UHF_Radio"]							= counter()
devices["INTERCOM"]								= counter()
devices["Helmet_Device"]						= counter()
devices["Clock"]								= counter()
devices["Autopilot"]							= counter()
devices["Performance_Factors"]					= counter()
devices["HerculesSounds"]						= counter()
devices["General"]								= counter()
devices["Debug"]								= counter()

