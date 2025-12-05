x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);

// Gravity + vertical motion
vz += gravity_accel;
z  += vz;

// Hit the floor?
if (z <= floor_z) {
    instance_destroy();
    exit;
}

// Hit the player?
if (instance_exists(obj_player)) {
    var dx   = obj_player.x - x;
    var dy   = obj_player.y - y;
    var dist = sqrt(dx*dx + dy*dy);

    // More generous hit radius + vertical window
    if (dist < 40 && abs(z - obj_player.z) < 64) {
        with (obj_player) {
            hp = max(0, hp - other.damage);
        }

        // Optional: tiny feedback if you want
        // hit_flash = 8;

        instance_destroy();
        exit;
    }
}

// Safety lifetime
life -= 1;
if (life <= 0) instance_destroy();