gpu_set_cullmode(cull_noculling);
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

vertex_submit(goal_vb, pr_trianglelist, goal_tex);