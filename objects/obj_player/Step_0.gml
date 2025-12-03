	if (mouse_lock && !global.story_active) {

    var cx = window_get_width()  div 2;
    var cy = window_get_height() div 2;

    if (!view_initialized) {
        window_mouse_set(cx, cy);
        view_initialized = true;
    }
    else {
        // Normal mouse-look behavior
        var mx = window_mouse_get_x();
        var my = window_mouse_get_y();

        var dx = mx - cx;
        var dy = my - cy;

        look_dir   -= dx / 10;
        look_pitch += dy / 10;

        if (look_pitch > 80)  look_pitch = 80;
        if (look_pitch < -80) look_pitch = -80;

        // Recenter to the same integer coords
        window_mouse_set(cx, cy);
    }

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
	
    // --- Push player out of enemies so we can't walk through them ---
    with (obj_enemy)
    {
        var min_dist = other.collide_radius + collide_radius;
        var d = point_distance(x, y, other.x, other.y);

        if (d > 0 && d < min_dist)
        {
            var push = min_dist - d;
            // direction from enemy (x,y) to player (other.x, other.y)
            var dir  = point_direction(x, y, other.x, other.y);

            other.x += lengthdir_x(push, dir);
            other.y += lengthdir_y(push, dir);
        }
    }

}

// --- Sword swing ---
if (!attack_armed) {
    if (!mouse_check_button(mb_left)) attack_armed = true;
}

if (swing_timer > 0) swing_timer -= 1;

if (attack_armed && mouse_check_button_pressed(mb_left) && swing_timer <= 0) {
    swing_timer = sword_cooldown;

    global.hud_attack_trigger = true;

    var hits = melee_hit_cone(x, y, look_dir,
                              sword_range,
                              sword_half_angle,
                              sword_damage,
                              sword_knockback);

    if (hits > 0) {
        var fx = instance_create_layer(0, 0, "Instances", obj_slash_fx);
        fx.use_reticle = true;
    }
}

// --- Pit & gravity ---
var tile_here = world_get_cell_at(x, y);
var over_pit  = (tile_here == 2);   // 2 = pit

if (over_pit) {
    vz += gravity_accel;
    z  += vz;
} else {
    if (z > floor_z) {
        vz += gravity_accel;
        z  += vz;
        if (z <= floor_z) { z = floor_z; vz = 0; }
    } else {
        z  = floor_z;
        vz = 0;
    }
}

if (z < death_height) {
    room_restart();
}

if (keyboard_check_pressed(vk_tab)) {
	mouse_lock = !mouse_lock;
}

if (hp <= 0) {
	room_restart();
}

var inEnd = instance_position(x,y, obj_end);
if (inEnd) {
	room_goto(rm_winScreen);
}

/// Trigger fairy helper in tutorial hallway
if (room == rm_tutoriallvl && !global.helper_triggered) {
    var trigger_x = 128 * 10;

    if (x > trigger_x) {
        global.helper_triggered = true;

        with (obj_hud) {
            helper_visible  = true;
            helper_pos_x    = display_get_gui_width() + 64;
            helper_pos_y    = display_get_gui_height() * 0.35;
        }
    }
}