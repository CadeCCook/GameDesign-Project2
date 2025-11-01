function world_init() {
    // world/grid constants
    global.WORLD_CELL = 128; // units per cell
    global.WORLD_W    = 16;
    global.WORLD_H    = 12;

    // 0 = empty, 1 = wall (borders solid)
    var M = [
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,1],
        [1,0,0,0,0,0,0,1,0,0,1,0,0,0,0,1],
        [1,0,0,0,0,0,0,1,0,0,1,0,0,0,0,1],
        [1,0,0,0,0,0,0,1,1,0,1,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,1,0,1,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,1,0,1,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
    ];

    // Flatten to 1D array (row-major)
    global.WORLD_GRID = array_create(global.WORLD_W * global.WORLD_H, 0);
    for (var iy = 0; iy < global.WORLD_H; iy++) {
        for (var ix = 0; ix < global.WORLD_W; ix++) {
            global.WORLD_GRID[iy * global.WORLD_W + ix] = M[iy][ix];
        }
    }
}
