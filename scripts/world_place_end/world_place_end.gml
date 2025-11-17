function world_place_end(LEVEL)
{
	var tileSize = global.WORLD_CELL;
	var rows = array_length(LEVEL);
	var cols = array_length(LEVEL[0]);

	// Create end-tile vertex format if needed
	if (!variable_global_exists("VFMT_END")) {
		vertex_format_begin();
		vertex_format_add_position_3d();
		vertex_format_add_normal();
		vertex_format_add_texcoord();
		vertex_format_add_color();
		global.VFMT_END = vertex_format_end();
	}

	// Delete old end VB if present
	if (variable_global_exists("END_VB") && global.END_VB != -1) {
		vertex_delete_buffer(global.END_VB);
	}

	var end_vbuffer = vertex_create_buffer();
	vertex_begin(end_vbuffer, global.VFMT_END);

	var color = c_white;

	for (var ty = 0; ty < rows; ty++) {
		for (var tx = 0; tx < cols; tx++) {

			if (LEVEL[ty][tx] == 5) {

				// --- 1) End floor tile (same mapping as world_build_floor) ---
				var i = (tx) * tileSize;
				var j = (ty) * tileSize;
				var z = 0;

				// triangle 1
				vertex_add_point(end_vbuffer, i,           j,           z,  0,0,1,  0,0,  color, 1);
				vertex_add_point(end_vbuffer, i+tileSize,  j,           z,  0,0,1,  1,0,  color, 1);
				vertex_add_point(end_vbuffer, i+tileSize,  j+tileSize,  z,  0,0,1,  1,1,  color, 1);

				// triangle 2
				vertex_add_point(end_vbuffer, i+tileSize,  j+tileSize,  z,  0,0,1,  1,1,  color, 1);
				vertex_add_point(end_vbuffer, i,           j+tileSize,  z,  0,0,1,  0,1,  color, 1);
				vertex_add_point(end_vbuffer, i,           j,           z,  0,0,1,  0,0,  color, 1);

				// --- 2) Place the end object at the CENTER of that tile ---
				var xw = (tx + 0.5) * tileSize;
				var yw = (ty + 0.5) * tileSize;
				instance_create_depth(xw, yw, 0, obj_end);
			}
		}
	}

	vertex_end(end_vbuffer);
	global.END_VB  = end_vbuffer;
	global.END_TEX = sprite_get_texture(spr_end, 0);
}
