/// hud_weapon_gui_pos() -> [wx, wy]
/// Screen-space (GUI) position where the HUD weapon should be drawn.
function hud_weapon_gui_pos()
{
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();

    // margins from bottom-right
    var mx = 90;
    var my = 60;

    // subtle bob (uses global.hud_t if available)
    var t = variable_global_exists("hud_t") ? global.hud_t : 0;
    var bobx = 6 * sin(t);
    var boby = 4 * (1 - cos(t));

    var wx = gw - mx + bobx;
    var wy = gh - my + boby;

    return [wx, wy];
}