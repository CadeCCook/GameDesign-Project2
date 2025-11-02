/// @func hud_weapon_gui_pos() -> [wx, wy]
/// @desc Returns the GUI-space position where the weapon sits (keeps HUD + FX aligned).
function hud_weapon_gui_pos() {
    var sw = display_get_gui_width();
    var sh = display_get_gui_height();

    if (!variable_global_exists("hud_t")) global.hud_t = 0;
    var bob_x = 4 * sin(global.hud_t);
    var bob_y = 3 * cos(global.hud_t * 1.7);

    var wx = sw * 0.5 + 80 + bob_x;  // right-of-center
    var wy = sh - 120 + bob_y;       // near bottom
    return [wx, wy];
}
