/// Draw all obj_billboard instances back-to-front and pick 8-way facing frames.
/// Requires: draw_sprite_billboard(spr, subimg, x, y, z)
function billboard_draw_sorted() {
    if (!object_exists(obj_billboard)) return;

    var eye_x = obj_player.x;
    var eye_y = obj_player.y;
    var eye_z = obj_player.z + 64;

    // Collect [dist2, instance] so we can sort far → near
    var list = [];
    var n = instance_number(obj_billboard);
    for (var i = 0; i < n; i++) {
        var inst = instance_find(obj_billboard, i);
        if (!instance_exists(inst)) continue;

        var dx = inst.x - eye_x;
        var dy = inst.y - eye_y;
        var dz = inst.z - eye_z;
        var d2 = dx*dx + dy*dy + dz*dz;

        array_push(list, [d2, inst]);
    }

    // Sort descending by distance (far first)
    array_sort(list, function(a, b) { return b[0] - a[0]; });

    // Optional: normal alpha blending for semi-transparent sprites
    gpu_set_blendenable(true);
    gpu_set_blendmode(bm_normal);

    // Draw in sorted order; auto-pick 8-way facing frame if available
    for (var j = 0; j < array_length(list); j++) {
        var inst = list[j][1];
        if (!instance_exists(inst)) continue;

        var sub = inst.image_index;
        var frames = sprite_get_number(inst.sprite_index);

        if (frames >= 8) {
            // Angle FROM billboard TO player in degrees (0 = right/East, CCW positive)
            var a_to_player = point_direction(inst.x, inst.y, eye_x, eye_y);
            // Quantize to 8 slices (45° each). Offset by 22.5° so boundaries are centered.
            var slice = floor(((a_to_player + 22.5) mod 360) / 45); // 0..7
            sub = slice;
        }

        draw_sprite_billboard(inst.sprite_index, sub, inst.x, inst.y, inst.z);
    }

    // (Leave GPU state as-is for the rest of your pipeline)
}
