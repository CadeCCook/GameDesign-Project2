// Toggle minimap with F1 (no mouse/cursor changes here)
if (keyboard_check_pressed(vk_f1)) {
    active  = !active;
    visible = active;
    global.MINIMAP_ACTIVE = active;
}
