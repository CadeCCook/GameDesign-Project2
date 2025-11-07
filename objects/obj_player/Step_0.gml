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
if (swing_timer > 0) swing_timer -= 1;

if (mouse_check_button_pressed(mb_left) && swing_timer <= 0) {
    swing_timer = sword_cooldown;

    // apply damage
    var hits = melee_hit_cone(x, y, look_dir,
                              sword_range,
                              sword_half_angle,
                              sword_damage,
                              sword_knockback);

    // only show slash if we hit at least one enemy
    if (hits > 0) {
        // GUI slash arc (bigger size set in obj_hud/obj_slash_fx already)
        instance_create_depth(0, 0, 0, obj_slash_fx);

        // optional: reuse flash only on hit
        global.muzzle_timer = 4;
    }
}

// ================== NEW: PITS + GRAVITY ==================
//
// We treat any area covered by instances of obj_pit as "no floor".
// Place obj_pit rectangles where you want holes.
// If the player is over a pit, they free-fall. Otherwise they snap to floor_z.

var over_pit = (instance_position(x, y, obj_pit) != noone);

// Apply gravity
if (over_pit) {
    // Free fall
    vz += gravity_accel;
    z  += vz;
} else {
    // On floor – settle on floor height
    if (z > floor_z) {
        // If somehow above floor, let gravity pull us down to it smoothly
        vz += gravity_accel;
        z  += vz;
        if (z <= floor_z) { z = floor_z; vz = 0; }
    } else {
        // Locked to the floor
        z = floor_z;
        vz = 0;
    }
}

// Death if we fell too far
if (z < death_height) {
    // Simple: restart room. Replace with your own respawn/HP logic if desired.
    room_restart();
}

if (keyboard_check_pressed(vk_tab)) {
	mouse_lock = !mouse_lock;
}
