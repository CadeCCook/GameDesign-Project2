/// obj_camera – Room Start

// Only do this in the tutorial room
if (room == rm_Tutorial) {

    // Center the mouse in the window
    window_mouse_set(window_get_width() / 2, window_get_height() / 2);

    // Apply the view settings to the player
    with (obj_player) {
        look_dir   = 0;

        // 80 will look almost straight up! 
        // Use a small negative value to look forward at wall height:
        look_pitch = -5;  // tweak between -5 and -15 as you like

        mouse_lock = true;
    }
}