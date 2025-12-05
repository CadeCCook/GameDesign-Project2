/// @description Draw the 3D world
draw_clear(c_black);

// Camera
var camera = camera_get_active();

var xfrom = obj_player.x;
var yfrom = obj_player.y;
var zfrom = obj_player.z + 25;
var xto = xfrom + dcos(obj_player.look_dir) * dcos(obj_player.look_pitch);
var yto = yfrom - dsin(obj_player.look_dir) * dcos(obj_player.look_pitch);
var zto = zfrom - dsin(obj_player.look_pitch);

view_mat = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1);
proj_mat = matrix_build_projection_perspective_fov(-60, -window_get_width() / window_get_height(), 1, 32000);
camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);
camera_apply(camera);

// Shaders
shader_set(shd_fog_and_lighting);

// Fog settings
var FOG_START = 100;
var FOG_END = 1000;
shader_set_uniform_f(shader_get_uniform(shd_fog_and_lighting, "fogStart"), FOG_START);
shader_set_uniform_f(shader_get_uniform(shd_fog_and_lighting, "fogEnd"), FOG_END);

// Lighting settings
var MAX_LIGHTS = 4;
var AMBIENT_LIGHT = [0.3, 0.3, 0.3, 1.0];

// Get closest lights to player
var lights = lighting_get_closest_lights(obj_player.x, obj_player.y, obj_player.z, MAX_LIGHTS);

// Count active lights
var num_active_lights = 0;
for (var i = 0; i < MAX_LIGHTS; i++) {
    if (lights[i].range > 1) num_active_lights++;
}

// Apply lighting to shader
lighting_set_shader_uniforms(shd_fog_and_lighting, lights, num_active_lights, AMBIENT_LIGHT);

// Draw World
world_draw_walls();
world_draw_ceiling();
world_draw_floor();
world_draw_end();

shader_reset();

// Draw Billboard Sprites
billboard_draw_sorted();