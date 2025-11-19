function world_build_floor(LEVEL){
    //Create floor vertex format if one doesn't already exist
    if (!variable_global_exists("VFMT_FLOOR")) {
        vertex_format_begin();
        vertex_format_add_position_3d();
        vertex_format_add_normal();
        vertex_format_add_texcoord();
        vertex_format_add_color();
        global.VFMT_FLOOR = vertex_format_end();
    }

    //Delete old floor buffer if it exists
    if (variable_global_exists("FLOOR_VB") && global.FLOOR_VB != -1) {
        vertex_delete_buffer(global.FLOOR_VB);
    }

    var floor_vbuffer = vertex_create_buffer();
    vertex_begin(floor_vbuffer, global.VFMT_FLOOR);

    var tileSize = global.WORLD_CELL;
    var rows     = array_length(LEVEL);
    var cols     = array_length(LEVEL[0]);
    var color    = c_white;

    for (var ty = 0; ty < rows; ty++) {
        for (var tx = 0; tx < cols; tx++) {

            var cell = LEVEL[ty][tx];

            // Skip pits (2) and goal tiles (5) so no grass is drawn there
            if (cell == 2 || cell == 5) {
                continue;
            }

            // IMPORTANT: use the same origin as walls/pits: (tx * cell, ty * cell)
            var i = tx * tileSize;
            var j = ty * tileSize;

            // triangle 1
            vertex_add_point(floor_vbuffer, i,           j,           0, 0,0,1, 0,0, color, 1);
            vertex_add_point(floor_vbuffer, i+tileSize,  j,           0, 0,0,1, 1,0, color, 1);
            vertex_add_point(floor_vbuffer, i+tileSize,  j+tileSize,  0, 0,0,1, 1,1, color, 1);

            // triangle 2
            vertex_add_point(floor_vbuffer, i+tileSize,  j+tileSize,  0, 0,0,1, 1,1, color, 1);
            vertex_add_point(floor_vbuffer, i,           j+tileSize,  0, 0,0,1, 0,1, color, 1);
            vertex_add_point(floor_vbuffer, i,           j,           0, 0,0,1, 0,0, color, 1);
        }
    }

    vertex_end(floor_vbuffer);
    global.FLOOR_VB  = floor_vbuffer;
    global.FLOOR_TEX = sprite_get_texture(spr_grass, 0);
}