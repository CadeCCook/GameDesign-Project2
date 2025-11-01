function world_draw_ceiling() {
    if (!variable_global_exists("VB_CEILING")) return;
    if (global.VB_CEILING == -1) return;

    // Make sure depth testing is on so the ceiling respects occlusion
    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);
    gpu_set_cullmode(cull_noculling);

    // Color-only by default; set global.CEILING_TEX to a texture if you want
    vertex_submit(global.VB_CEILING, pr_trianglelist, global.CEILING_TEX);
}
