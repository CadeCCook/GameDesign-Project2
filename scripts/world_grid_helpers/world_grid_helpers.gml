/// Grid helper functions (no lambdas; avoid reserved identifiers)

function world_in_bounds(ix, iy) {
    return (ix >= 0) && (ix < global.WORLD_W) && (iy >= 0) && (iy < global.WORLD_H);
}
function world_index(ix, iy) {
    return iy * global.WORLD_W + ix;
}
function world_set_wall(ix, iy) {
    if (world_in_bounds(ix, iy)) {
        global.WORLD_GRID[world_index(ix, iy)] = 1;
    }
}
function world_clear_wall(ix, iy) {
    if (world_in_bounds(ix, iy)) {
        global.WORLD_GRID[world_index(ix, iy)] = 0;
    }
}
function world_fill_rect(ix, iy, w, h) {
    if (w < 0) { ix += w; w = -w; }
    if (h < 0) { iy += h; h = -h; }
    var x0 = max(0, ix);
    var y0 = max(0, iy);
    var x1 = min(global.WORLD_W - 1, ix + w - 1);
    var y1 = min(global.WORLD_H - 1, iy + h - 1);
    for (var ry = y0; ry <= y1; ry++) {
        var row = ry * global.WORLD_W;
        for (var rx = x0; rx <= x1; rx++) {
            global.WORLD_GRID[row + rx] = 1;
        }
    }
}
function world_line_h(x0, rowY, x1) {
    var xa = clamp(min(x0, x1), 0, global.WORLD_W - 1);
    var xb = clamp(max(x0, x1), 0, global.WORLD_W - 1);
    var yy = clamp(rowY,       0, global.WORLD_H - 1);
    var row = yy * global.WORLD_W;
    for (var rx = xa; rx <= xb; rx++) {
        global.WORLD_GRID[row + rx] = 1;
    }
}
function world_line_v(colX, y0, y1) {
    var ya = clamp(min(y0, y1), 0, global.WORLD_H - 1);
    var yb = clamp(max(y0, y1), 0, global.WORLD_H - 1);
    var xx = clamp(colX,        0, global.WORLD_W - 1);
    for (var ry = ya; ry <= yb; ry++) {
        global.WORLD_GRID[ry * global.WORLD_W + xx] = 1;
    }
}

/// Dump current grid as a 2D array literal (to clipboard & console)
function world_grid_dump_array() {
    var W = global.WORLD_W, H = global.WORLD_H;
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
