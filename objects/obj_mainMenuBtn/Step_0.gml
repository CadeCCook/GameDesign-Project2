// Check if mouse is over button
if (position_meeting(mouse_x, mouse_y, obj_mainMenuBtn)) {
	hovered = true;
	
	// If left mouse button pressed goes to level 1
	if(mouse_check_button_pressed(mb_left)){
		room_goto(rm_startScreen);
	}
} else {
	hovered = false;
}