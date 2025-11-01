function world_collision_move(px, py, dx, dy, radius) {
    var _solid_at = function(wx, wy) {
        var cell = world_pos_to_cell(wx, wy);
        return world_cell_solid(cell[0], cell[1]);
    };

    var nx = px + dx;
    var ny = py;

    if (_solid_at(nx - radius, ny - radius) || _solid_at(nx - radius, ny + radius)
    ||  _solid_at(nx + radius, ny - radius) || _solid_at(nx + radius, ny + radius)) {
        nx = px;
    }

    var ny2 = ny + dy;
    if (_solid_at(nx - radius, ny2 - radius) || _solid_at(nx - radius, ny2 + radius)
    ||  _solid_at(nx + radius, ny2 - radius) ||  _solid_at(nx + radius, ny2 + radius)) {
        ny2 = ny;
    }

    return [nx, ny2];
}
