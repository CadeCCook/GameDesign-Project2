function world_place_hearts()
{
    // Remove any existing heart instances
    with (obj_heart) instance_destroy();

    var tileSize = global.WORLD_CELL;
    var W = global.WORLD_W;
    var H = global.WORLD_H;

    for (var ty = 0; ty < H; ty++) {
        for (var tx = 0; tx < W; tx++) {

            var idx = ty * W + tx;

            // 7 = heart tile in WORLD_GRID
            if (global.WORLD_GRID[idx] == 7) {
                var hx = (tx + 0.5) * tileSize;
                var hy = (ty + 0.5) * tileSize;

                instance_create_depth(hx, hy, 0, obj_heart);
            }
        }
    }
}