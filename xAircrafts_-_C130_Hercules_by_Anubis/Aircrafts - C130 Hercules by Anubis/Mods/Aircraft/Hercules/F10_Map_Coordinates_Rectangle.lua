---------------------------------------------------------------------------
---------------------------------------------------------------------------
-- This F10 map coordinate capture will only work in the cockpit of the Hercules mod.
-- The captured coordinates are used to prepare waypoints directly on the F10 map.
-- The default coordinates as entered below will work for the screen setup on most computers and therefore need not be changed.
-- These instructions are mainly for those that use complex multiple screens or non default VR setups.
-- Refer to the F10_Map_Coordinates_Rectangle.jpg in the root directory of the Hercules mod for clarification.
-- Basically, screen coordinates of the F10 map coordinate rectangle need to be supplied below using any program suitable.
-- Included are F10_Map_Screen_Coordinates.exe, an executable compiled using autoit-v3, which will show screen coordinates of the
-- mouse pointer when activated using CAPS LOCK on the keyboard.
-- For those that would rather compile their own version, F10_Map_Screen_Coordinates.ahk are included.

---------------------------------------------------------------------------
---------------------------------------------------------------------------
F10_Map_Coordinate_Rectangle_Upper_Left_x = 97
F10_Map_Coordinate_Rectangle_Upper_Left_y = 8
F10_Map_Coordinate_Rectangle_Lower_Right_x = 370
F10_Map_Coordinate_Rectangle_Lower_Right_y = 29
---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
-----Do not modify!!!!!!!!!
F10_Map_Coordinate_Rectangle_Upper_Left_x_param = get_param_handle("F10_Map_Coordinate_Rectangle_Upper_Left_x")
F10_Map_Coordinate_Rectangle_Upper_Left_x_param:set(F10_Map_Coordinate_Rectangle_Upper_Left_x)
F10_Map_Coordinate_Rectangle_Upper_Left_y_param = get_param_handle("F10_Map_Coordinate_Rectangle_Upper_Left_y")
F10_Map_Coordinate_Rectangle_Upper_Left_y_param:set(F10_Map_Coordinate_Rectangle_Upper_Left_y)
F10_Map_Coordinate_Rectangle_Lower_Right_x_param = get_param_handle("F10_Map_Coordinate_Rectangle_Lower_Right_x")
F10_Map_Coordinate_Rectangle_Lower_Right_x_param:set(F10_Map_Coordinate_Rectangle_Lower_Right_x)
F10_Map_Coordinate_Rectangle_Lower_Right_y_param = get_param_handle("F10_Map_Coordinate_Rectangle_Lower_Right_y")
F10_Map_Coordinate_Rectangle_Lower_Right_y_param:set(F10_Map_Coordinate_Rectangle_Lower_Right_y)



