if (!active) exit;

var W  = global.WORLD_W;
var H  = global.WORLD_H;
var sz = MM_cell_px;
var px = MM_pad;
var py = MM_pad;

draw_set_alpha(1);

for (var r = 0; r < H; r++) {
    var y0 = py + r * sz;
    for (var c = 0; c < W; c++) {
        var x0 = px + c * sz;
        var v = global.WORLD_GRID[r * W + c];
        draw_set_color(v == 1 ? MM_col_wall : MM_col_empty);
        draw_rectangle(x0, y0, x0 + sz, y0 + sz, false);
    }
}

// Grid lines
draw_set_color(MM_col_grid);
for (var rr = 0; rr <= H; rr++) {
    var yy = py + rr * sz;
    draw_line(px, yy, px + W * sz, yy);
}
for (var cc = 0; cc <= W; cc++) {
    var xx = px + cc * sz;
    draw_line(xx, py, xx, py + H * sz);
}

// Hover + legend
var mx = device_mouse_x(0);
var my = device_mouse_y(0);
var gx = floor((mx - px) / sz);
var gy = floor((my - py) / sz);
if (gx >= 0 && gx < W && gy >= 0 && gy < H) {
    draw_set_color(MM_col_hover);
    var hx0 = px + gx * sz;
    var hy0 = py + gy * sz;
    draw_rectangle(hx0, hy0, hx0 + sz, hy0 + sz, true);
    draw_text(px, py + H * sz + 8, "F1 toggle | LMB add | RMB erase | Ctrl+C copy | (" + string(gx) + "," + string(gy) + ")");
} else {
    draw_text(px, py + H * sz + 8, "F1 toggle | LMB add | RMB erase | Ctrl+C copy");
}
