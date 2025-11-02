/// @description Insert description here
z = 64;
look_dir = 0;
look_pitch = 0;
mouse_lock = true;

// collision radius for sliding against grid walls
collide_radius = 24;

// weapon
sword_range       = 120;   // how close you must be
sword_half_angle  = 35;    // degrees to each side of look_dir
sword_damage      = 25;
sword_knockback   = 8;     // pixels pushed on hit
sword_cooldown    = 16;    // frames between swings
swing_timer       = 0;     // counts down after a swing
