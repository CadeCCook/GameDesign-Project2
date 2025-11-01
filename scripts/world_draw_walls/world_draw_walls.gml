function world_draw_walls() {
    if (!variable_global_exists("WALL_VB")) return;
    if (global.WALL_VB == -1) return;

    gpu_set_cullmode(cull_noculling);
    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);

    var tex = (variable_global_exists("WALL_TEX") ? global.WALL_TEX : -1);
    vertex_submit(global.WALL_VB, pr_trianglelist, tex);
}
