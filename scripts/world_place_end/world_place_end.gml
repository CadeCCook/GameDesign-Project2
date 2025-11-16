function world_place_end(LEVEL)
{
	var tileSize = global.WORLD_CELL;
	var rows = array_length(LEVEL);
	var cols = array_length(LEVEL[0]);
	
	for (var ty = 0; ty < rows; ty++) {
		for (var tx = 0; tx < cols; tx++) {
			
			// 5 = end marker
			if (LEVEL[ty][tx] == 5) {
				
				var xw = (tx + 0.5) * tileSize;
				var yw = (ty + 0.5) * tileSize;

                instance_create_depth(xw, yw, 0, obj_end);
			}
		}
	}			
}