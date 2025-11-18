/// obj_fadeIn – Step
alpha -= fade_speed;

if (alpha <= 0) {
    instance_destroy(); // done fading
}