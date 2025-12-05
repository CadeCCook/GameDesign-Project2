function world_traps_fire_all()
{
    // Fire a bullet from every wall trap shooter
    with (obj_wallTrapShooter) {
        var spd = 20;

        var bx = x + lengthdir_x( fire_offset, fire_dir);
        var by = y + lengthdir_y( fire_offset, fire_dir);

        var b = instance_create_layer(bx, by, "Instances", obj_trapBullet);
        b.direction = fire_dir;
        b.speed     = spd;

        // Start slightly above and out from the wall
        b.z  = 96;
        b.vz = -4;
    }
}