/// Minimap overlay: F1 to toggle; paint walls with mouse.
visible = false;   // start hidden
active  = false;   // start disabled

MM_cell_px   = 16;      // pixel size per cell
MM_pad       = 10;      // padding from top-left
MM_col_empty = make_color_rgb(30, 80, 30);
MM_col_wall  = make_color_rgb(180, 180, 180);
MM_col_grid  = make_color_rgb(60, 60, 60);
MM_col_hover = make_color_rgb(240, 240, 80);

// (Optional) expose a flag if other systems care about UI state
global.MINIMAP_ACTIVE = false;


