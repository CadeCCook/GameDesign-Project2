var z = 16; // tweak if you want it higher/lower

// Billboard sprite that always faces the camera
draw_sprite_billboard(
    sprite_index,   // which sprite
    image_index,    // current subimage
    x,              // world X
    y,              // world Y
    z,              // world Z height
    c_white         // colour (no tint)
);