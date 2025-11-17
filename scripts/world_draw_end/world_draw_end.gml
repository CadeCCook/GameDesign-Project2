function world_draw_end(){
    if (!variable_global_exists("END_VB")) return;
    if (global.END_VB == -1) return;

    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);
    gpu_set_cullmode(cull_noculling);

    gpu_set_texrepeat(true);
    vertex_submit(global.END_VB, pr_trianglelist, global.END_TEX);
    gpu_set_texrepeat(false);
}
