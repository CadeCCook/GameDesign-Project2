function world_build_floor(LEVEL){
	
	//Create floor vertex format if one doesn't already exist
	if (!variable_global_exists("VFMT_FLOOR")) {
		vertex_format_begin();
		vertex_format_add_position_3d(); //required
		vertex_format_add_normal(); //optional
		vertex_format_add_texcoord(); //optional
		vertex_format_add_color(); //optional
		global.VFMT_FLOOR = vertex_format_end();
	}

	
	//Check for redundant floor vector buffers
	if (variable_global_exists("FLOOR_VB") && global.FLOOR_VB != -1) {
        vertex_delete_buffer(global.FLOOR_VB);
    }

	//define a vertex buffer
    var floor_vbuffer = vertex_create_buffer();
    vertex_begin(floor_vbuffer, global.VFMT_FLOOR);
	
	


	var tileSize    = global.WORLD_CELL;
	var rows = array_length(LEVEL);       // 24
	var cols = array_length(LEVEL[0]);    // 32
	var color = c_white;

	for (var ty = 0; ty < rows; ty++) {        // ty = tile_y in LEVEL
	    for (var tx = 0; tx < cols; tx++) {    // tx = tile_x in LEVEL
        
			
			
	        // Skip traps/holes
			lx = min(ty+1, rows-1);
			ly = min(tx+1, rows-1);
	        if (LEVEL[lx][ly] == 2 || LEVEL[lx][ly] == 5) continue;

	        // Convert matrix indices -> world coordinates
	        var i = (tx + 1) * tileSize;  // +1 tile offset from origin
	        var j = (ty + 1) * tileSize;  // +1 tile offset from origin

	        // triangle 1
	        vertex_add_point(floor_vbuffer, i,			j,			0,   0,0,1,  0,0,  color, 1);
	        vertex_add_point(floor_vbuffer, i+tileSize,	j,			0,   0,0,1,  1,0,  color, 1);
	        vertex_add_point(floor_vbuffer, i+tileSize,	j+tileSize, 0,   0,0,1,  1,1,  color, 1);

	        // triangle 2
	        vertex_add_point(floor_vbuffer, i+tileSize,	j+tileSize, 0,   0,0,1,  1,1,  color, 1);
	        vertex_add_point(floor_vbuffer, i,			j+tileSize, 0,   0,0,1,  0,1,  color, 1);
	        vertex_add_point(floor_vbuffer, i,			j,			0,   0,0,1,  0,0,  color, 1);
			
			
	    }
	}

	vertex_end(floor_vbuffer); //basically "seals up" the vertex buffer for the computer to draw
	global.FLOOR_VB = floor_vbuffer
	
	global.FLOOR_TEX = sprite_get_texture(spr_grass, 0);
	
	
}