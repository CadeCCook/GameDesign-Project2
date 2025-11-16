/// @description Insert description here
if (mouse_lock) {
    look_dir -= (window_mouse_get_x() - window_get_width() / 2) / 10;
    look_pitch += (window_mouse_get_y() - window_get_height() / 2) / 10;
    look_pitch = clamp(look_pitch, -80, 80);
    window_mouse_set(window_get_width() / 2, window_get_height() / 2);

    if (keyboard_check_direct(vk_escape)) {
        game_end();
    }

	var move_speed = 4;
	var dx = 0;
	var dy = 0;

	if (keyboard_check(ord("A"))) {
	    dx -= dsin(look_dir) * move_speed;
	    dy -= dcos(look_dir) * move_speed;
	}

	if (keyboard_check(ord("D"))) {
	    dx += dsin(look_dir) * move_speed;
	    dy += dcos(look_dir) * move_speed;
	}

	if (keyboard_check(ord("W"))) {
	    dx += dcos(look_dir) * move_speed;
	    dy -= dsin(look_dir) * move_speed;
	}

	if (keyboard_check(ord("S"))) {
	    dx -= dcos(look_dir) * move_speed;
	    dy += dsin(look_dir) * move_speed;
	}

	var _moved = world_collision_move(x, y, dx, dy, collide_radius);
	x = _moved[0];
	y = _moved[1];
}

// --- Sword swing ---
// 1) Arm after first mouse release to avoid startup fire
if (!attack_armed) {
    if (!mouse_check_button(mb_left)) attack_armed = true;
}

// 2) Standard cooldown
if (swing_timer > 0) swing_timer -= 1;

// 3) Only allow swings once armed
if (attack_armed && mouse_check_button_pressed(mb_left) && swing_timer <= 0) {
    swing_timer = sword_cooldown;

    // HUD knife anim always starts
    global.hud_attack_trigger = true;

    // Apply damage
    var hits = melee_hit_cone(x, y, look_dir,
                              sword_range,
                              sword_half_angle,
                              sword_damage,
                              sword_knockback);

    // Slash FX ONLY when we hit something
    if (hits > 0) {
        var fx = instance_create_layer(0, 0, "Instances", obj_slash_fx);
        fx.use_reticle = true;  // center on reticle
        // fx.slash_mult = 10.0; // (optional) size override
    }
}

//pit and grav

// Place obj_pit rectangles where you want holes.
// If the player is over a pit, they free-fall.

var over_pit = (instance_position(x, y, obj_pit) != noone);

// Apply gravity
if (over_pit) {
    // Free fall
    vz += gravity_accel;
    z  += vz;
} else {
    if (z > floor_z) {
        // If somehow above floor, let gravity work
        vz += gravity_accel;
        z  += vz;
        if (z <= floor_z) { z = floor_z; vz = 0; }
    } else {
        // Locked to the floor
        z = floor_z;
        vz = 0;
    }
}

// Death if the player falls
if (z < death_height) {
    room_restart();
}

if (keyboard_check_pressed(vk_tab)) {
	mouse_lock = !mouse_lock;
}


// Restart room after running out of health
if (hp <= 0) {
	room_restart();
}