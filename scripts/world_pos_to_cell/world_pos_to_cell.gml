function world_pos_to_cell(wx, wy) {
    var c = global.WORLD_CELL;
    return [ floor(wx / c), floor(wy / c) ];
}
