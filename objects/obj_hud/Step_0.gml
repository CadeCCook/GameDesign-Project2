// ===== obj_hud : Step =====
global.hud_t += 0.06;

// Start swing on click or on player trigger
var start = mouse_check_button_pressed(mb_left);
if (listen_for_trigger && global.hud_attack_trigger) {
    start = true;
    global.hud_attack_trigger = false;
}
if (start) { is_attacking = true; attack_timer = 0; }

// Drive subimage
var dt = 1 / max(1, room_speed);
if (is_attacking) {
    attack_timer += dt;
    var f = max(1, knife_frames);
    sub = clamp(floor((attack_timer / attack_duration) * f), 0, f - 1);
    if (attack_timer >= attack_duration) {
        is_attacking = false;
        attack_timer = 0;
        sub = 0; // back to idle
    }
} else {
    sub = 0;
}


