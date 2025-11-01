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