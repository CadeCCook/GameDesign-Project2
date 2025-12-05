// Remove from global light list when destroyed
if (variable_global_exists("light_list")) {
    var pos = ds_list_find_index(global.light_list, id);
    if (pos != -1) {
        ds_list_delete(global.light_list, pos);
    }
}