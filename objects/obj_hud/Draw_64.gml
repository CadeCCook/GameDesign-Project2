// --- FORCE CLEAN 2D GUI STATE ---
shader_reset();
gpu_set_fog(false, make_colour_rgb(0,0,0), 0, 0); // ensure world fog doesn't touch GUI
gpu_set_blendenable(true);
gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
draw_set_color(c_white);

// Screen size
var sw = display_get_gui_width();
var sh = display_get_gui_height();

// Tiny debug so we know HUD is drawing:
draw_text(16, 16, "HUD: OK");

// Idle bob
if (!variable_global_exists("hud_t")) global.hud_t = 0;
global.hud_t += 0.15;
var bob_x = 4 * sin(global.hud_t);
var bob_y = 3 * cos(global.hud_t * 1.7);

// Swing angle from player timer (no smoothstep, manual ease)
var swing_angle = 0;
if (instance_exists(obj_player)) {
    var p = 1 - (obj_player.swing_timer / max(1, obj_player.sword_cooldown));
    p = clamp(p, 0, 1);
    var t = clamp((p - 0.0) / max(0.0001, 0.5 - 0.0), 0, 1);
    t = t * t * (3 - 2 * t); // smoothstep
    swing_angle = lerp(-50, 35, t);
}

var pos = hud_weapon_gui_pos();
var wx = pos[0];
var wy = pos[1];

// draw the sword with scale
if (sprite_exists(spr_sword)) {
    var sc = global.HUD_WEAPON_SCALE;           // 5x
    draw_sprite_ext(spr_sword, 0, wx, wy, sc, sc, swing_angle, c_white, 1);
} else {
    // Placeholder blade so you still see something
    draw_set_color(c_white);
    draw_rectangle(wx-6, wy-80, wx+6, wy+40, false);
    draw_line(wx-6, wy-80, wx+6, wy-80);
    draw_text(16, 32, "Sword: placeholder (spr_sword missing)");
}

// Crosshair
draw_set_color(c_white);
draw_line(sw*0.5-6, sh*0.5,   sw*0.5+6, sh*0.5);
draw_line(sw*0.5,   sh*0.5-6, sw*0.5,   sh*0.5+6);

