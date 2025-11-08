/// @func melee_hit_cone(x0, y0, dir_deg, range, half_angle_deg, dmg, knockback)
/// @desc Sweeps a cone in front of (x0,y0). Returns number of enemies hit.
///       Uses raycast_world(...) which returns a struct: {hit, dist, hx, hy, ...}
function melee_hit_cone(x0, y0, dir_deg, range, half_angle_deg, dmg, knockback)
{
    // Capture params into locals to use safely inside `with` blocks
    var _x0 = x0;
    var _y0 = y0;
    var _dir = dir_deg;
    var _range = range;
    var _half = half_angle_deg;
    var _dmg = dmg;
    var _kb  = knockback;

    var hits = 0;

    // iterate enemies (billboarded)
    with (obj_billboard)
    {
        if (is_dead) continue;

        // distance check
        var dist_to = point_distance(_x0, _y0, x, y);
        if (dist_to > _range) continue;

        // cone check by angle
        var dir_to = point_direction(_x0, _y0, x, y);
        if (abs(angle_difference(_dir, dir_to)) > _half) continue;

        // line-of-sight: cast up to just shy of the target distance
        var max_cast = max(dist_to - 2, 0); // epsilon so target itself isn't counted as a wall
        var r = raycast_world(_x0, _y0, dir_to, max_cast);

        // If a wall is before the target, skip
        if (r.hit && r.dist < max_cast) continue;

        // apply damage (prefer your enemy_hurt if present)
        if (is_undefined(enemy_hurt)) {
            if (!variable_instance_exists(id, "hp")) hp = 10;
            hp -= _dmg;
            hit_flash = 8;
            if (hp <= 0) { is_dead = true; to_destroy = true; }
        } else {
            enemy_hurt(id, _dmg);
        }

        // knockback away from the player
        if (_kb > 0) {
            var away = point_direction(_x0, _y0, x, y);
            var kx = lengthdir_x(_kb, away);
            var ky = lengthdir_y(_kb, away);
            if (variable_instance_exists(id, "vx")) vx += kx; else x += kx * 0.25;
            if (variable_instance_exists(id, "vy")) vy += ky; else y += ky * 0.25;
        }

        hits += 1;
    }

    return hits;
}


