if (!instance_exists(obj_player)) exit;

// Distance to player in 2D
var dx   = obj_player.x - x;
var dy   = obj_player.y - y;
var dist = sqrt(dx*dx + dy*dy);

// If player is close enough, heal & consume
if (dist <= pickup_radius) {

    if (obj_player.hp < obj_player.max_hp) {
        obj_player.hp = clamp(obj_player.hp + pickup_amount, 0, obj_player.max_hp);
    }

    // Consume the pickup even if at max HP (you can remove this if you only
    // want it to disappear when it actually heals)
    instance_destroy();
}