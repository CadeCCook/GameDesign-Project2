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
        var row_arr   = level[r];
        var row_index = r * W;
        for (var c = 0; c < W; c++) {
            global.WORLD_GRID[row_index + c] = row_arr[c];
        }
    }
}

function world_get_cell_at(px, py) {
    var c = global.WORLD_CELL;

    // Convert world position → grid index
    var gx = floor(px / c);
    var gy = floor(py / c);

    // Safety: treat outside the level as solid
    if (gx < 0 || gx >= global.WORLD_W || gy < 0 || gy >= global.WORLD_H) {
        return 1; // wall
    }

    return global.WORLD_GRID[gy * global.WORLD_W + gx];
}