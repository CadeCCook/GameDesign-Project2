// ===== obj_hud : Draw GUI =====
gui_reset_hard();   // our safe reset (no blue rectangle anymore)

// ---------- Reticle (center of screen) ----------
if (reticle_enabled) {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();
    var cx = gw * 0.5;
    var cy = gh * 0.5;

    draw_set_alpha(reticle_alpha);
    draw_set_color(reticle_color);

    // optional center dot
    if (reticle_dot_radius > 0) {
        draw_circle(cx, cy, reticle_dot_radius, false);
    }

    // crosshair arms
    var g = reticle_gap;
    var L = reticle_length;
    var T = reticle_thickness;

    // horizontal
    draw_line_width(cx - (g + L), cy, cx - g, cy, T);
    draw_line_width(cx + g,       cy, cx + (g + L), cy, T);
    // vertical
    draw_line_width(cx, cy - (g + L), cx, cy - g, T);
    draw_line_width(cx, cy + g,       cx, cy + (g + L), T);

    draw_set_alpha(1);
    draw_set_color(c_white);
}

// ---------- Knife (idle/swing), clamped on-screen ----------
var gw = display_get_gui_width();
var gh = display_get_gui_height();
var pad = 8;

if (!sprite_exists(knife_sprite)) exit;

var p = hud_weapon_gui_pos();
var wx = p[0], wy = p[1];

var sc = weapon_scale;
var w  = sprite_get_width(knife_sprite);
var h  = sprite_get_height(knife_sprite);
var ox = sprite_get_xoffset(knife_sprite);
var oy = sprite_get_yoffset(knife_sprite);

// Fit & clamp so it never goes off-screen
var draw_x = wx - ox * sc, draw_y = wy - oy * sc;
var draw_w = w * sc,       draw_h = h * sc;
var max_w = gw - 2*pad,    max_h = gh - 2*pad;

if (draw_w > max_w || draw_h > max_h) {
    var fit = min(max_w / max(1, draw_w), max_h / max(1, draw_h));
    sc = sc * fit;
    draw_x = wx - ox * sc; draw_y = wy - oy * sc;
    draw_w = w * sc;       draw_h = h * sc;
}
if (draw_x < pad)             wx += (pad - draw_x);
if (draw_y < pad)             wy += (pad - draw_y);
if (draw_x + draw_w > gw-pad) wx -= (draw_x + draw_w - (gw - pad));
if (draw_y + draw_h > gh-pad) wy -= (draw_y + draw_h - (gh - pad));
draw_x = wx - ox * sc; draw_y = wy - oy * sc;

// Draw current knife frame (sub set in Step)
draw_sprite_ext(knife_sprite, sub, draw_x, draw_y, sc, sc, 0, c_white, 1);


