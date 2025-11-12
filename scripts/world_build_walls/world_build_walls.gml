function world_build_walls() {
    if (!variable_global_exists("WALL_HEIGHT"))    global.WALL_HEIGHT    = 128;
    if (!variable_global_exists("WALL_TEX_SCALE")) global.WALL_TEX_SCALE = 64;

    // Vertex format: pos3d + uv + color
    if (!variable_global_exists("VFMT_WALL")) {
        var fmt = vertex_format_begin();
        vertex_format_add_position_3d();
        vertex_format_add_texcoord();
        vertex_format_add_color();
        global.VFMT_WALL = vertex_format_end();
    }

    // Destroy old buffer if present
    if (variable_global_exists("WALL_VB") && global.WALL_VB != -1) {
        vertex_delete_buffer(global.WALL_VB);
    }

    var vb = vertex_create_buffer();
    vertex_begin(vb, global.VFMT_WALL);

    var c       = global.WORLD_CELL;
    var H       = global.WALL_HEIGHT;
    var u_scale = c / global.WALL_TEX_SCALE;
    var v_scale = H / global.WALL_TEX_SCALE;

    var add_quad = function(
        _vb,
        x1,y1,z1,  x2,y2,z2,  x3,y3,z3,  x4,y4,z4,
        u_len, v_len
    ) {
        vertex_position_3d(_vb, x1,y1,z1); vertex_texcoord(_vb, 0,     0    ); vertex_color(_vb, c_gray, 1);
        vertex_position_3d(_vb, x2,y2,z2); vertex_texcoord(_vb, 0,     v_len); vertex_color(_vb, c_gray, 1);
        vertex_position_3d(_vb, x3,y3,z3); vertex_texcoord(_vb, u_len, v_len); vertex_color(_vb, c_gray, 1);

        vertex_position_3d(_vb, x1,y1,z1); vertex_texcoord(_vb, 0,     0    ); vertex_color(_vb, c_gray, 1);
        vertex_position_3d(_vb, x3,y3,z3); vertex_texcoord(_vb, u_len, v_len); vertex_color(_vb, c_gray, 1);
        vertex_position_3d(_vb, x4,y4,z4); vertex_texcoord(_vb, u_len, 0    ); vertex_color(_vb, c_gray, 1);
    };

    for (var jy = 0; jy < global.WORLD_H; jy++) {
        for (var ix = 0; ix < global.WORLD_W; ix++) {
            if (global.WORLD_GRID[jy * global.WORLD_W + ix] != 1) continue;

            var wx = ix * c;
            var wy = jy * c;

            var left_empty  = !world_cell_solid(ix - 1, jy);
            var right_empty = !world_cell_solid(ix + 1, jy);
            var up_empty    = !world_cell_solid(ix, jy - 1);
            var down_empty  = !world_cell_solid(ix, jy + 1);

            if (left_empty) {
                add_quad(vb,
                    wx,     wy,     0,
                    wx,     wy + c, 0,
                    wx,     wy + c, H,
                    wx,     wy,     H,
                    u_scale, v_scale
                );
            }
            if (right_empty) {
                var x2 = wx + c;
                add_quad(vb,
                    x2,     wy + c, 0,
                    x2,     wy,     0,
                    x2,     wy,     H,
                    x2,     wy + c, H,
                    u_scale, v_scale
                );
            }
            if (up_empty) {
                add_quad(vb,
                    wx + c, wy,     0,
                    wx,     wy,     0,
                    wx,     wy,     H,
                    wx + c, wy,     H,
                    u_scale, v_scale
                );
            }
            if (down_empty) {
                var y2 = wy + c;
                add_quad(vb,
                    wx,     y2,     0,
                    wx + c, y2,     0,
                    wx + c, y2,     H,
                    wx,     y2,     H,
                    u_scale, v_scale
                );
            }
        }
    }

    vertex_end(vb);
    global.WALL_VB = vb;
}