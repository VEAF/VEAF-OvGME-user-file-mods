local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices = {}
devices["RADIO1"] 					= counter() --Do not change
devices["RADIO2"] 					= counter()
devices["COMM1"]		 			= counter()
devices["COMM2"]		 			= counter()
devices["WEAPON_SYSTEM"]			= counter()
devices["CLOCK"]					= counter()
devices["EXTANIM"]					= counter()
devices["AVIONICS"]					= counter()
devices["UHF1"]		 				= counter()
devices["INTERCOM"] 				= counter()
devices["HUD"] 						= counter()
devices["MFDL"] 					= counter()
devices["MFDR"] 					= counter()
devices["DISPLAYCOMPUTER"]			= counter()
devices["DEP"]						= counter()
devices["TACAN"]					= counter()
devices["VOR_ILS"]					= counter()
devices["NAV"]					    = counter()
devices["EFM"]						= counter()
devices["ConnectorUpdater"]			= counter()



