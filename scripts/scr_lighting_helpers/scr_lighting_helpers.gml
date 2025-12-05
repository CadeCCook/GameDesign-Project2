/// @function lighting_get_closest_lights(player_x, player_y, player_z, max_lights)
/// @description Returns an array of the closest lights to a position
/// @param {real} player_x
/// @param {real} player_y
/// @param {real} player_z
/// @param {real} max_lights Maximum number of lights to return
function lighting_get_closest_lights(player_x, player_y, player_z, max_lights) {
    var result_lights = array_create(max_lights);
    
    // Initialize with default empty lights
    for (var i = 0; i < max_lights; i++) {
        result_lights[i] = { 
            x: 0, 
            y: 0, 
            z: 0, 
            color: [0, 0, 0, 0], 
            range: 1
        };
    }
    
    // Check if light list exists
    if (!variable_global_exists("light_list")) {
        return result_lights;
    }
    
    var light_count = ds_list_size(global.light_list);
    if (light_count == 0) {
        return result_lights;
    }
    
    // Build array of lights with distances
    var light_distances = [];
    
    for (var i = 0; i < light_count; i++) {
        var light = global.light_list[| i];
        
        if (instance_exists(light)) {
            var dx = light.x - player_x;
            var dy = light.y - player_y;
            var dz = light.z - player_z;
            var dist = sqrt(dx*dx + dy*dy + dz*dz);
            
            array_push(light_distances, {
                light: light,
                distance: dist
            });
        }
    }
    
    // Sort by distance (closest first)
    array_sort(light_distances, function(a, b) {
        return a.distance - b.distance;
    });
    
    // Copy closest lights to result
    var lights_to_copy = min(array_length(light_distances), max_lights);
    
    for (var i = 0; i < lights_to_copy; i++) {
        var light = light_distances[i].light;
        
        result_lights[i] = {
            x: light.x,
            y: light.y,
            z: light.z,
            color: light.light_color,
            range: light.light_range
        };
    }
    
    return result_lights;
}

/// @function lighting_set_shader_uniforms(shader, lights, num_lights, ambient_color)
/// @description Sets all lighting uniforms for a shader
/// @param {asset} shader The shader asset to configure
/// @param {array} lights Array of light data structs
/// @param {real} num_lights Number of active lights
/// @param {array} ambient_color Ambient light color [r,g,b,a]
function lighting_set_shader_uniforms(shader, lights, num_lights, ambient_color) {
    var max_lights = array_length(lights);
    
    // Set each light's uniforms
    for (var i = 0; i < max_lights; i++) {
        var u_pos = shader_get_uniform(shader, "lightPosition" + string(i));
        var u_col = shader_get_uniform(shader, "lightColor" + string(i));
        var u_range = shader_get_uniform(shader, "lightRange" + string(i));
        
        shader_set_uniform_f(u_pos, lights[i].x, lights[i].y, lights[i].z);
        shader_set_uniform_f(u_col, 
            lights[i].color[0], 
            lights[i].color[1], 
            lights[i].color[2], 
            lights[i].color[3]
        );
        shader_set_uniform_f(u_range, lights[i].range);
    }
    
    // Set number of lights and ambient
    var u_num_lights = shader_get_uniform(shader, "numLights");
    var u_ambient = shader_get_uniform(shader, "lightAmbient");
    
    shader_set_uniform_i(u_num_lights, num_lights);
    shader_set_uniform_f(u_ambient, 
        ambient_color[0], 
        ambient_color[1], 
        ambient_color[2], 
        ambient_color[3]
    );
}