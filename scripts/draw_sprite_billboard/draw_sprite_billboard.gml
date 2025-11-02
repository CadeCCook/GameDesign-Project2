/// draw_sprite_billboard(sprite, subimage, xx, yy, zz)
/// Places the sprite at (xx,yy,zz); shader handles facing & fading.
function draw_sprite_billboard(sprite, subimage, xx, yy, zz) {
    shader_set(shd_billboard);

    // uniforms (cache handles globally if you like)
    var uCam   = shader_get_uniform(shd_billboard, "u_CamPos");
    var uFogS  = shader_get_uniform(shd_billboard, "u_FogStart");
    var uFogE  = shader_get_uniform(shd_billboard, "u_FogEnd");
    var uMinBr = shader_get_uniform(shd_billboard, "u_MinBright");
    var uMinAl = shader_get_uniform(shd_billboard, "u_MinAlpha");

    shader_set_uniform_f(uCam, obj_player.x, obj_player.y, obj_player.z + 64);

    // distance fade settings (tweak to taste)
    shader_set_uniform_f(uFogS, 400.0);   // start fading
    shader_set_uniform_f(uFogE, 2000.0);  // fully faded by here
    shader_set_uniform_f(uMinBr, 1.0);    // keep color brightness (or <1 to darken)
    shader_set_uniform_f(uMinAl, 0.15);   // 15% alpha at far

    // world placement
    matrix_set(matrix_world, matrix_build(xx, yy, zz, 0, 0, 0, 1, 1, 1));
    draw_sprite(sprite, subimage, 0, 0);
    matrix_set(matrix_world, matrix_build_identity());

    shader_reset();
}




