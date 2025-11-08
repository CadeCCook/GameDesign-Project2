/// @func raycast_world(x0, y0, dir_deg, max_dist)
/// @desc Casts a ray through WORLD_GRID; returns:
/// { hit, dist, hx, hy, cell_x, cell_y, nx, ny }
function raycast_world(x0, y0, dir_deg, max_dist)
{
    var cell = global.WORLD_CELL;

    // Unit direction (degrees; screen Y down)
    var dx = dcos(dir_deg);
    var dy = -dsin(dir_deg);

    // Start in grid space
    var gx = x0 / cell;
    var gy = y0 / cell;

    // Step direction per axis
    var stepX = (dx > 0) ? 1 : -1;
    var stepY = (dy > 0) ? 1 : -1;

    // Next grid boundaries (grid coords)
    var nextGridX = (dx > 0) ? (floor(gx) + 1) : (ceil(gx) - 1);
    var nextGridY = (dy > 0) ? (floor(gy) + 1) : (ceil(gy) - 1);

    // Use a big finite number; avoids scientific notation parsing issues
    var VERY_BIG = 1000000000.0; // 1e9 is plenty

    // Distances to first boundary along each axis (grid-space “t”)
    var tMaxX, tMaxY;
    if (dx == 0) {
        tMaxX = VERY_BIG;
    } else {
        tMaxX = (nextGridX - gx) / dx;
    }
    if (dy == 0) {
        tMaxY = VERY_BIG;
    } else {
        tMaxY = (nextGridY - gy) / dy;
    }

    // Step amounts to go from one boundary to the next
    var tDeltaX, tDeltaY;
    if (dx == 0) {
        tDeltaX = VERY_BIG;
    } else {
        tDeltaX = stepX / dx;
    }
    if (dy == 0) {
        tDeltaY = VERY_BIG;
    } else {
        tDeltaY = stepY / dy;
    }

    // Current grid cell
    var cx = floor(gx);
    var cy = floor(gy);

    var maxT = max_dist / cell; // convert world distance to grid “t”
    var t    = 0;

    // March until hit or out of range
    repeat (1024) // safety guard
    {
        var hit_axis; // 0 = crossed vertical boundary, 1 = horizontal

        if (tMaxX < tMaxY) {
            t = tMaxX;
            tMaxX += tDeltaX;
            cx += stepX;
            hit_axis = 0;
        } else {
            t = tMaxY;
            tMaxY += tDeltaY;
            cy += stepY;
            hit_axis = 1;
        }

        if (t > maxT) break;

        if (world_cell_solid(cx, cy)) {
            var wx = x0 + dx * (t * cell);
            var wy = y0 + dy * (t * cell);

            // Outward-ish normal from boundary crossed
            var nx = 0, ny = 0;
            if (hit_axis == 0) {
                nx = (stepX > 0) ? -1 : 1;
            } else {
                ny = (stepY > 0) ? -1 : 1;
            }

            return {
                hit    : true,
                dist   : point_distance(x0, y0, wx, wy),
                hx     : wx,
                hy     : wy,
                cell_x : cx,
                cell_y : cy,
                nx     : nx,
                ny     : ny
            };
        }
    }

    // No hit within range
    return {
        hit    : false,
        dist   : max_dist,
        hx     : x0 + dx * max_dist,
        hy     : y0 + dy * max_dist,
        cell_x : cx,
        cell_y : cy,
        nx     : 0,
        ny     : 0
    };
}
