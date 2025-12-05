var new_track = noone;

switch (room) {
	case rm_startScreen:
		new_track = cave_themeb4;
		break;
	case rm_mainlvl:
		new_track = forest;
		break;
	case rm_tutoriallvl:
		new_track = forest;
		break;
}

if (new_track != current_track) {
	audio_stop_all();
	audio_play_sound(new_track, 1, true);
	current_track = new_track;
}