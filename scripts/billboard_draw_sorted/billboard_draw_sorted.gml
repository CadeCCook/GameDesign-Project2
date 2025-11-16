/// Draw all obj_billboard instances back-to-front and pick 8-way facing frames.
/// Requires: draw_sprite_billboard(spr, subimg, x, y, z)
function billboard_draw_sorted() {
    if (!object_exists(obj_enemy)) return;

    var eye_x = obj_player.x;
    var eye_y = obj_player.y;
    var eye_z = obj_player.z + 64;

    // Collect [dist2, instance] and sort far -> near
    var list = [];
    var n = instance_number(obj_enemy);
    for (var i = 0; i < n; i++) {
        var inst = instance_find(obj_enemy, i);
        if (!instance_exists(inst)) continue;
        var dx = inst.x - eye_x, dy = inst.y - eye_y, dz = inst.z - eye_z;
        array_push(list, [dx*dx + dy*dy + dz*dz, inst]);
    }
    array_sort(list, function(a,b){ return b[0] - a[0]; });

    // Optional: avoid z-write for translucent quads
    // gpu_set_zwriteenable(false);

    gpu_set_blendenable(true);
    gpu_set_blendmode(bm_normal);

    for (var j = 0; j < array_length(list); j++) {
        var inst = list[j][1];
        if (!instance_exists(inst)) continue;

        // 8-way facing
        var sub = inst.image_index;
        var frames = sprite_get_number(inst.sprite_index);
        if (frames >= 8) {
            var a_to_player = point_direction(inst.x, inst.y, eye_x, eye_y);
            sub = floor(((a_to_player + 22.5) mod 360) / 45); // 0..7
        }

        // --- hit flash tint lives HERE (inst is in scope) ---
        if (!variable_instance_exists(inst, "hit_flash")) inst.hit_flash = 0;
        if (inst.hit_flash > 0) inst.hit_flash--;

        var t = inst.hit_flash / 8.0;
        var tint = merge_color(c_white, c_red, t);
        draw_set_color(tint);
        draw_set_alpha(1);

        // draw the billboard
        draw_sprite_billboard(inst.sprite_index, sub, inst.x, inst.y, inst.z);

        // reset state
        draw_set_color(c_white);
        draw_set_alpha(1);
    }

    // gpu_set_zwriteenable(true);
}

