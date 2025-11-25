function world_draw_ceiling()
{
    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);
    gpu_set_cullmode(cull_noculling);

    if (variable_global_exists("CEILING_VB") && global.CEILING_VB != -1)
    {
        vertex_submit(global.CEILING_VB, pr_trianglelist, global.CEILING_TEX);
    }
}
