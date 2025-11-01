/// @param spr
/// @param subimg
/// @param px
/// @param py
/// @param pz
function draw_sprite_billboard(_spr, _sub, px, py, pz) {
    var tex = sprite_get_texture(_spr, _sub);
    var w = sprite_get_width(_spr);
    var h = sprite_get_height(_spr);

    var yaw = obj_player.look_dir;
    var rx =  dsin(yaw);
    var ry =  dcos(yaw);

    var hw = w * 0.5;
    var hh = h;

    var x1 = px - rx*hw;
    var y1 = py - ry*hw;
    var z1 = pz;

    var x2 = px + rx*hw;
    var y2 = py + ry*hw;
    var z2 = pz;

    var x3 = px + rx*hw;
    var y3 = py + ry*hw;
    var z3 = pz + hh;

    var x4 = px - rx*hw;
    var y4 = py - ry*hw;
    var z4 = pz + hh;

    if (!variable_global_exists("VFMT_BB")) {
        var fmt = vertex_format_begin();
        vertex_format_add_position_3d();
        vertex_format_add_texcoord();
        vertex_format_add_color();
        global.VFMT_BB = vertex_format_end();
    }
    var vb = vertex_create_buffer();
    vertex_begin(vb, global.VFMT_BB);

    vertex_position_3d(vb, x1,y1,z1); vertex_texcoord(vb, 0,1); vertex_color(vb, c_white, 1);
    vertex_position_3d(vb, x2,y2,z2); vertex_texcoord(vb, 1,1); vertex_color(vb, c_white, 1);
    vertex_position_3d(vb, x3,y3,z3); vertex_texcoord(vb, 1,0); vertex_color(vb, c_white, 1);

    vertex_position_3d(vb, x1,y1,z1); vertex_texcoord(vb, 0,1); vertex_color(vb, c_white, 1);
    vertex_position_3d(vb, x3,y3,z3); vertex_texcoord(vb, 1,0); vertex_color(vb, c_white, 1);
    vertex_position_3d(vb, x4,y4,z4); vertex_texcoord(vb, 0,0); vertex_color(vb, c_white, 1);

    vertex_end(vb);
    gpu_set_cullmode(cull_noculling);
    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);
    vertex_submit(vb, pr_trianglelist, tex);
    vertex_delete_buffer(vb);
}
