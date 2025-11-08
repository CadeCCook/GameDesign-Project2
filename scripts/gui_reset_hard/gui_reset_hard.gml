/// gui_reset_hard()
function gui_reset_hard() {
    // Reset enough GPU state so HUD draws in full color over the 3D pass
    shader_reset();

    gpu_set_blendenable(true);
    gpu_set_blendmode(bm_normal);

    gpu_set_ztestenable(false);
    gpu_set_zwriteenable(false);
    gpu_set_alphatestenable(false);

    // Make sure RGB + A writes are enabled (prevents grayscale silhouettes)
    gpu_set_colorwriteenable(true, true, true, true);

    // Optional safety; harmless either way
    gpu_set_cullmode(cull_noculling);
    gpu_set_fog(false, c_black, 0, 0);

    // Don’t rely on global draw color anywhere—pass c_white in draw calls
    draw_set_alpha(1);
}

