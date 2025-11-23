/// obj_minimap – Draw

if (!active) exit;

// Make sure we’re not inheriting weird settings from HUD / helper, etc.
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var W  = global.WORLD_W;
var H  = global.WORLD_H;
var sz = MM_cell_px;
var px = MM_pad;
var py = MM_pad;

// ----- Draw tiles -----
for (var r = 0; r < H; r++) {
    var y0 = py + r * sz;
    for (var c = 0; c < W; c++) {
        var x0 = px + c * sz;
        var v  = global.WORLD_GRID[r * W + c];

        // Pick colour based on tile type
        var col;
        switch (v) {
            case 0: col = MM_col_empty;      break;
            case 1: col = MM_col_wall;       break;
            case 2: col = MM_col_pit;        break;
            case 3: col = MM_col_enemy;      break;
            case 4: col = MM_col_wallTorch;  break;
            case 6: col = MM_col_wallTrap;   break;
            case 5: col = MM_col_hover;      break; // goal – just reusing hover colour
            default: col = MM_col_empty;     break;
        }

        draw_set_color(col);
        draw_rectangle(x0, y0, x0 + sz, y0 + sz, false);
    }
}

// ----- Grid overlay -----
draw_set_color(MM_col_grid);
for (var gy = 0; gy <= H; gy++) {
    var yy = py + gy * sz;
    draw_line(px, yy, px + W * sz, yy);
}
for (var gx = 0; gx <= W; gx++) {
    var xx = px + gx * sz;
    draw_line(xx, py, xx, py + H * sz);
}

// ----- Hover + legend -----
var mx = device_mouse_x(0);
var my = device_mouse_y(0);
var gx = floor((mx - px) / sz);
var gy = floor((my - py) / sz);

// Legend position (fixed)
var legend_x = 16;                    // <- define once, outside the if
var legend_y = py + H * sz + 8;

// Build a small label for the current brush
var mode_name = "";
switch (edit_mode) {
    case 0: mode_name = "Wall";         break;
    case 1: mode_name = "Wall (Torch)"; break;
    case 2: mode_name = "Wall (Trap)";  break;
    case 3: mode_name = "Hole";         break;
    case 4: mode_name = "Enemy";        break;
}

if (gx >= 0 && gx < W && gy >= 0 && gy < H) {
    draw_set_color(MM_col_hover);
    var hx0 = px + gx * sz;
    var hy0 = py + gy * sz;
    draw_rectangle(hx0, hy0, hx0 + sz, hy0 + sz, true);

    draw_set_color(c_white);
    draw_text(
        legend_x,
        legend_y,
        "F1 toggle | Shift = brush (" + mode_name + ") | LMB paint | RMB clear | Ctrl+C copy | (" +
        string(gx) + "," + string(gy) + ")"
    );
} else {
    draw_set_color(c_white);
    draw_text(
        legend_x,
        legend_y,
        "F1 toggle | Shift = brush (" + mode_name + ") | LMB paint | RMB clear | Ctrl+C copy"
    );
}