function world_place_end(LEVEL)
{
    var tileSize = global.WORLD_CELL;
    var rows = array_length(LEVEL);
    var cols = array_length(LEVEL[0]);

    if (variable_global_exists("END_VB") && global.END_VB != -1) {
        vertex_delete_buffer(global.END_VB);
    }
    global.END_VB  = -1;
    global.END_TEX = sprite_get_texture(spr_end, 0);

    for (var ty = 0; ty < rows; ty++) {
        for (var tx = 0; tx < cols; tx++) {

            if (LEVEL[ty][tx] == 5) {
                var xw = (tx + 0.5) * tileSize;
                var yw = (ty + 0.5) * tileSize;
                instance_create_depth(xw, yw, 0, obj_end);
            }
        }
    }
}