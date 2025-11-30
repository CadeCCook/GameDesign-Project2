function world_spawn_random_hearts(min_count, max_count)
{
    if (!object_exists(obj_heart)) return;

    var c = global.WORLD_CELL;
    var W = global.WORLD_W;
    var H = global.WORLD_H;

    var target   = irandom_range(min_count, max_count);
    var spawned  = 0;
    var attempts = 0;

    while (spawned < target && attempts < 3000)
    {
        attempts++;

        var gx = irandom(W - 1);
        var gy = irandom(H - 1);

        // avoid outer border if you want
        if (gx <= 0 || gx >= W - 1 || gy <= 0 || gy >= H - 1) continue;

        // skip solid tiles (walls, pits, traps, etc.)
        if (world_cell_solid(gx, gy)) continue;

        var hx = (gx + 0.5) * c;
        var hy = (gy + 0.5) * c;

        instance_create_depth(hx, hy, 0, obj_heart);
        spawned++;
    }

    // Debug: uncomment to verify something spawned
    // show_debug_message("Random hearts spawned: " + string(spawned));
}