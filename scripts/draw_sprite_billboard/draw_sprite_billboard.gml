/// draw_sprite_billboard(sprite, subimage, xx, yy, zz, desired_size)
/// Scales sprite so its HEIGHT in world units is desired_size.
function draw_sprite_billboard(sprite, subimage, xx, yy, zz, desired_size = 128)
{
    shader_set(shd_billboard);

    var uCam   = shader_get_uniform(shd_billboard, "u_CamPos");
    var uFogS  = shader_get_uniform(shd_billboard, "u_FogStart");
    var uFogE  = shader_get_uniform(shd_billboard, "u_FogEnd");
    var uMinBr = shader_get_uniform(shd_billboard, "u_MinBright");
    var uMinAl = shader_get_uniform(shd_billboard, "u_MinAlpha");

    shader_set_uniform_f(uCam, obj_player.x, obj_player.y, obj_player.z + 64);

    shader_set_uniform_f(uFogS, 400.0);
    shader_set_uniform_f(uFogE, 2000.0);
    shader_set_uniform_f(uMinBr, 1.0);
    shader_set_uniform_f(uMinAl, 0.15);

    // calculate scaling ratio based on desired size
    var spr_h = sprite_get_height(sprite);
    if (spr_h <= 0) spr_h = 1;
    var scale = desired_size / spr_h;

    matrix_set(matrix_world, matrix_build(xx, yy, zz, 0, 0, 0, 1, 1, 1));

    draw_sprite_ext(sprite, subimage, 0, 0, scale, scale, 0, c_white, 1);

    matrix_set(matrix_world, matrix_build_identity());
    shader_reset();
}
