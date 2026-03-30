// 1. Get Player Input 
var _key_right = keyboard_check(vk_right);
var _key_left = keyboard_check(vk_left);
var _key_jump = keyboard_check_pressed(vk_up);
var _key_cast = keyboard_check_pressed(vk_space);

// 2. Health and I-Frames Logic
if (iframes > 0) {
    iframes -= 1;
    image_blend = c_red; 
} else {
    image_blend = c_white; 
}

if (hp <= 0) {
    instance_destroy(); 
}

// 3. Calculate Horizontal Movement
var _move = _key_right - _key_left; 
hspd = _move * walk_speed;

// 4. Apply Gravity & Jump Setup
vspd += grv; 

if (place_meeting(x, y + 1, obj_wall) && _key_jump) {
    vspd = jump_speed;
}

// 5. Horizontal Collision 
if (place_meeting(x + hspd, y, obj_wall)) {
    while (!place_meeting(x + sign(hspd), y, obj_wall)) {
        x += sign(hspd);
    }
    hspd = 0; 
}
x += hspd; 

// 6. Vertical Collision 
if (place_meeting(x, y + vspd, obj_wall)) {
    while (!place_meeting(x, y + sign(vspd), obj_wall)) {
        y += sign(vspd);
    }
    vspd = 0; 
}
y += vspd; 

// 7. Flip Sprite Direction
if (hspd != 0) {
    // This flips him left (-1) or right (1), but keeps his size perfectly at 0.5!
    image_xscale = sign(hspd) * base_scale; 
}

// 8. Animation Engine
var _on_ground = place_meeting(x, y + 1, obj_wall); 

// A. Trigger the Cast Animation
if (_key_cast && sprite_index != spr_harry_cast) {
    sprite_index = spr_harry_cast;
    image_index = 0;
}

// B. Prioritize Cast Animation
if (sprite_index == spr_harry_cast) {
    image_speed = 0.2; // Nice and slow so we can see the wand movement
    
    // THE FIX: Wait until the animation has fully played the final frame
    if (image_index + image_speed >= image_number) {
        sprite_index = spr_harry_idle; 
    }
} 
// C. Normal Movement Animations 
else {
    // --- AIR ANIMATIONS ---
    if (!_on_ground) { 
        
        if (vspd < 0) { // Moving UP
            if (sprite_index != spr_harry_jump) {
                sprite_index = spr_harry_jump;
                image_index = 0; 
            }
        } else {        // Moving DOWN
            if (sprite_index != spr_harry_fall) {
                sprite_index = spr_harry_fall;
                image_index = 0; 
            }
        }
        
        // Freeze on the final frame in the air
        if (image_index >= image_number - 1) {
            image_speed = 0;                
            image_index = image_number - 1; 
        } else {
            image_speed = 0.5;              
        }
    } 
    // --- GROUND ANIMATIONS ---
    else { 
        image_speed = 0.5; 
        
        if (hspd == 0) {
            sprite_index = spr_harry_idle;  
        } else {
            sprite_index = spr_harry_right; 
        }
    }
}

// 9. Keep him strictly inside the room edges
x = clamp(x, 16, room_width - 16);