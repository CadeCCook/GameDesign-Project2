/// @func melee_hit_cone(x0, y0, dir_deg, range, half_angle_deg, dmg, knockback)
/// @desc Find all obj_billboard enemies within a forward cone and apply damage.
///       Returns number of enemies hit.
///       Uses raycast_world (if present) to ensure no wall blocks the swing.
function melee_hit_cone(x0, y0, dir_deg, range, half_angle_deg, dmg, knockback)
{
    var ux =  dcos(dir_deg);        // forward (x)
    var uy = -dsin(dir_deg);        // forward (y)  (minus to match your forward maths)
    var cosMax = dcos(half_angle_deg);

    var hit_count = 0;
    var n = instance_number(obj_billboard);

    for (var i = 0; i < n; i++) {
        var e = instance_find(obj_billboard, i);
        if (!instance_exists(e) || e.is_dead) continue;

        // vector to enemy (2D)
        var vx = e.x - x0;
        var vy = e.y - y0;
        var dist = point_distance(x0, y0, e.x, e.y);
        if (dist > range || dist <= 0.001) continue;

        // angle check via dot product (unit-less)
        var dot = (vx * ux + vy * uy) / dist;   // == cos(angle between)
        if (dot < cosMax) continue;             // outside cone

        // optional: wall block check (only if you added raycast_world earlier)
        var blocked = false;
        var r = raycast_world(x0, y0, dir_deg, dist);
		if (r[0]) blocked = true;
		if (blocked) continue;

        // apply damage
        enemy_hurt(e, dmg);
        hit_count += 1;

        // simple knockback away from player
        if (knockback > 0) {
            var kx = (vx / dist) * knockback;
            var ky = (vy / dist) * knockback;
            e.x += kx;
            e.y += ky;
        }
    }

    return hit_count;
}
