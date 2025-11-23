function world_build_walls() {
    // Vertex format for walls (once)
    if (!variable_global_exists("VFMT_WALL")) {
        vertex_format_begin();
        vertex_format_add_position_3d();
        vertex_format_add_normal();
        vertex_format_add_texcoord();
        vertex_format_add_color();
        global.VFMT_WALL = vertex_format_end();
    }


    // Delete any old buffers
    if (variable_global_exists("WALL_VB") && global.WALL_VB != -1) {
        vertex_delete_buffer(global.WALL_VB);
    }
    if (variable_global_exists("WALL_VB_CRACK") && global.WALL_VB_CRACK != -1) {
        vertex_delete_buffer(global.WALL_VB_CRACK);
    }
    if (variable_global_exists("WALL_VB_BLOOD") && global.WALL_VB_BLOOD != -1) {
        vertex_delete_buffer(global.WALL_VB_BLOOD);
    }
    if (variable_global_exists("WALL_VB_TORCH") && global.WALL_VB_TORCH != -1) {
        vertex_delete_buffer(global.WALL_VB_TORCH);
    }
    if (variable_global_exists("WALL_VB_TRAP") && global.WALL_VB_TRAP != -1) {
        vertex_delete_buffer(global.WALL_VB_TRAP);
    }

    // --------------------------------------------
    //  - plain walls       -> spr_wall
    //  - cracked walls     -> spr_wallCrack
    //  - bloody walls      -> spr_wallBlood
    //  - torch walls       -> spr_wallTorch
    //  - trap walls        -> spr_wallTrap
    // --------------------------------------------
    var vb_plain = vertex_create_buffer();
    var vb_crack = vertex_create_buffer();
    var vb_blood = vertex_create_buffer();
    var vb_torch = vertex_create_buffer();
    var vb_trap  = vertex_create_buffer();

    vertex_begin(vb_plain, global.VFMT_WALL);
    vertex_begin(vb_crack, global.VFMT_WALL);
    vertex_begin(vb_blood, global.VFMT_WALL);
    vertex_begin(vb_torch, global.VFMT_WALL);
    vertex_begin(vb_trap,  global.VFMT_WALL);


    // Helper to add a rectangular quad to any vb
    var add_quad = function(_vb,
                        x1,y1,z1,
                        x2,y2,z2,
                        x3,y3,z3,
                        x4,y4,z4)
{
    var color = global.WALL_COLOR;

    // triangle 1
    vertex_add_point(_vb, x1,y1,z1,  0,0,1,  0,1, color, 1); // bottom-left
    vertex_add_point(_vb, x2,y2,z2,  0,0,1,  1,1, color, 1); // bottom-right
    vertex_add_point(_vb, x3,y3,z3,  0,0,1,  1,0, color, 1); // top-right

    // triangle 2
    vertex_add_point(_vb, x3,y3,z3,  0,0,1,  1,0, color, 1); // top-right
    vertex_add_point(_vb, x4,y4,z4,  0,0,1,  0,0, color, 1); // top-left
    vertex_add_point(_vb, x1,y1,z1,  0,0,1,  0,1, color, 1); // bottom-left
}


    // Build walls from WORLD_GRID
    var c  = global.WORLD_CELL;
    var Hh = global.WALL_HEIGHT;
    var W  = global.WORLD_W;
    var H  = global.WORLD_H;

    for (var jy = 0; jy < H; jy++) {
        for (var ix = 0; ix < W; ix++) {

            var idx  = jy * W + ix;
            var cell = global.WORLD_GRID[idx];

            // 2 = pit: spawn pit instance and skip walls
            if (cell == 2) {
                var pit_x = (ix + 0.5) * c;
                var pit_y = (jy + 0.5) * c;
                instance_create_layer(pit_x, pit_y, "Instances", obj_pit);
                continue;
            }

            // 5 = goal/end: no walls here; world_place_end()
            // handles geometry + obj_end separately
            if (cell == 5) {
                continue;
            }

            // ----------------------------------------
            // WALL TYPES:
            //  1 = normal wall  (random: plain/crack/blood)
            //  4 = wall (Torch)
            //  6 = wall (Trap)
            // ----------------------------------------
            var vb_tile = noone;

            switch (cell) {
                case 1:
                    // random normal wall variant
                    var r = irandom(2); // 0,1,2
                    if      (r == 0) vb_tile = vb_plain;
                    else if (r == 1) vb_tile = vb_crack;
                    else             vb_tile = vb_blood;
                    break;

                case 4:
                    vb_tile = vb_torch;
                    break;

                case 6:
                    vb_tile = vb_trap;
                    break;

                default:
                    // not a wall at all
                    continue;
            }

            var wx = ix * c;
            var wy = jy * c;

			// Left face
            if (!world_cell_solid(ix - 1, jy)) {
                add_quad(vb_tile,
                    wx,      wy,      0,
                    wx,      wy + c,  0,
                    wx,      wy + c,  Hh,
                    wx,      wy,      Hh);
            }

            // Right face
            if (!world_cell_solid(ix + 1, jy)) {
                add_quad(vb_tile,
                    wx + c,  wy + c,  0,
                    wx + c,  wy,      0,
                    wx + c,  wy,      Hh,
                    wx + c,  wy + c,  Hh);
            }

            // Front face (toward -y)
            if (!world_cell_solid(ix, jy - 1)) {
                add_quad(vb_tile,
                    wx,      wy,      0,
                    wx + c,  wy,      0,
                    wx + c,  wy,      Hh,
                    wx,      wy,      Hh);
            }

            // Back face (toward +y)
            if (!world_cell_solid(ix, jy + 1)) {
                add_quad(vb_tile,
                    wx + c,  wy + c,  0,
                    wx,      wy + c,  0,
                    wx,      wy + c,  Hh,
                    wx + c,  wy + c,  Hh);
            }
        }
    }


    vertex_end(vb_plain);
    vertex_end(vb_crack);
    vertex_end(vb_blood);
    vertex_end(vb_torch);
    vertex_end(vb_trap);

    global.WALL_VB        = vb_plain;
    global.WALL_VB_CRACK  = vb_crack;
    global.WALL_VB_BLOOD  = vb_blood;
    global.WALL_VB_TORCH  = vb_torch;
    global.WALL_VB_TRAP   = vb_trap;
}