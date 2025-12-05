if (!instance_exists(obj_player)) exit;

// simple cooldown
if (cooldown_timer > 0) {
    cooldown_timer -= 1;
}

// distance to player in 2D
var dx   = obj_player.x - x;
var dy   = obj_player.y - y;
var dist = sqrt(dx*dx + dy*dy);

// “stepping on” the button
if (dist <= trigger_radius && cooldown_timer <= 0) {

    // fire all traps
    world_traps_fire_all();

    cooldown_timer = 90; // 1.5 seconds @ 60 FPS before it can trigger again
}