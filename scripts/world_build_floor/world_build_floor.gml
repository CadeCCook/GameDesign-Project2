function world_build_floor(LEVEL)
{
    // ---- Create vertex format once ----
    if (!variable_global_exists("VFMT_FLOOR")) {
        vertex_format_begin();
        vertex_format_add_position_3d();
        vertex_format_add_normal();
        vertex_format_add_texcoord();
        vertex_format_add_color();
        global.VFMT_FLOOR = vertex_format_end();
    }

    // ---- Delete old buffers if they exist ----
    if (variable_global_exists("FLOOR_VB") && global.FLOOR_VB != -1) {
        vertex_delete_buffer(global.FLOOR_VB);
    }
    if (variable_global_exists("FLOOR_VB_BLOOD") && global.FLOOR_VB_BLOOD != -1) {
        vertex_delete_buffer(global.FLOOR_VB_BLOOD);
    }
    if (variable_global_exists("FLOOR_VB_BLOOD2") && global.FLOOR_VB_BLOOD2 != -1) {
        vertex_delete_buffer(global.FLOOR_VB_BLOOD2);
    }

    // ---- Create three new buffers ----
    var vb_plain  = vertex_create_buffer();
    var vb_blood  = vertex_create_buffer();
    var vb_blood2 = vertex_create_buffer();

    vertex_begin(vb_plain,  global.VFMT_FLOOR);
    vertex_begin(vb_blood,  global.VFMT_FLOOR);
    vertex_begin(vb_blood2, global.VFMT_FLOOR);

    // Helper to add a single floor quad
    var add_floor_quad = function(_vb, x0, y0, size)
    {
        var x1 = x0 + size;
        var y1 = y0 + size;
        var z  = 0;
        var color = c_white;

        // triangle 1
        vertex_add_point(_vb, x0, y0, z,  0,1,0,  0,0, color, 1);
        vertex_add_point(_vb, x1, y0, z,  0,1,0,  1,0, color, 1);
        vertex_add_point(_vb, x1, y1, z,  0,1,0,  1,1, color, 1);

        // triangle 2
        vertex_add_point(_vb, x1, y1, z,  0,1,0,  1,1, color, 1);
        vertex_add_point(_vb, x0, y1, z,  0,1,0,  0,1, color, 1);
        vertex_add_point(_vb, x0, y0, z,  0,1,0,  0,0, color, 1);
    };

    var cell   = global.WORLD_CELL;
    var W      = global.WORLD_W;
    var H      = global.WORLD_H;

    // ---- Loop over WORLD_GRID exactly like walls ----
    for (var jy = 0; jy < H; jy++) {
        for (var ix = 0; ix < W; ix++) {

            var idx  = jy * W + ix;
            var tile = global.WORLD_GRID[idx];

            // Skip pits and goal tiles – they have no floor
            if (tile == 2 || tile == 5) {
				continue;
			}

            // Choose which floor buffer to use (random)
            var vb_tile = vb_plain;
            var r = irandom(2); // 0,1,2
            if (r == 1) {
                vb_tile = vb_blood;
            } else if (r == 2) {
                vb_tile = vb_blood2;
            }

            var fx = ix * cell;
            var fy = jy * cell;
            add_floor_quad(vb_tile, fx, fy, cell);
        }
    }

    vertex_end(vb_plain);
    vertex_end(vb_blood);
    vertex_end(vb_blood2);

    global.FLOOR_VB        = vb_plain;
    global.FLOOR_VB_BLOOD  = vb_blood;
    global.FLOOR_VB_BLOOD2 = vb_blood2;
}