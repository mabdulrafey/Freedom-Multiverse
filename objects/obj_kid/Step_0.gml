
var key_left = keyboard_check(vk_left);
var key_right = keyboard_check(vk_right);
var key_jump = keyboard_check_pressed(vk_up);
var key_cast = keyboard_check_pressed(ord("S"));

var move = key_right - key_left;
hsp = move * walksp;
vsp = vsp + grv;

if (place_meeting(x, y+1, obj_wall)) && (key_jump) {
    vsp = jumpsp;
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

if (!is_casting) {
    if (!place_meeting(x, y+1, obj_wall)) {
        sprite_index = spr_kid_jump;
    } else {
        if (hsp == 0) {
            sprite_index = spr_kid_idle;
        } else {
            sprite_index = spr_kid_right; 
        }
    }
}
if (hsp > 0) face = 1;
if (hsp < 0) face = -1;

image_xscale = face;

if (key_cast && !is_casting) {
    is_casting = true;
    sprite_index = spr_kid_cast;
    image_index = 0;
    var inst = instance_create_layer(x + (80 * face), y - 80, "Instances", obj_spell);
    inst.hspeed = 15 * face;
}