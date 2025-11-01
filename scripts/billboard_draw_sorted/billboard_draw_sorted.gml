/// Draw all obj_billboard back-to-front and pick 8-way facing frames
function billboard_draw_sorted() {
    var eye_x = obj_player.x;
    var eye_y = obj_player.y;
    var eye_z = obj_player.z + 64;

    var arr = [];
    var cnt = instance_number(obj_billboard);
    for (var i = 0; i < cnt; i++) {
        var inst = instance_find(obj_billboard, i);
        if (!instance_exists(inst)) continue;
        var dx = inst.x - eye_x;
        var dy = inst.y - eye_y;
        var dz = (inst.z) - eye_z;
        var d2 = dx*dx + dy*dy + dz*dz;
        array_push(arr, [d2, inst]);
    }

    array_sort(arr, function(a,b){ return b[0] - a[0]; });

    for (var j = 0; j < array_length(arr); j++) {
        var inst = arr[j][1];

        var frames = sprite_get_number(inst.sprite_index);
        var idx = inst.image_index;

        if (frames >= 8) {
            var a_to_player = point_direction(inst.x, inst.y, eye_x, eye_y);
            var frame = floor(((a_to_player + 22.5) mod 360) / 45);
            idx = frame;
        }

        draw_sprite_billboard(inst.sprite_index, idx, inst.x, inst.y, inst.z);
    }
}
