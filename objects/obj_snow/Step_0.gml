// 1. Tick down the invincibility timer
if (iframes > 0) {
    iframes -= 1;
    image_blend = c_red; // Flashes red when hit
} else {
    image_blend = c_white; // Returns to normal color
}

// 2. Check if Jon Snow is dead
if (hp <= 0) {
    global.north_state = "lose"; // Triggers the defeat screen
    instance_destroy();         // Removes Jon from the battlefield
}

// 1. Get keyboard input (Arrow keys only)
var _right = keyboard_check(vk_right);
var _left = keyboard_check(vk_left);
var _up = keyboard_check(vk_up);
var _down = keyboard_check(vk_down);

// 2. Calculate movement direction
var _hspd = (_right - _left) * move_speed;
var _vspd = (_down - _up) * move_speed;

// 3. Apply movement to his X and Y coordinates
x += _hspd;
y += _vspd;
// --- FOOTSTEP AUDIO LOGIC ---
// Check if Jon is actually moving
if (_hspd != 0 || _vspd != 0) {
    footstep_timer -= 1;
    
    // When the timer hits zero, play the sound!
    if (footstep_timer <= 0) {
        
        // This plays the sound. The "1" is priority, "false" means it won't loop forever.
        var _step = audio_play_sound(snd_footstep_snow, 1, false);
        
        // PRO TIP: This slightly randomizes the pitch so it doesn't sound like a robot taking the exact same step every time!
        audio_sound_pitch(_step, random_range(0.8, 1.2)); 
        
        // Reset the timer for the next step
        footstep_timer = footstep_delay; 
    }
} else {
    // If he stops moving, reset the timer to 0 so his first step next time is instant
    footstep_timer = 0; 
}

// 4. Change Sprites, update "facing" direction, and control animation
if (_hspd > 0) {
    sprite_index = spr_jon_right; 
    facing = "right";
    image_speed = 0.5; 
} else if (_hspd < 0) {
    sprite_index = spr_jon_left;  
    facing = "left";
    image_speed = 0.5;
} else if (_vspd > 0) {
    sprite_index = spr_jon_down;  
    facing = "down";
    image_speed = 0.5;
} else if (_vspd < 0) {
    sprite_index = spr_jon_up;    
    facing = "up";
    image_speed = 0.5;
} else {
    image_speed = 0; // Still stops the animation completely
    image_index = 0; // Still resets to the standing frame
}
// 5. Attack Logic (Now using the "S" key!)
if (keyboard_check_pressed(ord("S"))) { 
    
    // Create the sword exactly where Jon is
    var _sword = instance_create_layer(x, y, "Instances", obj_sword);
    
    // Position and rotate the sword based on where Jon is facing
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
// Keep Jon Snow strictly inside the room dimensions
x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16);