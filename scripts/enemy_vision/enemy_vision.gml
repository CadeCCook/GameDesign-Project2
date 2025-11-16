function enemy_vision()
{
    var _vision_range = 1000;

    // player position
    var px = obj_player.x;
    var py = obj_player.y;

    // Distance check
    var dist_to = point_distance(x, y, px, py);
    if (dist_to > _vision_range) {
        can_see_player = false;
        exit;
    }

    // Direction to the player
    var dir_to_player = point_direction(x, y, px, py);

    // Raycast from enemy to the player
    var max_cast = max(dist_to - 2, 0);
    var r = raycast_world(x, y, dir_to_player, max_cast);

    // If something blocks the ray then no line of sight
    if (r.hit && r.dist < max_cast) {
        can_see_player = false;
        exit;
    }

    // Clear line of sight
    can_see_player = true;
}
