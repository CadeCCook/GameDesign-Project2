/// @description Initialize grid + walls once


var LEVEL = world_init(); // uses the new helper-based authoring

global.WALL_HEIGHT    = 128;
global.WALL_TEX_SCALE = 64;
global.WALL_COLOR     = c_gray;

// Optional: use a sprite named spr_wall if you add one later
global.WALL_TEX = sprite_get_texture(spr_wall, 0);


world_build_walls();
world_build_ceiling();
world_build_floor(LEVEL);
world_place_enemy(LEVEL);
world_place_end(LEVEL);

// Debug: confirm size at runtime
show_debug_message("WORLD: " + string(global.WORLD_W) + " x " + string(global.WORLD_H)
    + "  CELL=" + string(global.WORLD_CELL));

// Optional: drop player near center if you enabled SPAWN hints in world_init()
// with (instance_find(obj_player, 0)) {
//     if (variable_global_exists("SPAWN_X")) { x = global.SPAWN_X; }
//     if (variable_global_exists("SPAWN_Y")) { y = global.SPAWN_Y; }
// }
