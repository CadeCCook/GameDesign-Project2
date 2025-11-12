/// world_from_array(level)
/// level: 2D array [rows][cols] of 0/1, fills global.WORLD_GRID and sets WORLD_W/H
function world_from_array(level) {
    var H = array_length(level);
    if (H <= 0) return;
    var W = array_length(level[0]);

    global.WORLD_W = W;
    global.WORLD_H = H;
    global.WORLD_GRID = array_create(W * H, 0);

    for (var r = 0; r < H; r++) {
        var row_index = r * W;
        var row_arr = level[r];
        for (var c = 0; c < W; c++) {
            global.WORLD_GRID[row_index + c] = row_arr[c];
        }
    }
}
