z = depth;
depth = 0;

// movement
move_speed = 1;
move_left = true;
alarm_running = false;
collide_radius = 24;

// attack
attack_range = 64;
attack_damage = 10;
attack_cooldown = 60;

is_attacking = false;
can_attack = true;

sprite_idle = Enemy_Walk;
sprite_attack = spr_enemy_attack;

collide_radius = 12;


//health
hp = 30;
is_dead = false;
hit_flash = 0;
to_destroy = false;

//sound
growl_timer = irandom_range(90, 240);
scream_handle = -1;
