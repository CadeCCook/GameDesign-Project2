
//Turn on z-buffering/depth-buffering (Should always be on)
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

view_mat = undefined;
proj_mat = undefined;

instance_create_depth(x, y, 0, obj_player);

instance_create_depth(x, y, 0,obj_hud);

