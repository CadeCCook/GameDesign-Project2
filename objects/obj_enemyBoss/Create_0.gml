z = depth;
depth = 0;

// movement
move_speed = 1;
move_left = true;
alarm_running = false;
collide_radius = 24;

// attack
attack_range = 64;
attack_damage = 20;
attack_cooldown = 60;

is_attacking = false;
can_attack = true;

sprite_idle = spr_boss;
sprite_attack = spr_bossAttack;

collide_radius = 12;


//health
hp = 100;
is_dead = false;
hit_flash = 0;
to_destroy = false;

