
var px = obj_player.x;
var py = obj_player.y;
var dist_to_player = point_distance(x, y, px, py);


enemy_vision();
{
    if (can_see_player && dist_to_player <= attack_range && can_attack)
    {

        is_attacking = true;
        can_attack   = false;

        sprite_index = sprite_attack;
        image_speed  = 1;
        image_index  = 0;

        with (obj_player)
        {
            hp -= other.attack_damage;
        }

        alarm[0] = attack_cooldown;
    }
}

// reset sprite after attack animation
if (is_attacking)
{
    if (sprite_index == sprite_attack && image_index >= image_number - 1)
    {
        is_attacking = false;
        sprite_index = sprite_idle;
        image_speed = 1;
    }
}
  



if(can_see_player) {
	
	if (dist_to_player > attack_range && !is_attacking) {
	    var spd = 2;

	    // direction  to player
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




/*
if (move_left) {
	x -= 1;
}
else {
	x += 1;
}
if (!alarm_running) {
	alarm_set(0, 100);
	alarm_running = true;
}