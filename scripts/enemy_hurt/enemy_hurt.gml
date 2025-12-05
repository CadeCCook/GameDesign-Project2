function enemy_hurt(_enemy, _damage)
{
    if (!instance_exists(_enemy)) return;

    with (_enemy)
    {
        if (is_dead) exit;

        hp -= _damage;
        hit_flash = 8;

        if (scream_handle != -1) {
            audio_stop_sound(scream_handle);
        }

        // Start a new scream
        scream_handle = audio_play_sound(_333832__nick121087__demonic_woman_scream, 1, false);

        alarm[0] = round(room_speed * 0.7);

        if (hp <= 0)
        {
            is_dead    = true;
            to_destroy = true;
        }
    }
}