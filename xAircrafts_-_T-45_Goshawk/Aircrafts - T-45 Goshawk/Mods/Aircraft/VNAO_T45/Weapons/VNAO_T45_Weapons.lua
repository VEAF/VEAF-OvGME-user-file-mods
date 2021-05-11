dofile("Scripts/Database/Weapons/warheads.lua")


local bombs_data =
{
	["BDU-33"]			= {name = "BDU-33",			mass = 11.3, wsType = {4, 5, 9, 69}, Cx = 0.00025, picture = "bdu-33.png"},
}
local PMBR_mass = 39.4625 --kg

local function PMBR_Bombs(element)
	local bomb_variant = bombs_data[element] 
	local data = {
		category		=	CAT_BOMBS,
		CLSID			=	"{PMBR_6X_"..element.."}",
		Picture			=	bomb_variant.picture,
		wsTypeOfWeapon	=	bomb_variant.wsType,
		displayName		=  _("PMBR - 6 x "..bomb_variant.name),
		attribute		=	{wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
		Cx_pil			=	bomb_variant.Cx,		
		Count			=	6,
		Weight			=	PMBR_mass + 6 * bomb_variant.mass,			
		Elements		= {	{ShapeName	= "T45_PMBR",	IsAdapter  	   = true},
							{ShapeName	= element,		connector_name = "Point01"},
							{ShapeName	= element,		connector_name = "Point02"},
							{ShapeName	= element,		connector_name = "Point03"},
							{ShapeName	= element,		connector_name = "Point04"},
							{ShapeName	= element,		connector_name = "Point05"},
							{ShapeName	= element,		connector_name = "Point06"}
		}, -- end of Elements
	}
	declare_loadout(data)
end

PMBR_Bombs("BDU-33")
