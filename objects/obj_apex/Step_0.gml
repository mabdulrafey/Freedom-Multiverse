if (global.fictionland_state != "playing" && global.fictionland_state != "tutorial" && global.fictionland_state != "gameover") exit;

if (hp <= 0) {
    if (global.fictionland_state == "playing") {
        global.fictionland_state = "gameover";
    }
    if (state != "hurt") {
        state = "hurt";
        image_index = 0;
    }
}


if (state == "hurt" && hp <= 0) {
    if (image_index >= image_number - 1) {
        image_speed = 0;
        image_index = image_number - 1;
    }
} else {
    image_speed = 1;
}

if (state != "hurt" && state != "attack_kick" && state != "attack_punch" && state != "block" && hp > 0) {
    var move = keyboard_check(vk_right) - keyboard_check(vk_left);
    hsp = move * 7;
    if (move != 0) facing = move;
    
    
    if (keyboard_check_pressed(vk_space) && y >= ground_y) {
        vsp = -16;
        y -= 1; 
        state = "jump";
    } else if (keyboard_check_pressed(ord("A"))) {
        state = "attack_kick";
        image_index = 0;
        attacked = false;
    } else if (keyboard_check_pressed(ord("S"))) {
        state = "attack_punch";
        image_index = 0;
        attacked = false;
    } else if (keyboard_check(ord("D"))) {
        state = "block";
    } else if (y >= ground_y) {
        if (hsp != 0) state = (sign(hsp) == facing) ? "forward" : "backward";
        else state = "idle";
    }
}

if (state == "hurt" || state == "block" || state == "attack_kick" || state == "attack_punch") hsp = 0;

if (!keyboard_check(ord("D")) && state == "block") state = "idle";

vsp += grv;
y += vsp; 


if (y >= ground_y && vsp >= 0) {
    y = ground_y;
    vsp = 0;
    if (state == "jump") state = "idle";
}

if (state == "attack_kick" || state == "attack_punch") {
    if (floor(image_index) == 1 && !attacked) {
        attacked = true;
        var hit = collision_rectangle(x, y-350, x+(220*facing), y, obj_void, false, true);
        if (hit != noone && hit.state != "block" && hit.hp > 0 && hit.invincible <= 0) {
            hit.hp -= 10;
            hit.state = "hurt";
            hit.image_index = 0;
            hit.invincible = 60; 
        }
    }
}

if (place_meeting(x + hsp, y, obj_void)) {
    
    
    if (bbox_bottom > obj_void.bbox_top + 20) { 

        while (!place_meeting(x + sign(hsp), y, obj_void)) {
            x += sign(hsp);
        }
        hsp = 0; 
    }
}


x += hsp;
x = clamp(x, 100, 1820);


if (global.fictionland_state == "gameover" && hp > 0) {
    hsp = 0; 
    if (state == "attack_kick" || state == "attack_punch") {
        if (image_index >= image_number - 1) {
            state = "idle";
        }
    } else {
        state = "idle";
    }
}

switch(state) {
    case "idle": sprite_index = spr_apex_idle; break;
    case "forward": sprite_index = spr_apex_forward; break;
    case "backward": sprite_index = spr_apex_backward; break;
    case "jump": sprite_index = spr_apex_jump; break;
    case "attack_kick": sprite_index = spr_apex_kick; break;
    case "attack_punch": sprite_index = spr_apex_punch; break; 
    case "hurt": sprite_index = spr_apex_hurt; break;
    case "block": sprite_index = spr_apex_block; break;
}

