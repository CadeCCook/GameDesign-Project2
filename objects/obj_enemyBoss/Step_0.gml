if (!instance_exists(obj_player)) {
    exit;
}

var px = obj_player.x;
var py = obj_player.y;
var dist_to_player = point_distance(x, y, px, py);

enemy_vision();


// Teleport Ability

teleport_timer -= 1;

if (teleport_timer <= 0) {

    // Only teleport if:
    //  - boss sees the player
    //  - not currently in an attack animation
    if (can_see_player && !is_attacking && dist_to_player > teleport_min_range) {

        // Random chance
        if (irandom(99) < teleport_chance) {

            var back_dist = teleport_back_dist;
            var pdir      = obj_player.look_dir;

            var dx = -lengthdir_x(back_dist, pdir);
            var dy = -lengthdir_y(back_dist, pdir);

            var _pos = world_collision_move(obj_player.x, obj_player.y, dx, dy, collide_radius);

            x = _pos[0];
            y = _pos[1];
			
			audio_play_sound(_512217__mateusz_chenc__poof_in_cloud, 1, false);

            teleport_timer = irandom_range(teleport_timer_min, teleport_timer_max);
        }

    }

}


// Melee Attack


if (can_see_player && dist_to_player <= attack_range && can_attack)
{
    is_attacking = true;
    can_attack   = false;

    sprite_index = sprite_attack;
    image_speed  = 1;
    image_index  = 0;

    // Damage + knockback to the player
    with (obj_player)
    {
        // deal damage
        hp -= other.attack_damage;

        // knockback amount
        var kb_dist = 100;

        // direction from enemy (other.x,other.y) to player (x,y in this with)
        var dir = point_direction(other.x, other.y, x, y);

        var kdx = lengthdir_x(kb_dist, dir);
        var kdy = lengthdir_y(kb_dist, dir);

        // move the player back using the same collision helper so we don't go through walls
        var _kb = world_collision_move(x, y, kdx, kdy, collide_radius);
        x = _kb[0];
        y = _kb[1];
    }

    alarm[0] = attack_cooldown;
}

// reset sprite after attack animation
if (is_attacking)
{
    if (sprite_index == sprite_attack && image_index >= image_number - 1)
    {
        is_attacking = false;
        sprite_index = sprite_idle;
        image_speed  = 1;
    }
}


// Chase logic


// Chase player if we see them and we're not in melee range
if (can_see_player)
{
    if (dist_to_player > attack_range && !is_attacking) {
        var spd = 2;

        // direction to player
        var dir_to_player = point_direction(x, y, obj_player.x, obj_player.y);

        // movement this step
        var dx = lengthdir_x(spd, dir_to_player);
        var dy = lengthdir_y(spd, dir_to_player);

        // collide with walls
        var _moved = world_collision_move(x, y, dx, dy, collide_radius);

        x = _moved[0];
        y = _moved[1];
    }
}

// Sound

if (!is_dead)
{
    growl_timer--;

    if (growl_timer <= 0)
    {
        //Only growl if the player is close or visible
        if (dist_to_player < 384 || can_see_player)
        {
            audio_play_sound(ambience_1, 0, false);
        }

        //timer for next growl
        growl_timer = irandom_range(180, 420);
    }
}