function world_draw_walls()
{
    // If the globals don’t exist yet, nothing to draw
    if (!variable_global_exists("WALL_VB_plain")) return;

    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);
    gpu_set_cullmode(cull_noculling);

    gpu_set_texrepeat(true);

    if (global.WALL_VB_plain != -1) {
        vertex_submit(global.WALL_VB_plain, pr_trianglelist, global.WALL_TEX_plain);
    }
    if (global.WALL_VB_crack != -1) {
        vertex_submit(global.WALL_VB_crack, pr_trianglelist, global.WALL_TEX_crack);
    }
    if (global.WALL_VB_blood != -1) {
        vertex_submit(global.WALL_VB_blood, pr_trianglelist, global.WALL_TEX_blood);
    }

    gpu_set_texrepeat(false);
}
