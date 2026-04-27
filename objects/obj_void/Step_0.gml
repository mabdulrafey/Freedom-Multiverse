if (global.fictionland_state != "playing" && global.fictionland_state != "gameover") exit;

if (invincible > 0) {
    invincible--;
    image_alpha = (invincible % 8 < 4) ? 0.3 : 1.0; 
} else {
    image_alpha = 1.0;
}

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
    image_speed = 0.5;
}

var dist = obj_apex.x - x;
var abs_dist = abs(dist);

if (state == "idle" || state == "forward" || state == "backward" || state == "jump") {
    if (dist != 0) facing = sign(dist);
}

var apex_attacking = (obj_apex.state == "punch" || obj_apex.state == "kick" || obj_apex.state == "attack");

if (state != "hurt" && hp > 0) {
    ai_timer--;
}

if (state != "hurt" && state != "punch" && state != "kick" && state != "block" && state != "jump" && hp > 0) {
    
    if (apex_attacking && abs_dist < 220) {
        if (abs_dist < 150) {
            state = "block";
            hsp = 0;
            ai_timer = 20;
        } else {
            state = "backward";
            hsp = -facing * 6;
            ai_timer = 15;
        }
    } 
    else if (ai_timer <= 0) {
        if (abs_dist > 250) {
            if (irandom(100) < 10) {
                state = "jump";
                vsp = -14;
                hsp = facing * 6;
				audio_play_sound(snd_void_jump, 1, false);
            } else {
                state = "forward";
                hsp = facing * 5;
                ai_timer = irandom_range(20, 40);
            }
        } 
        else if (abs_dist > 120) {
            var roll = irandom(100);
            if (roll < 35) {
                state = "forward";
                hsp = facing * 4;
                ai_timer = irandom_range(15, 25);
            } else if (roll < 65) {
                state = "backward";
                hsp = -facing * 5;
                ai_timer = irandom_range(15, 30);
			} else if (roll < 80) {
                state = "punch";
                image_index = 0;
                attacked = false;
                ai_timer = 30;
				audio_play_sound(snd_void_punch, 1, false);
            } else if (roll < 85) {
                state = "kick";
                image_index = 0;
                attacked = false;
                ai_timer = 30;	
				audio_play_sound(snd_void_kick, 1, false);
            } else {
                state = "idle";
                hsp = 0;
                ai_timer = irandom_range(10, 20);
            }
        } 
        else {
            var roll = irandom(100);
            if (roll < 45) {
                state = "punch";
                image_index = 0;
                attacked = false;
                ai_timer = 30;
            } else if (roll < 80) {
                state = "backward";
                hsp = -facing * 6;
                ai_timer = irandom_range(30, 55);
            } else {
                state = "block";
                hsp = 0;
                ai_timer = irandom_range(10, 20);
            }
        }
    }
}

if (state == "block") {
    hsp = 0;
    if (!apex_attacking && ai_timer <= 0) {
        state = "idle";
    }
}

if (state == "hurt" || state == "punch" || state == "kick") {
    hsp = 0;
}

switch(state) {
    case "idle": sprite_index = spr_void_idle; break;
    case "forward": sprite_index = spr_void_forward; break;
    case "backward": sprite_index = spr_void_backward; break;
    case "jump": sprite_index = spr_void_jump; break;
    case "punch": sprite_index = spr_void_punch; break;
    case "kick": sprite_index = spr_void_kick; break; 
    case "hurt": sprite_index = spr_void_hurt; break;
    case "block": sprite_index = spr_void_block; break;
}

vsp += grv;
y += vsp;

if (y >= ground_y && vsp >= 0) {
    y = ground_y;
    vsp = 0;
    if (state == "jump") {
        state = "idle";
        hsp = 0;
        ai_timer = 10;
    }
}

if (state == "punch" || state == "kick") {
    if (floor(image_index) == 1 && !attacked) {
        attacked = true;
        var reach = (state == "kick") ? 200 : 130;
        var hit = collision_rectangle(x, y-350, x+(reach*facing), y, obj_apex, false, true);
        if (hit != noone && hit.state != "block" && hit.hp > 0) {
            hit.hp -= 10;
            hit.state = "hurt";
            hit.image_index = 0;
			audio_play_sound(snd_apex_hurt, 1, false);
        }
    }
    
    if (image_index >= image_number - 1) {
        state = "idle";
        attacked = false; 
    }
}

if (state == "hurt" && hp > 0) {
    if (image_index >= image_number - 1) {
        state = "idle";
    }
}

if (place_meeting(x + hsp, y, obj_apex)) {
    if (bbox_bottom > obj_apex.bbox_top + 20 && obj_apex.bbox_bottom > bbox_top + 20) { 
        while (!place_meeting(x + sign(hsp), y, obj_apex)) {
            x += sign(hsp);
        }
        hsp = 0; 
    }
}

if (place_meeting(x, y, obj_apex)) {
    var _push_dir = sign(x - obj_apex.x);
    if (_push_dir == 0) _push_dir = 1;
    x += _push_dir * 3; 
}

x += hsp;
x = clamp(x, 100, 1820);

if (global.fictionland_state == "gameover" && hp > 0) {
    if (state != "punch" && state != "kick") {
        state = "idle";
        hsp = 0;
    }
}