dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")


-------MATERIALS-------
materials = {}   
materials["HUD_GREEN"]			= {2,255,20,385}
materials["MFD_WHITE"]			= {240,240,240,255}

-------TEXTURES-------
textures = {}


-------FONTS----------
fontdescription = {}
dbg_drawStrokesAsWire = false
HUD_thickness = 2.0
HUD_fuzziness = 0.5
MFD_thickness = 0.9
MFD_fuzziness = 0.4

fontdescription["font_stroke_HUD_T45"] = {
	class     = "ceSLineFont",
	symb_storage = "T45_HUD_MFD_Font",
	thickness  = HUD_thickness,
	fuzziness  = HUD_fuzziness,
	draw_as_wire = dbg_drawStrokesAsWire,
	default    = {15, 20}, -- (display increments)
	chars	   = {
		 [1]   = {latin['A'], "A"},
		 [2]   = {latin['B'], "B"},
		 [3]   = {latin['C'], "C"},
		 [4]   = {latin['D'], "D"},
		 [5]   = {latin['E'], "E"},
		 [6]   = {latin['F'], "F"},
		 [7]   = {latin['G'], "G"},
		 [8]   = {latin['H'], "H"},
		 [9]   = {latin['I'], "I"},
		 [10]  = {latin['J'], "J"},
		 [11]  = {latin['K'], "K"},
		 [12]  = {latin['L'], "L"},
		 [13]  = {latin['M'], "M-alt"},
		 [14]  = {latin['N'], "N"},
		 [15]  = {latin['O'], "O"},
		 [16]  = {latin['P'], "P"},
		 [17]  = {latin['Q'], "Q"},
		 [18]  = {latin['R'], "R"},
		 [19]  = {latin['S'], "S"},
		 [20]  = {latin['T'], "T"},
		 [21]  = {latin['U'], "U"},
		 [22]  = {latin['V'], "V-alt"},
		 [23]  = {latin['W'], "W-alt"},
		 [24]  = {latin['X'], "X"},
		 [25]  = {latin['Y'], "Y"},
		 [26]  = {latin['Z'], "Z"},
		 
		 [27]  = {symbol['0'], "0"},
		 [28]  = {symbol['1'], "1"},
		 [29]  = {symbol['2'], "2"},
		 [30]  = {symbol['3'], "3"},
		 [31]  = {symbol['4'], "4-alt1"},
		 [32]  = {symbol['5'], "5-alt"},
		 [33]  = {symbol['6'], "6"},
		 [34]  = {symbol['7'], "7"},
		 [35]  = {symbol['8'], "8"},
		 [36]  = {symbol['9'], "9"},
		 
		 [37]  = {symbol['-'], "symbol-minus"},
		 [38]  = {symbol['+'], "symbol-plus"},
		 [39]  = {symbol['\''], "symbol-apostrophe"},
		 [40]  = {symbol['*'], "symbol-asterisk"},
		 [41]  = {symbol['%'], "symbol-percent"},
		 [42]  = {symbol[','], "symbol-comma"},
		 [43]  = {symbol['°'], "symbol-degree"},
		 [44]  = {symbol['.'], "symbol-period"},
		 [45]  = {symbol['/'], "symbol-slash"},
		 [46]  = {symbol['\\'], "symbol-backslash"},
		 [47]  = {symbol['\"'], "symbol-quote"},
		 [48]  = {symbol[':'], "symbol-colon"},
		 [49]  = {symbol['^'], "symbol-lambda"},

	}
}

fontdescription["font_stroke_MFD_T45"] = {
	class     = "ceSLineFont",
	symb_storage = "T45_HUD_MFD_Font",
	thickness  = MFD_thickness,
	fuzziness  = MFD_fuzziness,
	draw_as_wire = dbg_drawStrokesAsWire,
	default    = {15, 20}, -- (display increments)
	chars	   = {
		 [1]   = {latin['A'], "A"},
		 [2]   = {latin['B'], "B"},
		 [3]   = {latin['C'], "C"},
		 [4]   = {latin['D'], "D"},
		 [5]   = {latin['E'], "E"},
		 [6]   = {latin['F'], "F"},
		 [7]   = {latin['G'], "G"},
		 [8]   = {latin['H'], "H"},
		 [9]   = {latin['I'], "I"},
		 [10]  = {latin['J'], "J"},
		 [11]  = {latin['K'], "K"},
		 [12]  = {latin['L'], "L"},
		 [13]  = {latin['M'], "M-alt"},
		 [14]  = {latin['N'], "N"},
		 [15]  = {latin['O'], "O"},
		 [16]  = {latin['P'], "P"},
		 [17]  = {latin['Q'], "Q"},
		 [18]  = {latin['R'], "R"},
		 [19]  = {latin['S'], "S"},
		 [20]  = {latin['T'], "T"},
		 [21]  = {latin['U'], "U"},
		 [22]  = {latin['V'], "V-alt"},
		 [23]  = {latin['W'], "W-alt"},
		 [24]  = {latin['X'], "X"},
		 [25]  = {latin['Y'], "Y"},
		 [26]  = {latin['Z'], "Z"},
		 
		 [27]  = {symbol['0'], "0"},
		 [28]  = {symbol['1'], "1"},
		 [29]  = {symbol['2'], "2"},
		 [30]  = {symbol['3'], "3"},
		 [31]  = {symbol['4'], "4-alt1"},
		 [32]  = {symbol['5'], "5-alt"},
		 [33]  = {symbol['6'], "6"},
		 [34]  = {symbol['7'], "7"},
		 [35]  = {symbol['8'], "8"},
		 [36]  = {symbol['9'], "9"},
		 
		 [37]  = {symbol['-'], "symbol-minus"},
		 [38]  = {symbol['+'], "symbol-plus"},
		 [39]  = {symbol['\''], "symbol-apostrophe"},
		 [40]  = {symbol['*'], "symbol-asterisk"},
		 [41]  = {symbol['%'], "symbol-percent"},
		 [42]  = {symbol[','], "symbol-comma"},
		 [43]  = {symbol['°'], "symbol-degree"},
		 [44]  = {symbol['.'], "symbol-period"},
		 [45]  = {symbol['/'], "symbol-slash"},
		 [46]  = {symbol['\\'], "symbol-backslash"},
		 [47]  = {symbol['\"'], "symbol-quote"},
		 [48]  = {symbol[':'], "symbol-colon"},
		 [49]  = {symbol['^'], "symbol-lambda"},

	}
}


fontdescription["font_alphaHUD_T45"] = {
	class     = "ceSLineFont",
	symb_storage = "T45_Alpha_Symbol",
	thickness  = HUD_thickness,
	fuzziness  = HUD_fuzziness,
	draw_as_wire = dbg_drawStrokesAsWire,
	default    = {15, 20}, -- (display increments)
	chars	   = {
		[1]  = {symbol['@'], "symbol-alpha"},
	}
}

fontdescription["font_alpha_T45"] = {
	class     = "ceSLineFont",
	symb_storage = "T45_Alpha_Symbol",
	thickness  = MFD_thickness,
	fuzziness  = MFD_fuzziness,
	draw_as_wire = dbg_drawStrokesAsWire,
	default    = {15, 20}, -- (display increments)
	chars	   = {		 
		 [1]  = {symbol['@'], "symbol-alpha"},
	}
}



fonts = {}
fonts["font_T45HUD"]	= {fontdescription["font_stroke_HUD_T45"], 10, materials["HUD_GREEN"]}
fonts["font_T45MFD"]	= {fontdescription["font_stroke_MFD_T45"], 10, materials["MFD_WHITE"]}

fonts["T45MFD_alphaHUD"]	= {fontdescription["font_alphaHUD_T45"], 10, materials["HUD_GREEN"]}
fonts["T45MFD_alpha"]	= {fontdescription["font_alpha_T45"], 10, materials["MFD_WHITE"]}


-- path for stroke symbology
symbologyPaths = {LockOn_Options.script_path.."../AvionicsTextures/",}