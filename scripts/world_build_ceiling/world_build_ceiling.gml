function world_build_ceiling(LEVEL)
{
    // --------------------------------------------
    // Vertex format (once)
    // --------------------------------------------
    if (!variable_global_exists("VFMT_CEILING"))
    {
        vertex_format_begin();
        vertex_format_add_position_3d();
        vertex_format_add_normal();
        vertex_format_add_texcoord();
        vertex_format_add_color();
        global.VFMT_CEILING = vertex_format_end();
    }

    // --------------------------------------------
    // Delete old buffer if it exists
    // --------------------------------------------
    if (variable_global_exists("CEILING_VB") && global.CEILING_VB != -1)
    {
        vertex_delete_buffer(global.CEILING_VB);
    }

    // --------------------------------------------
    // Create one big quad
    // --------------------------------------------
    var vb = vertex_create_buffer();
    vertex_begin(vb, global.VFMT_CEILING);

    var cell = global.WORLD_CELL;
    var W    = global.WORLD_W;
    var H    = global.WORLD_H;

    // Height of the ceiling.
    var z = global.CEILING_HEIGHT;

    var x0 = 0;
    var y0 = 0;
    var x1 = W * cell;
    var y1 = H * cell;

    var col = c_white;

    // Normal points downward (0,0,-1)
    // UVs 0..1 to stretch the sprite across the whole ceiling
    // triangle 1
    vertex_add_point(vb, x0, y0, z,  0, 0,-1,  0,0, col, 1);
    vertex_add_point(vb, x1, y0, z,  0, 0,-1,  1,0, col, 1);
    vertex_add_point(vb, x1, y1, z,  0, 0,-1,  1,1, col, 1);

    // triangle 2
    vertex_add_point(vb, x1, y1, z,  0, 0,-1,  1,1, col, 1);
    vertex_add_point(vb, x0, y1, z,  0, 0,-1,  0,1, col, 1);
    vertex_add_point(vb, x0, y0, z,  0, 0,-1,  0,0, col, 1);

    vertex_end(vb);

    global.CEILING_VB  = vb;
    global.CEILING_TEX = sprite_get_texture(spr_ceiling, 0);
}