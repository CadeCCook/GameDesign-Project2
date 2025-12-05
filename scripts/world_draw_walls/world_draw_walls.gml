function world_draw_walls() {
    gpu_set_cullmode(cull_noculling);
    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);

    // Plain walls
    if (variable_global_exists("WALL_VB") && global.WALL_VB != -1) {
        var tex_plain = sprite_get_texture(spr_wall, 0);
        vertex_submit(global.WALL_VB, pr_trianglelist, tex_plain);
    }

    // Cracked walls
    if (variable_global_exists("WALL_VB_CRACK") && global.WALL_VB_CRACK != -1) {
        var tex_crack = sprite_get_texture(spr_wallCrack, 0);
        vertex_submit(global.WALL_VB_CRACK, pr_trianglelist, tex_crack);
    }

    // Bloody walls
    if (variable_global_exists("WALL_VB_BLOOD") && global.WALL_VB_BLOOD != -1) {
        var tex_blood = sprite_get_texture(spr_wallBlood, 0);
        vertex_submit(global.WALL_VB_BLOOD, pr_trianglelist, tex_blood);
    }

    // Torch walls (cell = 4)
    if (variable_global_exists("WALL_VB_TORCH") && global.WALL_VB_TORCH != -1) {
        var tex_torch = sprite_get_texture(spr_wallTorch, 0);
        vertex_submit(global.WALL_VB_TORCH, pr_trianglelist, tex_torch);
    }
	
	// End walls (cell = 5)
    if (variable_global_exists("WALL_VB_END") && global.WALL_VB_END != -1) {
        var tex_end = sprite_get_texture(Door_Tile, 0);
        vertex_submit(global.WALL_VB_END, pr_trianglelist, tex_end);
	}

    // Trap walls (cell = 6)
    if (variable_global_exists("WALL_VB_TRAP") && global.WALL_VB_TRAP != -1) {
        var tex_trap = sprite_get_texture(spr_wallTrap, 0);
        vertex_submit(global.WALL_VB_TRAP, pr_trianglelist, tex_trap);
    }
}
