/// @description Insert description here
z = 64;
look_dir   = 0;
look_pitch = -5;
mouse_lock = true;

view_initialized = false;

window_mouse_set(window_get_width() / 2, window_get_height() / 2);
// collision radius for sliding against grid walls
collide_radius = 24;


max_hp = 100;
hp = max_hp;



// weapon
sword_range       = 120;   // how close you must be
sword_half_angle  = 35;    // degrees to each side of look_dir
sword_damage      = 25;
sword_knockback   = 8;     // pixels pushed on hit
sword_cooldown    = 16;    // frames between swings
swing_timer       = 0;     // counts down after a swing

vz              = 0;      // vertical velocity
gravity_accel   = -0.9;   // negative pulls you “down” (toward smaller z)
floor_z         = 64;     // height of walkable floor
death_height    = -200;   // fall below this => die

// Prevent an immediate swing/FX on room start
attack_armed = false;

// Reset any globals that might carry across rooms
global.hud_attack_trigger = false;

// (already have) ensure HUD exists + default scale if you want
if (!instance_exists(obj_hud)) instance_create_layer(0,0,"Instances",obj_hud);
if (!variable_global_exists("HUD_WEAPON_SCALE")) global.HUD_WEAPON_SCALE = 0.55;

if (!variable_global_exists("story_active")) {
    global.story_active = false;
}