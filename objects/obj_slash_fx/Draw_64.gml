// Clean GUI state
shader_reset();
gpu_set_fog(false, make_colour_rgb(0,0,0), 0, 0);
gpu_set_blendenable(true);

// Additive looks great for slashes; switch back after drawing
gpu_set_blendmode(bm_add);

// Where the weapon is *this frame*
var pos = hud_weapon_gui_pos();
var wx = pos[0];
var wy = pos[1];

// Progress 0..1
var p = clamp(t / max(1, duration), 0, 1);

// Ease (cubic smoothstep)
var s = p * p * (3.0 - 2.0 * p);

var ang = lerp(angle_start, angle_end, s);
var sc  = lerp(scale_start, scale_end, s);
sc *= base_scale;

// FIX: use power() instead of pow()
var a   = power(1.0 - p, alpha_pow);  // fade out

draw_set_color(tint);
draw_set_alpha(a);

if (sprite_exists(spr_slash)) {
    var frames = sprite_get_number(spr_slash);
    var frame  = clamp(floor(s * frames), 0, max(0, frames - 1));
    draw_sprite_ext(spr_slash, frame, wx, wy, sc, sc, ang, c_white, a);
} else {
    // Placeholder wedge if you haven't imported the sprite yet
    var r = 64 * sc;
    draw_triangle_color(
        wx, wy,
        wx + lengthdir_x(r, ang-20), wy + lengthdir_y(r, ang-20),
        wx + lengthdir_x(r, ang+20), wy + lengthdir_y(r, ang+20),
        c_white, c_white, c_white, false
    );
}

// Restore state
draw_set_alpha(1);
draw_set_color(c_white);
gpu_set_blendmode(bm_normal);

