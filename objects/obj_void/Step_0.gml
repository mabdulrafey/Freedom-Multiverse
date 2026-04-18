if (global.fictionland_state != "playing") exit;

if (hp <= 0 && state != "hurt") {
    global.fictionland_state = "gameover";
    state = "hurt";
    image_index = 0;
}

if (state == "hurt" && hp <= 0) {
    if (image_index >= image_number - 1) {
        image_speed = 0;
        image_index = image_number - 1;
    }
} else {
    image_speed = 1;
}

var dist = obj_apex.x - x;
if (state != "hurt" && hp > 0) facing = sign(dist) == 0 ? -1 : sign(dist);

var apex_attacking = (obj_apex.state == "attack" || obj_apex.state == "punch" || obj_apex.state == "kick");

if (state != "hurt" && hp > 0) {
    ai_timer++;
}

if (state != "hurt" && state != "punch" && state != "kick" && state != "block" && hp > 0) {
    if (apex_attacking && abs(dist) < 160) {
        hsp = -facing * 5;
        state = "backward";
        ai_timer = 0;
    } else if (abs(dist) > 80 && !place_meeting(x + (facing * 5), y, obj_apex)) {
        hsp = facing * 5;
        state = "forward";
    } else {
        hsp = 0;
        if (ai_timer > 30) {
            var rand = irandom(10);
            if (rand < 6) {
                state = choose("punch", "kick");
                image_index = 0;
                attacked = false;
                ai_timer = 0; 
            } else if (rand < 8) {
                state = "block";
                ai_timer = -30;
            } else {
                ai_timer = 0;
            }
        } else {
            state = "idle";
        }
    }
}

if (state == "block" && ai_timer >= 0) {
    state = "idle";
}

if (state == "hurt" || state == "block" || state == "punch" || state == "kick") {
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
    if (state == "jump") state = "idle"; 
}

if (state == "punch" || state == "kick") {
    if (floor(image_index) == 1 && !attacked) {
        attacked = true;
        var hit = collision_rectangle(x, y-350, x+(150*facing), y, obj_apex, false, true);
        if (hit != noone && hit.state != "block" && hit.hp > 0) {
            hit.hp -= 10;
            hit.state = "hurt";
            hit.image_index = 0;
        }
    }
    
    if (image_index >= image_number - 1) {
        state = "idle";
        attacked = false; 
    }
}

if (place_meeting(x, y, obj_apex)) {
    var _push_dir = sign(x - obj_apex.x);
    if (_push_dir == 0) _push_dir = 1;
    x += _push_dir * 2; 
}

if (place_meeting(x + hsp, y, obj_apex)) {
    if (bbox_bottom > obj_apex.bbox_top + 20) { 
        while (!place_meeting(x + sign(hsp), y, obj_apex)) {
            x += sign(hsp);
        }
        hsp = 0; 
    }
}

x += hsp;
x = clamp(x, 100, 1820);