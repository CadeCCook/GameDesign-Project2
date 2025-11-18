/// obj_storyIntro – Draw GUI

// Use GUI coordinates
var scr_w = display_get_gui_width();
var scr_h = display_get_gui_height();

// Centered box
var box_w = scr_w * 0.6;
var box_h = scr_h * 0.25;
var box_x = (scr_w - box_w) * 0.5;
var box_y = (scr_h - box_h) * 0.5;

// Background
draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);
draw_set_alpha(1);

// ---- Main text (inside box, with margin) ----
var margin = 20;

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var text_x = box_x + margin;
var text_y = box_y + margin;

// wrap width = box width minus left/right margins
var wrap_width = box_w - margin * 2;
var line_sep   = 28; // pixels between lines

draw_text_ext(text_x, text_y, text, line_sep, wrap_width);

// ---- Hint at bottom-right of the box ----
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_text(box_x + box_w - 8, box_y + box_h - 6, "[Click or Space to continue]");