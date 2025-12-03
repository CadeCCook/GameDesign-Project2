if (keyboard_check_pressed(ord("F")))
{
    fullscreen_on = !fullscreen_on;
    window_set_fullscreen(fullscreen_on);
}