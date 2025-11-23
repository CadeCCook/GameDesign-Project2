// Toggle minimap with F1 (no mouse/cursor changes here)
if (keyboard_check_pressed(vk_f1)) {
    active  = !active;
    visible = active;
    global.MINIMAP_ACTIVE = active;
}

// Cycle brush mode with Shift while the minimap is active
if (active && keyboard_check_pressed(vk_shift)) {
    edit_mode = (edit_mode + 1) mod (edit_mode_max + 1);
}
