// billboard init (safe)
if (!variable_instance_exists(self, "z")) z = 0;
z += depth;   // lift by whatever the instance was given
depth = 0;

move_left = true;
alarm_running = false;
