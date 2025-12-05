var px   = obj_player.x;
var py   = obj_player.y;
var dist = point_distance(x, y, px, py);

var b = 1 - (dist / 600);
b = clamp(b, 0.15, 0.3);


var c = make_color_rgb(255 * b, 255 * b, 255 * b);


draw_sprite_ext(
    sprite_index,
    image_index,
    x, y,
    image_xscale, image_yscale,
    0,
    c,
    1
);