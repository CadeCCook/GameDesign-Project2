function world_place_enemy(LEVEL)
{
    var tileSize = global.WORLD_CELL;
    var rows = array_length(LEVEL);       // 24
    var cols = array_length(LEVEL[0]);    // 32

    for (var ty = 0; ty < rows; ty++) {
        for (var tx = 0; tx < cols; tx++) {

            // 3 = enemy spawn
            if (LEVEL[ty][tx] == 3) {


                var xw = (tx + 0.5) * tileSize;
                var yw = (ty + 0.5) * tileSize;

                instance_create_depth(xw, yw, 0, obj_enemy);
            }
        }
    }
}