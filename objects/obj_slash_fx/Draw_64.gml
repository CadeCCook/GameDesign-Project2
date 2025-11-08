// === obj_slash_fx : Draw GUI (reticle-centered) ===
gui_reset_hard();                   // keep HUD colors/blending sane
gpu_set_blendmode(bm_add);         // additive looks good for slashes

// 1) Choose anchor in GUI
var gw = display_get_gui_width();
var gh = display_get_gui_height();

var wx, wy;
if (use_reticle) {
    wx = gw * 0.5;
    wy = gh * 0.5;
} else {
    var p = hud_weapon_gui_pos();
    wx = p[0]; wy = p[1];
}

// 2) Progress + big scale
var p = clamp(t / max(1, duration), 0, 1);
t += 1; if (t >= duration) instance_destroy();

var sc_base = (variable_global_exists("HUD_WEAPON_SCALE") ? global.HUD_WEAPON_SCALE : 0.55);
var sc      = sc_base * slash_mult * lerp(1.00, 1.08, p);
var ang     = lerp(angle_start, angle_end, p);

// 3) Draw the slash EXACTLY centered on (wx, wy), no matter the sprite origin
if (sprite_exists(slash_sprite)) {
    var w  = sprite_get_width(slash_sprite);
    var h  = sprite_get_height(slash_sprite);
    var ox = sprite_get_xoffset(slash_sprite);
    var oy = sprite_get_yoffset(slash_sprite);

    // desired pivot is sprite center (px,py)
    var px = w * 0.5;
    var py = h * 0.5;

    // rotate the vector from origin->center so that (wx,wy) becomes the center pixel
    var dx  = (px - ox) * sc;
    var dy  = (py - oy) * sc;
    var ca  = dcos(ang);
    var sa  = dsin(ang);
    var rx  = dx * ca - dy * sa;
    var ry  = dx * sa + dy * ca;

    // place origin so the rotated center lands on (wx,wy)
    var draw_x = wx - rx;
    var draw_y = wy - ry;

    var a = power(1 - p, alpha_pow);
    draw_set_alpha(a);
    draw_sprite_ext(slash_sprite, 0, draw_x, draw_y, sc, sc, ang, c_white, 1);
    draw_set_alpha(1);
}

gpu_set_blendmode(bm_normal);
