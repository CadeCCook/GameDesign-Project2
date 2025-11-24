function world_draw_floor()
{
    // No floor built yet?
    if (!variable_global_exists("FLOOR_VB")) return;

    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);
    gpu_set_cullmode(cull_noculling);

    gpu_set_texrepeat(true);

    // Plain floor
    if (global.FLOOR_VB != -1) {
        var tex_plain = sprite_get_texture(spr_floor, 0);
        vertex_submit(global.FLOOR_VB, pr_trianglelist, tex_plain);
    }

    // Bloody floor variant 1
    if (variable_global_exists("FLOOR_VB_BLOOD") && global.FLOOR_VB_BLOOD != -1) {
        var tex_blood = sprite_get_texture(spr_bloodyFloor, 0);
        vertex_submit(global.FLOOR_VB_BLOOD, pr_trianglelist, tex_blood);
    }

    // Bloody floor variant 2
    if (variable_global_exists("FLOOR_VB_BLOOD2") && global.FLOOR_VB_BLOOD2 != -1) {
        var tex_blood2 = sprite_get_texture(spr_bloodyFloor2, 0);
        vertex_submit(global.FLOOR_VB_BLOOD2, pr_trianglelist, tex_blood2);
    }

    gpu_set_texrepeat(false);
}