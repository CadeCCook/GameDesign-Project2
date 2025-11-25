/// @description Initialize grid + walls once


var LEVEL = world_init(); // uses the new helper-based authoring

global.WALL_HEIGHT    = 128;
global.WALL_TEX_SCALE = 64;
global.WALL_COLOR     = c_gray;

// Optional: use a sprite named spr_wall if you add one later
global.WALL_TEX = sprite_get_texture(spr_wall, 0);

// set goal texture
global.END_TEX = sprite_get_texture(spr_end, 0);

world_build_walls();
world_build_ceiling(LEVEL);
world_build_floor(LEVEL);
world_place_enemy(LEVEL);
world_place_end(LEVEL);

