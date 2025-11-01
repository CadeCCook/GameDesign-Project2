/// @description Initialize grid + walls once
world_init();

global.WALL_HEIGHT    = 128;
global.WALL_TEX_SCALE = 64;
global.WALL_COLOR     = c_gray;

// Optional: use a sprite named spr_wall if you add one later
var wall_sprite = asset_get_index("spr_wall");
if (wall_sprite != -1) {
    global.WALL_TEX = sprite_get_texture(wall_sprite, 0);
} else {
    global.WALL_TEX = -1; // solid color walls
}

world_build_walls();
world_build_ceiling();
