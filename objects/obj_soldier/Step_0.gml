if (iframes > 0) {
    iframes -= 1;
    image_blend = c_red; 
} else {
    image_blend = c_white;
}

if (hp <= 0) {
    global.north_state = "lose"; 
    instance_destroy();         
}

var _right = keyboard_check(vk_right);
var _left = keyboard_check(vk_left);
var _up = keyboard_check(vk_up);
var _down = keyboard_check(vk_down);

var _hspd = (_right - _left) * move_speed;
var _vspd = (_down - _up) * move_speed;

x += _hspd;
y += _vspd;

if (_hspd != 0 || _vspd != 0) {
    footstep_timer -= 1;
    
    if (footstep_timer <= 0) {
        
        var _step = audio_play_sound(snd_footstep_soldier, 1, false);
        
        audio_sound_pitch(_step, random_range(0.8, 1.2)); 

        footstep_timer = footstep_delay; 
    }
} else {
    
    footstep_timer = 0; 
}


if (_hspd > 0) {
    sprite_index = spr_soldier_right; 
    facing = "right";
    image_speed = 0.25; 
} else if (_hspd < 0) {
    sprite_index = spr_soldier_left;  
    facing = "left";
    image_speed = 0.25; 
} else if (_vspd > 0) {
    sprite_index = spr_soldier_down;  
    facing = "down";
    image_speed = 0.25; 
} else if (_vspd < 0) {
    sprite_index = spr_soldier_up;    
    facing = "up";
    image_speed = 0.25; 
} else {
    image_speed = 0; 
    image_index = 0; 
}

if (keyboard_check_pressed(ord("S"))) { 
    
   
    var _sword = instance_create_layer(x, y, "Instances", obj_sword);
    
    
    if (facing == "right") { 
        _sword.x += 32; 
        _sword.image_angle = 0; 
    }
    if (facing == "left") { 
        _sword.x -= 32; 
        _sword.image_angle = 180; 
    }
    if (facing == "down") { 
        _sword.y += 32; 
        _sword.image_angle = 270; 
    }
    if (facing == "up") { 
        _sword.y -= 32; 
        _sword.image_angle = 90; 
    }
}

x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16);