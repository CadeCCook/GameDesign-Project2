// obj_minimap Step (editing)
if (!active) exit;

var W  = global.WORLD_W;
var H  = global.WORLD_H;
var sz = MM_cell_px;
var px = MM_pad;
var py = MM_pad;

// GUI-space mouse pos
var mx = device_mouse_x(0);
var my = device_mouse_y(0);

// Grid coords under mouse
var gx = floor((mx - px) / sz);
var gy = floor((my - py) / sz);
var inside = (gx >= 0 && gx < W && gy >= 0 && gy < H);

// --- Painting -------------------------------------------------------
if (inside) {

    // LEFT CLICK = paint according to current brush
    if (mouse_check_button_pressed(mb_left)) {

        switch (edit_mode) {
            case 0: // normal wall
                world_set_wall(gx, gy);
                break;

            case 1: // torch wall
                world_set_wall_torch(gx, gy);
                break;

            case 2: // trap wall
                world_set_wall_trap(gx, gy);
                break;

            case 3: // hole / pit
                world_set_pit(gx, gy);
                break;

            case 4: // enemy spawn
                world_set_enemy(gx, gy);
                break;
				
			case 5: // heart
                world_set_heart(gx, gy);
                break;
        }

        // Rebuild geometry so you can see changes while testing
        world_build_walls();
        world_place_hearts();
    }

    // RIGHT CLICK = clear tile
    if (mouse_check_button_pressed(mb_right)) {
        world_clear_cell(gx, gy);

        world_build_walls();
        //world_build_floor(global.WORLD_GRID);
    }
}

// Ctrl+C to dump array for pasting into LEVEL in world_init.gml
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("C"))) {
    world_grid_dump_array();
}