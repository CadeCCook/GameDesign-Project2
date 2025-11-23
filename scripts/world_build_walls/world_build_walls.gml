function world_build_walls(LEVEL)
{
    // --- Make sure we have a wall vertex format ---
    if (!variable_global_exists("VFMT_WALL")) {
        vertex_format_begin();
        vertex_format_add_position_3d();
        vertex_format_add_normal();
        vertex_format_add_texcoord();
        vertex_format_add_color();
        global.VFMT_WALL = vertex_format_end();
    }

    // --- Delete old buffers if they exist ---
    if (variable_global_exists("WALL_VB_plain") && global.WALL_VB_plain != -1) {
        vertex_delete_buffer(global.WALL_VB_plain);
    }
    if (variable_global_exists("WALL_VB_crack") && global.WALL_VB_crack != -1) {
        vertex_delete_buffer(global.WALL_VB_crack);
    }
    if (variable_global_exists("WALL_VB_blood") && global.WALL_VB_blood != -1) {
        vertex_delete_buffer(global.WALL_VB_blood);
    }

    // --- Create three buffers: plain / crack / blood ---
    var vb_plain = vertex_create_buffer();
    var vb_crack = vertex_create_buffer();
    var vb_blood = vertex_create_buffer();

    vertex_begin(vb_plain, global.VFMT_WALL);
    vertex_begin(vb_crack, global.VFMT_WALL);
    vertex_begin(vb_blood, global.VFMT_WALL);

    // --- Build geometry ---
    var cell = global.WORLD_CELL;
    var rows = array_length(LEVEL);
    var cols = array_length(LEVEL[0]);
    var col = c_white;

    for (var ty = 0; ty < rows; ty++)
    {
        for (var tx = 0; tx < cols; tx++)
        {
            if (LEVEL[ty][tx] == 1)  // wall tile
            {
                // choose which buffer this wall goes into
                var choice = irandom(2); // 0=plain, 1=crack, 2=blood
                var vb;
                switch (choice) {
                    case 0: vb = vb_plain; break;
                    case 1: vb = vb_crack; break;
                    default: vb = vb_blood; break;
                }

                // world-space position for this tile
                var x0 = (tx + 1) * cell;
                var y0 = (ty + 1) * cell;
                var x1 = x0 + cell;
                var y1 = y0 + cell;

                var z0 = 0;
                var z1 = cell; // wall height

                // Each side uses 2 triangles. This matches your old wall build
                // but we just write into 'vb' instead of a single global buffer.

                // SOUTH face
                vertex_add_point(vb, x0, y1, z0,   0,0,-1,  0,0,  col, 1);
                vertex_add_point(vb, x1, y1, z0,   0,0,-1,  1,0,  col, 1);
                vertex_add_point(vb, x1, y1, z1,   0,0,-1,  1,1,  col, 1);

                vertex_add_point(vb, x1, y1, z1,   0,0,-1,  1,1,  col, 1);
                vertex_add_point(vb, x0, y1, z1,   0,0,-1,  0,1,  col, 1);
                vertex_add_point(vb, x0, y1, z0,   0,0,-1,  0,0,  col, 1);

                // NORTH face
                vertex_add_point(vb, x1, y0, z0,   0,0,1,   0,0,  col, 1);
                vertex_add_point(vb, x0, y0, z0,   0,0,1,   1,0,  col, 1);
                vertex_add_point(vb, x0, y0, z1,   0,0,1,   1,1,  col, 1);

                vertex_add_point(vb, x0, y0, z1,   0,0,1,   1,1,  col, 1);
                vertex_add_point(vb, x1, y0, z1,   0,0,1,   0,1,  col, 1);
                vertex_add_point(vb, x1, y0, z0,   0,0,1,   0,0,  col, 1);

                // WEST face
                vertex_add_point(vb, x0, y0, z0,  -1,0,0,   0,0,  col, 1);
                vertex_add_point(vb, x0, y1, z0,  -1,0,0,   1,0,  col, 1);
                vertex_add_point(vb, x0, y1, z1,  -1,0,0,   1,1,  col, 1);

                vertex_add_point(vb, x0, y1, z1,  -1,0,0,   1,1,  col, 1);
                vertex_add_point(vb, x0, y0, z1,  -1,0,0,   0,1,  col, 1);
                vertex_add_point(vb, x0, y0, z0,  -1,0,0,   0,0,  col, 1);

                // EAST face
                vertex_add_point(vb, x1, y1, z0,   1,0,0,   0,0,  col, 1);
                vertex_add_point(vb, x1, y0, z0,   1,0,0,   1,0,  col, 1);
                vertex_add_point(vb, x1, y0, z1,   1,0,0,   1,1,  col, 1);

                vertex_add_point(vb, x1, y0, z1,   1,0,0,   1,1,  col, 1);
                vertex_add_point(vb, x1, y1, z1,   1,0,0,   0,1,  col, 1);
                vertex_add_point(vb, x1, y1, z0,   1,0,0,   0,0,  col, 1);
            }
        }
    }

    vertex_end(vb_plain);
    vertex_end(vb_crack);
    vertex_end(vb_blood);

    global.WALL_VB_plain = vb_plain;
    global.WALL_VB_crack = vb_crack;
    global.WALL_VB_blood = vb_blood;

    // textures for each variant
    global.WALL_TEX_plain = sprite_get_texture(spr_wall, 0);
    global.WALL_TEX_crack = sprite_get_texture(spr_wallCrack, 0);
    global.WALL_TEX_blood = sprite_get_texture(spr_wallBlood, 0);
}