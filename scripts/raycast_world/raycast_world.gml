/// raycast_world(x0, y0, dir_deg, max_dist) -> [hit, dist, hx, hy]
function raycast_world(x0, y0, dir_deg, max_dist) {
    // stub: always "no wall hit"
    return [false, max_dist, x0 + dcos(dir_deg)*max_dist, y0 - dsin(dir_deg)*max_dist];
}