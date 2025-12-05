var c = global.WORLD_CELL; // 128

image_xscale = global.WORLD_CELL / sprite_width;
image_yscale = global.WORLD_CELL / sprite_height;

activated      = false;
cooldown_timer = 0;

// radius for detecting the player standing on it
trigger_radius = 32;