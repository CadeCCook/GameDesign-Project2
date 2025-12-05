var z = 16; // height above floor

// Billboard sprite that always faces the camera
draw_sprite_billboard(
    sprite_index,   // which sprite
    image_index,    // current subimage
    x,              // world X
    y,              // world Y
    z,              // world Z height
    64              // desired height of the heart in world units
);