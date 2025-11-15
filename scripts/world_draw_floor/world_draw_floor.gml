function world_draw_floor(){
	
	if (!variable_global_exists("FLOOR_VB")) return;
    if (global.FLOOR_VB == -1) return;
	
	gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);
    gpu_set_cullmode(cull_noculling);
	
	gpu_set_texrepeat(true);
	vertex_submit(global.FLOOR_VB, pr_trianglelist, global.FLOOR_TEX);
	gpu_set_texrepeat(false);
	
}