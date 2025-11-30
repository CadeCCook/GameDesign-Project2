if (!instance_exists(obj_player)) exit;

// Distance to player in 2D
var dx   = obj_player.x - x;
var dy   = obj_player.y - y;
var dist = sqrt(dx*dx + dy*dy);

if (dist <= pickup_radius) {

    with (obj_player) {
        if (hp < max_hp) {
            hp = clamp(hp + other.pickup_amount, 0, max_hp);
        }
        // If already at max HP, we still consume the pickup.
    }

    instance_destroy();
}