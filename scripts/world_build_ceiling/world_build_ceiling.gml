/// Build a simple tiled ceiling mesh that matches your ground scale.
/// Uses the same color as the walls (global.WALL_COLOR if set, else c_gray).
function world_build_ceiling() {
    if (!variable_global_exists("VFMT_FLAT")) {
        var fmt = vertex_format_begin();
        vertex_format_add_position_3d();
        vertex_format_add_texcoord();
        vertex_format_add_color();
        global.VFMT_FLAT = vertex_format_end();
    }

    if (variable_global_exists("VB_CEILING") && global.VB_CEILING != -1) {
        vertex_delete_buffer(global.VB_CEILING);
    }

    var k    = 50;
    var cell = 128;
    var zc   = 256;

    var CEIL_COLOR = variable_global_exists("WALL_COLOR") ? global.WALL_COLOR : c_gray;

    var vb = vertex_create_buffer();
    vertex_begin(vb, global.VFMT_FLAT);

    for (var i = -k; i < k; i++) {
        var x1 = i * cell;
        var x2 = (i + 1) * cell;
        for (var j = -k; j < k; j++) {
            var y1 = j * cell;
            var y2 = (j + 1) * cell;

            // tri 1
            vertex_position_3d(vb, x1, y1, zc);
            vertex_texcoord(vb, 0, 0);
            vertex_color(vb, CEIL_COLOR, 1);

            vertex_position_3d(vb, x2, y1, zc);
            vertex_texcoord(vb, 16, 0);
            vertex_color(vb, CEIL_COLOR, 1);

            vertex_position_3d(vb, x2, y2, zc);
            vertex_texcoord(vb, 16, 16);
            vertex_color(vb, CEIL_COLOR, 1);

            // tri 2
            vertex_position_3d(vb, x1, y1, zc);
            vertex_texcoord(vb, 0, 0);
            vertex_color(vb, CEIL_COLOR, 1);

            vertex_position_3d(vb, x2, y2, zc);
            vertex_texcoord(vb, 16, 16);
            vertex_color(vb, CEIL_COLOR, 1);

            vertex_position_3d(vb, x1, y2, zc);
            vertex_texcoord(vb, 0, 16);
            vertex_color(vb, CEIL_COLOR, 1);
        }
    }

    vertex_end(vb);
    global.VB_CEILING = vb;
    global.CEILING_TEX = -1;
}
