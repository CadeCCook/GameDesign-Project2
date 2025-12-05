function world_place_trap_buttons()
{
    // clear old ones
    with (obj_trapButton) instance_destroy();

    var tileSize = global.WORLD_CELL;
    var W        = global.WORLD_W;
    var H        = global.WORLD_H;

    for (var ty = 0; ty < H; ty++) {
        for (var tx = 0; tx < W; tx++) {
            var idx = ty * W + tx;

            // 9 = trap button tile in WORLD_GRID
            if (global.WORLD_GRID[idx] == 9) {
                var bx = (tx + 0.5) * tileSize;
                var by = (ty + 0.5) * tileSize;
                instance_create_depth(bx, by, 0, obj_trapButton);
            }
        }
    }
}