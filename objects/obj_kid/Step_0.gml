
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

image_xscale = scale_size * face;

if (key_cast && !is_casting) {
    is_casting = true;
    sprite_index = spr_kid_cast;
    image_index = 0;
	var _spell_snd = audio_play_sound(snd_spell, 10, false);
    audio_sound_pitch(_spell_snd, random_range(0.9, 1.1));
    var inst = instance_create_layer(x + (80 * face), y - 80, "Instances", obj_spell);
    inst.hspeed = 15 * face;
}

if (invincible) {
    invincible_timer -= 1;
    
    
    if (invincible_timer % 10 < 5) {
        image_alpha = 0.3; 
    } else {
        image_alpha = 1;
    }
    
   
    if (invincible_timer <= 0) {
        invincible = false;
        image_alpha = 1; 
    }
}
if (hsp != 0 && place_meeting(x, y + 1, obj_wall)) {
    step_timer -= 1;
    
    if (step_timer <= 0) {
        var _step = audio_play_sound(snd_kid_step, 1, false);
        audio_sound_pitch(_step, random_range(0.8, 1.2)); 
        step_timer = 15; 
    }
} else {
    step_timer = 0; 
}
