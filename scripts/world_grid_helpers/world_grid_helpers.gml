function world_in_bounds(ix, iy) {
    return (ix >= 0) && (ix < global.WORLD_W) && (iy >= 0) && (iy < global.WORLD_H);
}

function world_index(ix, iy) {
    return iy * global.WORLD_W + ix;
}

/// ------------------------------------------------------------------
/// TILE CODES WE'LL USE
/// 0 = empty / floor
/// 1 = normal wall  (random: plain / crack / blood)
/// 2 = hole / pit
/// 3 = enemy spawn
/// 4 = wall (torch)
/// 5 = goal / exit
/// 6 = wall (trap)
/// 7 = heart pickup
/// 8 = player spawn (from LEVEL array)
/// 9 = trap floor button
/// ------------------------------------------------------------------

function world_set_cell(ix, iy, value) {
    if (world_in_bounds(ix, iy)) {
        global.WORLD_GRID[world_index(ix, iy)] = value;
    }
}

// Convenience setters
function world_set_wall(ix, iy)        { world_set_cell(ix, iy, 1); }
function world_set_pit(ix, iy)         { world_set_cell(ix, iy, 2); }
function world_set_enemy(ix, iy)       { world_set_cell(ix, iy, 3); }
function world_set_wall_torch(ix, iy)  { world_set_cell(ix, iy, 4); }
function world_set_goal(ix, iy)        { world_set_cell(ix, iy, 5); }
function world_set_wall_trap(ix, iy)   { world_set_cell(ix, iy, 6); }
function world_set_heart(ix, iy)       { world_set_cell(ix, iy, 7); }

function world_set_trap_button(ix, iy) { world_set_cell(ix, iy, 9); }

// Clear helpers
function world_clear_cell(ix, iy)      { world_set_cell(ix, iy, 0); }
function world_clear_wall(ix, iy)      { world_clear_cell(ix, iy); }

/// Dump WORLD_GRID as 2D LEVEL array to clipboard
function world_grid_dump_array() {
    var W = global.WORLD_W;
    var H = global.WORLD_H;

    var s = "[\n";
    for (var r = 0; r < H; r++) {
        s += "  [";
        for (var c = 0; c < W; c++) {
            var v = global.WORLD_GRID[r * W + c];
            s += string(v);
            if (c < W - 1) s += ",";
        }
        s += "]";
        if (r < H - 1) s += ",\n";
    }
    s += "\n]";
    clipboard_set_text(s);
    show_debug_message("LEVEL copied to clipboard as 2D array.");
}