dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."Displays/MFDDefs.lua")
SetScale(MILLYRADIANS)

DEFAULT_LEVEL = 9
NOCLIP_LEVEL  = DEFAULT_LEVEL - 1


--- {L/R,U/D,forward/back}
ALTPos={77,0}
RALTPos={80,-20}
VVPos={80,10}
IASPos={-80,0}
GSPos={-101,-25}
AOAPos={-95,-35}
MachPos={-95,-45}
GPos={-95,-55}
peakGPos = {-95,-65}
timePos={-85,-140}
EPos = {-12, 0}
scratchPadPos = {0,-110}



function DegToMilRad(degree)
	return degree*(1000/180)*3.141592
end




