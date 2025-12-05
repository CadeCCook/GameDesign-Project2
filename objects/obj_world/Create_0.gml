var LEVEL = world_init();

global.WALL_HEIGHT    = 128;
global.WALL_TEX_SCALE = 64;
global.WALL_COLOR     = c_gray;

global.WALL_TEX = sprite_get_texture(spr_wall, 0);
global.END_TEX  = sprite_get_texture(spr_end, 0);

world_build_walls();
world_build_ceiling(LEVEL);
world_build_floor(LEVEL);
world_place_enemy(LEVEL);
world_place_boss(LEVEL);
world_place_end(LEVEL);
world_place_hearts();
world_place_trap_buttons();
world_place_spawn(LEVEL);
world_place_torch_light(LEVEL);