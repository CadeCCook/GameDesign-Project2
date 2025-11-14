
//Turn on z-buffering/depth-buffering (Should always be on)
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

view_mat = undefined;
proj_mat = undefined;

//create a vertex format (basis for everything drawn in 3D)
vertex_format_begin();
vertex_format_add_position_3d(); //required
vertex_format_add_normal(); //optional
vertex_format_add_texcoord(); //optional
vertex_format_add_color(); //optional
vertex_format = vertex_format_end();

//define a vertex buffer
vbuffer = vertex_create_buffer();
vertex_begin(vbuffer, vertex_format);


/*
//create square coordinates
var x1 = 400;
var y1 = 400;
var x2 = 600;
var y2 = 600;
*/

/*
vertex_position_3d(vbuffer, x1, y1, 100); //add 3D data to vertex being defined
vertex_normal(vbuffer, 0, 0, 1); //add normal data to vertex being defined (normal data is referring to the unit vector which is perpendicular to the surface at a vertex)
vertex_texcoord(vbuffer, 0, 0); //texture coordinates
vertex_color(vbuffer, c_white, 1); //set color/transparency


//^could fit all of this vertex point stuff into an easily callable script^

//triangle 1
vertex_add_point(vbuffer, x1, y1, 100,	0, 0, 1,	0, 0,	c_white, 1);
vertex_add_point(vbuffer, x2, y1, 100,	0, 0, 1,	0, 0,	c_white, 1);
vertex_add_point(vbuffer, x2, y2, 100,	0, 0, 1,	0, 0,	c_white, 1);

//triangle 2
vertex_add_point(vbuffer, x2, y2, 100,	0, 0, 1,	0, 0,	c_aqua, 1);
vertex_add_point(vbuffer, x1, y2, 100,	0, 0, 1,	0, 0,	c_blue, 1);
vertex_add_point(vbuffer, x1, y1, 100,	0, 0, 1,	0, 0,	c_blue, 1);
*/

var LEVEL = [
        // Row  0 (top border)
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
        // Rows 1..22 – interior (edit freely)
  [1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],
  [1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],
  [1,0,0,0,0,2,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
  [1,0,0,0,2,2,0,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
  [1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],
  [1,1,1,1,1,1,1,1,1,0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],
  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
  [1,0,0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
  [1,1,1,1,1,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
  [1,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,0,0,1],
  [1,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1],
  [1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,0,0,0,1],
  [1,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,1],
  [1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1],
  [1,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,0,1,0,0,0,0,0,0,1,0,0,0,1],
  [1,1,1,1,1,1,1,1,1,0,0,0,0,1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,1],
  [1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,1,0,0,0,1],
  [1,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,1],
  [1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1],
  [1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
  [1,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1],
        // Row 23 (bottom border)
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
    ];
	

var s = 128;                 // tile size
var extent = 8192;           // half-size of the floor in world
var color = c_white;
var length = 4096;
var height = 3072;
for (var i = 0; i < length; i += s) {     //changed so floor is generated for whole map and doesnt have to be set
    for (var j = 0; j < height; j += s) {
		
		//xx = (i/128)-1;
		//yy = (j/128) -1;
		//if(i == 0 || j == 0){
		//	xx = 0;
			yy = 0;
		//}
        //if (LEVEL[xx][yy] != 2){
		
	        // triangle 1
	        vertex_add_point(vbuffer, i,   j,   0,   0,0,1,  0,0,  color, 1);
	        vertex_add_point(vbuffer, i+s, j,   0,   0,0,1,  1,0,  color, 1);
	        vertex_add_point(vbuffer, i+s, j+s, 0,   0,0,1,  1,1,  color, 1);

	        // triangle 2
	        vertex_add_point(vbuffer, i+s, j+s, 0,   0,0,1,  1,1,  color, 1);
	        vertex_add_point(vbuffer, i,   j+s, 0,   0,0,1,  0,1,  color, 1);
	        vertex_add_point(vbuffer, i,   j,   0,   0,0,1,  0,0,  color, 1);
		
		//}
    }
}
vertex_end(vbuffer); //basically "seals up" the vertex buffer for the computer to draw

ground_tex = sprite_get_texture(spr_grass, 0);

instance_create_depth(x, y, 0, obj_player);

instance_create_depth(x, y, 0,obj_hud);