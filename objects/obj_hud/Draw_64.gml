// ===== obj_hud : Draw GUI =====
gui_reset_hard(); //reset for saftey

// Reticle
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
    draw_line_width(cx - (g + L), cy, cx - g,       cy, T);
    draw_line_width(cx + g,       cy, cx + (g + L), cy, T);
    // vertical
    draw_line_width(cx, cy - (g + L), cx, cy - g,       T);
    draw_line_width(cx, cy + (g + L), cx, cy + g,       T);

    draw_set_alpha(1);
    draw_set_color(c_white);
}

// Knife HUD
var gw = display_get_gui_width();
var gh = display_get_gui_height();

if (sprite_exists(knife_sprite)) {
    var pad_right  = 24;
    var pad_bottom = 2;
    var extra_down = 40;

    var sc = weapon_scale;
    var w  = sprite_get_width(knife_sprite);
    var h  = sprite_get_height(knife_sprite);

    var t    = variable_global_exists("hud_t") ? global.hud_t : 0;
    var bobx = 6 * sin(t);

    var knife_right = gw - pad_right + bobx;
    var knife_y_base = (gh - pad_bottom) - h * sc;
    var knife_y = knife_y_base + extra_down;
    var knife_x = knife_right - w * sc;

    draw_sprite_ext(knife_sprite, sub, knife_x, knife_y, sc, sc, 0, c_white, 1);
}

// Health bar
var bar_x  = 20;
var bar_y  = 20;
var bar_w  = 200;
var bar_h  = 20;

// safety check
var _hp     = (instance_exists(obj_player) && variable_instance_exists(obj_player, "hp"))     ? obj_player.hp     : 0;
var _max_hp = (instance_exists(obj_player) && variable_instance_exists(obj_player, "max_hp")) ? obj_player.max_hp : 1;

// Ratio of health
var hp_ratio = clamp(_hp / _max_hp, 0, 1);

// background
draw_set_colour(c_black);
draw_rectangle(bar_x - 2, bar_y - 2, bar_x + bar_w + 2, bar_y + bar_h + 2, false);

draw_set_colour(c_dkgray);
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);

// filled part
draw_set_colour(c_red);
draw_rectangle(bar_x, bar_y, bar_x + bar_w * hp_ratio, bar_y + bar_h, false);

//Little helper sprite stuff
if (helper_visible) {
    var fairy_x = helper_pos_x + helper_sway_offset;
    var fairy_y = helper_pos_y + sin(helper_hover_phase) * helper_hover_amp;

    draw_sprite_ext(spr_helper, 0, fairy_x, fairy_y, 2, 2, 0, c_white, 1);
}

//Little helper speak box
if (helper_talking) {
    var scr_w = display_get_gui_width();
    var scr_h = display_get_gui_height();

    // Box near bottom center
    var box_w = scr_w * 0.5;
    var box_h = scr_h * 0.16;
    var box_x = (scr_w - box_w) * 0.5;
    var box_y = scr_h * 0.7;

    // Background
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);
    draw_set_alpha(1);

    // Text inside with margin
    var margin = 16;
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    var text_x = box_x + margin;
    var text_y = box_y + margin;
    var wrap_w = box_w - margin * 2;
    var line_sep = 28;

    draw_text_ext(text_x, text_y, helper_text, line_sep, wrap_w);
}