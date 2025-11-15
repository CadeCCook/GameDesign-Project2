/// @description Draw the 3D world
draw_clear(c_black);

// 3D projections require a view and projection matrix
var camera = camera_get_active();

var xfrom = obj_player.x;
var yfrom = obj_player.y;
var zfrom = obj_player.z + 64;
var xto = xfrom + dcos(obj_player.look_dir) * dcos(obj_player.look_pitch);
var yto = yfrom - dsin(obj_player.look_dir) * dcos(obj_player.look_pitch);
var zto = zfrom - dsin(obj_player.look_pitch);

view_mat = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1);
proj_mat = matrix_build_projection_perspective_fov(-60, -window_get_width() / window_get_height(), 1, 32000);
camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);
camera_apply(camera);

//fog, mainly test might implement onto more later

var fog_col = c_grey;
gpu_set_fog(true, fog_col, 1200, 8000);


/*
// Everything must be drawn after the 3D projection has been set
gpu_set_texrepeat(true);
vertex_submit(vbuffer, pr_trianglelist, ground_tex);
gpu_set_texrepeat(false);
*/


shader_reset();


world_draw_walls();
world_draw_ceiling();
world_draw_floor();

// Sorted billboard pass
billboard_draw_sorted();


