/// @description Insert description here
// Camera object creates a simple ground and sets up to draw

// Create a vertex buffer and format to draw a ground plane
vformat = vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_texcoord();
vertex_format_add_color();
vformat = vertex_format_end();

vbuffer = vertex_create_buffer();

var k = 50;
var grid_size = 128;
vertex_begin(vbuffer, vformat);
for (var i = -k; i < k; i++) {
    var x1 = i * grid_size;
    var x2 = (i + 1) * grid_size;
    for (var j = -k; j < k; j++) {
        var y1 = j * grid_size;
        var y2 = (j + 1) * grid_size;

        // Triangle 1
        vertex_position_3d(vbuffer, x1, y1, 0);
        vertex_texcoord(vbuffer, 0, 0);
        vertex_color(vbuffer, c_white, 1);

        vertex_position_3d(vbuffer, x2, y1, 0);
        vertex_texcoord(vbuffer, 16, 0);
        vertex_color(vbuffer, c_white, 1);

        vertex_position_3d(vbuffer, x2, y2, 0);
        vertex_texcoord(vbuffer, 16, 16);
        vertex_color(vbuffer, c_white, 1);

        // Triangle 2
        vertex_position_3d(vbuffer, x1, y1, 0);
        vertex_texcoord(vbuffer, 0, 0);
        vertex_color(vbuffer, c_white, 1);

        vertex_position_3d(vbuffer, x2, y2, 0);
        vertex_texcoord(vbuffer, 16, 16);
        vertex_color(vbuffer, c_white, 1);

        vertex_position_3d(vbuffer, x1, y2, 0);
        vertex_texcoord(vbuffer, 0, 16);
        vertex_color(vbuffer, c_white, 1);
    }
}
vertex_end(vbuffer);

// Create a player to draw
instance_create_depth(x, y, 0, obj_player);


