function world_draw_ceiling() {
    if (!variable_global_exists("VB_CEILING")) return;
    if (global.VB_CEILING == -1) return;

    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);
    gpu_set_cullmode(cull_noculling);

    vertex_submit(global.VB_CEILING, pr_trianglelist, global.CEILING_TEX);
}
