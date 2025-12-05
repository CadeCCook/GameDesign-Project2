function world_cell_solid(ci, cj) {
    if (ci < 0 || cj < 0 || ci >= global.WORLD_W || cj >= global.WORLD_H) {
        return true; // out of bounds = solid
    }

    var v = global.WORLD_GRID[cj * global.WORLD_W + ci];

    // 1 = normal wall
    // 4 = wall (Torch)
    // 5 = goal / exit (door)
    // 6 = wall (Trap)
    return (v == 1) || (v == 4) || (v == 5) || (v == 6);
}