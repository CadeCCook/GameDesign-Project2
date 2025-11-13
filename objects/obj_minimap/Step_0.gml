// obj_minimap Step
if (!active) exit;

var W  = global.WORLD_W;
var H  = global.WORLD_H;
var sz = MM_cell_px;
var px = MM_pad;
var py = MM_pad;

// GUI-space mouse pos
var mx = device_mouse_x(0);
var my = device_mouse_y(0);

var gx = floor((mx - px) / sz);
var gy = floor((my - py) / sz);
var inside = (gx >= 0 && gx < W && gy >= 0 && gy < H);

if (inside) {
    if (mouse_check_button_pressed(mb_left)) {
        world_set_wall(gx, gy);
        world_build_walls();
    }
    if (mouse_check_button_pressed(mb_right)) {
        world_clear_wall(gx, gy);
        world_build_walls();
    }
}

// Ctrl+C to dump array for pasting into LEVEL in world_init.gml
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("C"))) {
    world_grid_dump_array();
}