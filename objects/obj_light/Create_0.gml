light_color = [1.2, 0.9, 0.7, 1.0];
light_range = 500;
z = 120;


if (!variable_global_exists("light_list")) {
    global.light_list = ds_list_create();
}
ds_list_add(global.light_list, id);