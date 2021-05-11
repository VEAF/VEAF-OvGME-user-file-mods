local DbOption  = require('Options.DbOption')
local i18n	    = require('i18n')

local _ = i18n.ptranslate

return {

	cockpitType				= DbOption.new():setValue(0):combo({DbOption.Item(_('C Cockpit')):Value(0),
																DbOption.Item(_('A Cockpit')):Value(1),																
																}),
}
