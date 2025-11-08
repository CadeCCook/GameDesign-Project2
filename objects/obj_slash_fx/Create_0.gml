// obj_slash_fx: Create

// Lifetime in frames
duration = 10;
t = 0;

// Sweep and size
angle_start = -70;
angle_end   =  40;

// Base “knife-sized” scale
base_scale = (variable_global_exists("HUD_WEAPON_SCALE") ? global.HUD_WEAPON_SCALE : 0.55);

// Big swipe multiplier (10× as requested)
slash_mult = 10.0;

// Where to draw in GUI:
use_reticle = true;       // <<< Option A default (reticle)
// If you prefer HUD origin, set this to false when you spawn the FX.

gui_x = 0;                // optional explicit GUI coords
gui_y = 0;                // (if both non-zero they override the origin choice)

alpha_pow   = 1.4;
slash_sprite = spr_slash;



