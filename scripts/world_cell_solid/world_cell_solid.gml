function world_cell_solid(ci, cj) {
    if (ci < 0 || cj < 0 || ci >= global.WORLD_W || cj >= global.WORLD_H) {
        return true; // out of bounds = solid
    }
    return global.WORLD_GRID[cj * global.WORLD_W + ci] == 1;
}
