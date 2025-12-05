function world_place_torch_light(LEVEL){
    var tileSize = global.WORLD_CELL;
    var rows = array_length(LEVEL);       // 24
    var cols = array_length(LEVEL[0]);    // 32
	
    for (var ty = 0; ty < rows; ty++) {
        for (var tx = 0; tx < cols; tx++) {
			
            // 4 = light source
            if (LEVEL[ty][tx] == 4) {
				
                var xw = (tx + 0.5) * tileSize;
                var yw = (ty + 0.5) * tileSize;
                instance_create_depth(xw, yw, 30, obj_light);
				
            }
        }
    }
}
