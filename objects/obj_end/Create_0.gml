z = depth;
depth = 0;






// tile building
if (!variable_global_exists("VFMT_FLOOR")) {
    vertex_format_begin();
    vertex_format_add_position_3d(); // required
    vertex_format_add_normal();      // optional
    vertex_format_add_texcoord();    // optional
    vertex_format_add_color();       // optional
    global.VFMT_FLOOR = vertex_format_end();
}


goal_vb  = vertex_create_buffer();
goal_tex = sprite_get_texture(spr_end, 0);


var tileSize = global.WORLD_CELL;
var half     = tileSize * 0.5;

// Bottom-left corner of the tile this object is centered in
var i = x - half;
var j = y - half;

var color = c_white;

vertex_begin(goal_vb, global.VFMT_FLOOR);

// triangle 1
vertex_add_point(goal_vb, i,           j,           0,   0,0,1,  0,0,  color, 1);
vertex_add_point(goal_vb, i+tileSize,  j,           0,   0,0,1,  1,0,  color, 1);
vertex_add_point(goal_vb, i+tileSize,  j+tileSize,  0,   0,0,1,  1,1,  color, 1);
													
// triangle 2										
vertex_add_point(goal_vb, i+tileSize,  j+tileSize,  0,   0,0,1,  1,1,  color, 1);
vertex_add_point(goal_vb, i,           j+tileSize,  0,   0,0,1,  0,1,  color, 1);
vertex_add_point(goal_vb, i,           j,           0,   0,0,1,  0,0,  color, 1);

vertex_end(goal_vb);
