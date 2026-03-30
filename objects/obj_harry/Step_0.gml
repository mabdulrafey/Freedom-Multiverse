// 1. Get Player Input
var _key_right = keyboard_check(vk_right);
var _key_left = keyboard_check(vk_left);
var _key_jump = keyboard_check_pressed(vk_up);
var _key_shoot = keyboard_check_pressed(vk_space); // The attack button

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

// 4. Apply Gravity
vspd += grv; 

// 5. Jump Logic
if (place_meeting(x, y + 1, obj_wall)) && (_key_jump) {
    vspd = jump_speed;
}

// 6. Horizontal Collision
if (place_meeting(x + hspd, y, obj_wall)) {
    while (!place_meeting(x + sign(hspd), y, obj_wall)) {
        x = x + sign(hspd);
    }
    hspd = 0; 
}
x += hspd; 

// 7. Vertical Collision 
if (place_meeting(x, y + vspd, obj_wall)) {
    while (!place_meeting(x, y + sign(vspd), obj_wall)) {
        y = y + sign(vspd);
    }
    vspd = 0; 
}
y += vspd; 

// 8. Shooting Logic
if (shoot_cooldown > 0) {
    shoot_cooldown -= 1;
} else {
    can_shoot = true;
    is_shooting = false; // Stop playing the casting animation
}

if (_key_shoot && can_shoot) {
    is_shooting = true;
    can_shoot = false;
    shoot_cooldown = 25; // How long before he can shoot again
    
    // Create the spell directly in front of his wand
    var _spell = instance_create_layer(x + (16 * image_xscale), y - 20, "Instances", obj_spell);
    
    // Make the spell fly in the direction Harry is facing!
    _spell.hspeed = 8 * image_xscale; 
    _spell.image_xscale = image_xscale; // Flip the spell sprite to match
}

// 9. ANIMATION HIERARCHY
if (is_shooting) {
    // Priority 1: If shooting, override everything else to show the wand cast
    sprite_index = spr_harry_cast;
    image_speed = 0.5;
} else if (!place_meeting(x, y + 1, obj_wall)) {
    // Priority 2: If we are not touching the floor, play air animations
    if (vspd < 0) {
        sprite_index = spr_harry_jump;
    } else {
        sprite_index = spr_harry_fall;
    }
} else {
    // Priority 3: We are on the ground, so run or stand still
    if (hspd == 0) {
        sprite_index = spr_harry_idle;
        image_speed = 0.05; // EXTREMELY slow idle animation!
    } else {
        sprite_index = spr_harry_right; 
        image_speed = 0.5; // Normal running speed
    }
}

// Flip Harry's sprite left or right based on movement direction
if (hspd != 0) {
    image_xscale = sign(hspd); 
}

// Keep him inside the room
x = clamp(x, 16, room_width - 16);