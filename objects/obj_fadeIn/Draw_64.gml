/// obj_fadeIn – Draw GUI

var w = display_get_gui_width();
var h = display_get_gui_height();

draw_set_alpha(alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, w, h, false);
draw_set_alpha(1);