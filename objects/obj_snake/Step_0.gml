if (global.magicland_tutorial) exit;
vsp += grv;
hsp = dir * 2;

if (place_meeting(x+hsp, y, obj_wall)) {
    dir *= -1;
}

var bbox_side = (dir == 1) ? bbox_right : bbox_left;
if (!position_meeting(bbox_side + (10 * dir), bbox_bottom + 10, obj_wall)) {
    dir *= -1;
}

if (place_meeting(x+hsp, y, obj_wall)) {
    while (!place_meeting(x+sign(hsp), y, obj_wall)) { x += sign(hsp); }
    hsp = 0;
}
x += hsp;

if (place_meeting(x, y+vsp, obj_wall)) {
    while (!place_meeting(x, y+sign(vsp), obj_wall)) { y += sign(vsp); }
    vsp = 0;
}
y += vsp;

image_xscale = dir;