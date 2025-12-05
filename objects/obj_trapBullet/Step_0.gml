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

    if (dist < 16 && abs(z - obj_player.z) < 32) {
        with (obj_player) {
            hp = max(0, hp - other.damage);
        }
        instance_destroy();
        exit;
    }
}

// Safety lifetime
life -= 1;
if (life <= 0) instance_destroy();