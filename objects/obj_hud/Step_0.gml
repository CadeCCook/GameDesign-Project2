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


/// obj_hud – Step (fairy movement + dialogue)

// Move the fairy if it's visible
if (helper_visible) {
    if (helper_pos_x > helper_target_x) {
        helper_pos_x -= helper_speed;

        if (helper_pos_x < helper_target_x) {
            helper_pos_x = helper_target_x;
        }
    }
    else {
        // Fairy has arrived at its target — trigger dialogue once
        if (!helper_message_shown) {
            helper_message_shown = true;
            helper_talking       = true;

            // change this line to whatever you want the fairy to say
            helper_text = "Use W, A, S, D to move and your mouse to look around. \nPress the left mouse button to attack the enemy. \nMake sure you don't fall into the pit!!!";

            helper_text_timer = helper_text_duration;
        }
    }
}


// helper movement
if (helper_visible) {
    // Smooth vertical hover
    helper_hover_phase += 0.08; // smaller = slower

    // Random left/right sway
    if (helper_sway_timer <= 0) {
        helper_sway_target = irandom_range(-8, 8);

        helper_sway_timer = irandom_range(room_speed div 2, room_speed * 2);
    } else {
        helper_sway_timer -= 1;
    }

    // Smoothly move toward the sway target
    if (helper_sway_offset < helper_sway_target) {
        helper_sway_offset = min(helper_sway_offset + helper_sway_speed, helper_sway_target);
    } else if (helper_sway_offset > helper_sway_target) {
        helper_sway_offset = max(helper_sway_offset - helper_sway_speed, helper_sway_target);
    }
}


// Handle dialogue timer
if (helper_talking) {
    helper_text_timer -= 1;

    if (helper_text_timer <= 0) {
        helper_talking = false;
    }
}