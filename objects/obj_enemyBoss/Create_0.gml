z = depth;
depth = 0;

// movement
move_speed = 1;
move_left = true;
alarm_running = false;
collide_radius = 24;

// attack
attack_range = 64;
attack_damage = 40;
attack_cooldown = 60;

is_attacking = false;
can_attack = true;

sprite_idle = spr_boss;
sprite_attack = spr_bossAttack;

collide_radius = 12;

teleport_timer_min  = 180;
teleport_timer_max  = 360;
teleport_timer      = irandom_range(teleport_timer_min, teleport_timer_max);

teleport_back_dist  = 96;    // how far behind the player to appear
teleport_min_range  = 160;
teleport_max_range  = 640;
teleport_chance     = 50;    // % chance to actually teleport when timer hits

//health
hp = 100;
is_dead = false;
hit_flash = 0;
to_destroy = false;

//sound
growl_timer = irandom_range(90, 240);
scream_handle = -1;