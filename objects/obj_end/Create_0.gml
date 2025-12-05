var c  = global.WORLD_CELL;
var Hh = global.WALL_HEIGHT;

// We'll reuse the same vertex format as walls
if (!variable_global_exists("VFMT_WALL")) {
    vertex_format_begin();
    vertex_format_add_position_3d();
    vertex_format_add_normal();
    vertex_format_add_texcoord();
    vertex_format_add_color();
    global.VFMT_WALL = vertex_format_end();
}

// Local vertex buffer + texture for this door
goal_vb  = vertex_create_buffer();
goal_tex = sprite_get_texture(Door_Tile, 0);

// Cell origin (bottom-left in world space)
var wx = x - c * 0.5;
var wy = y - c * 0.5;
var z0 = 0;
var z1 = Hh;
var col = c_white;

// Build a quad facing toward -y (same as other walls’ “front” face)
vertex_begin(goal_vb, global.VFMT_WALL);

// bottom-left
vertex_add_point(goal_vb, wx,     wy, z0,  0,0,1,  0,1, col, 1);
// bottom-right
vertex_add_point(goal_vb, wx + c, wy, z0,  0,0,1,  1,1, col, 1);
// top-right
vertex_add_point(goal_vb, wx + c, wy, z1,  0,0,1,  1,0, col, 1);

// top-right
vertex_add_point(goal_vb, wx + c, wy, z1,  0,0,1,  1,0, col, 1);
// top-left
vertex_add_point(goal_vb, wx,     wy, z1,  0,0,1,  0,0, col, 1);
// bottom-left
vertex_add_point(goal_vb, wx,     wy, z0,  0,0,1,  0,1, col, 1);

vertex_end(goal_vb);
