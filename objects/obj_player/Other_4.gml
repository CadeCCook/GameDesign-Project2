if (room == rm_tutoriallvl || room == rm_mainlvl) {

    // Center the mouse in the window once on room start
    window_mouse_set(window_get_width() / 2, window_get_height() / 2);

    with (obj_player) {
        look_dir   = 0;
        look_pitch = -5;
        mouse_lock = true;

        view_initialized = false;
    }
}