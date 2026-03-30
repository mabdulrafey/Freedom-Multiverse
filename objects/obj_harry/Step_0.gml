// --- 1. GET PLAYER INPUT ---
var key_left = keyboard_check(vk_left);
var key_right = keyboard_check(vk_right);
var key_jump = keyboard_check_pressed(vk_up);
var key_cast = keyboard_check_pressed(ord("S"));

// Trigger the casting state
if (key_cast && !is_casting) {
    is_casting = true;
    image_index = 0; // Force the animation to start at frame 0
    // Notice: We removed the spell creation from here!
}

// --- 2. CALCULATE MOVEMENT ---
var move = key_right - key_left;
hsp = move * walk_spd;

// Apply gravity
vsp = vsp + grav;

// If Harry is casting, let's make him stand still so he doesn't slide while shooting
if (is_casting && place_meeting(x, y + 1, obj_wall)) {
    hsp = 0; 
}

// --- 3. JUMPING ---
if (place_meeting(x, y + 1, obj_wall)) && (key_jump) && (!is_casting) {
    vsp = jump_spd;
}

// --- 4. HORIZONTAL COLLISION ---
if (place_meeting(x + hsp, y, obj_wall)) {
    // Inch forward pixel by pixel until perfectly flush with the wall
    while (!place_meeting(x + sign(hsp), y, obj_wall)) {
        x = x + sign(hsp);
    }
    hsp = 0; 
}
x = x + hsp; 

// --- 5. VERTICAL COLLISION ---
if (place_meeting(x, y + vsp, obj_wall)) {
    // Inch downward/upward pixel by pixel until perfectly flush with the floor/ceiling
    while (!place_meeting(x, y + sign(vsp), obj_wall)) {
        y = y + sign(vsp);
    }
    vsp = 0; 
}
y = y + vsp;

// --- 6. ANIMATION HANDLING ---
if (is_casting) {
    sprite_index = spr_harry_cast;
    
    // Slow down this specific 2-frame animation so the eye can catch it
    // Tweak this number (e.g., 0.10 to 0.20) until the timing feels perfect
    image_speed = 0.50; 
    
    // Check if the animation has reached its final frame
    if (image_index >= image_number - 1) {
        
        // --- NEW: CREATE AND FIRE THE SPELL AT THE END OF ANIMATION ---
        var _dir = sign(image_xscale);
        if (_dir == 0) _dir = 1; 
        
        var _wand_x = x + (30 * _dir);
        var _wand_y = y - 100; 
        
        var _spell = instance_create_layer(_wand_x, _wand_y, "Instances", obj_spell);
        _spell.hspeed = 15 * _dir;
        _spell.image_xscale = _dir;
        
        // Unlock the state so he can move again
        is_casting = false; 
    }
} else {
    // Reset animation speed back to normal for running and jumping
    image_speed = 0.25; 
    
    // Normal animations when NOT casting
    if (!place_meeting(x, y + 1, obj_wall)) {
        if (vsp < 0) {
            sprite_index = spr_harry_jump; 
        } else {
            sprite_index = spr_harry_fall; 
        }
    } else {
        if (hsp == 0) {
            sprite_index = spr_harry_idle;
        } else {
            sprite_index = spr_harry_right;
        }
    }
}

// --- 7. FACING DIRECTION ---
if (hsp != 0 && !is_casting) {
    image_xscale = sign(hsp) * scale_factor; 
}
// --- 8. HEALTH & DAMAGE HANDLING ---
if (is_invincible) {
    invincibility_timer -= 1;
    
    // Create a flashing effect by toggling image alpha (transparency)
    if (invincibility_timer % 10 < 5) {
        image_alpha = 0.5; 
    } else {
        image_alpha = 1.0;
    }
    
    // End invincibility
    if (invincibility_timer <= 0) {
        is_invincible = false;
        image_alpha = 1.0; // Reset to fully visible
    }
}

// Check for Death
if (global.hogwarts_state.harry_hp <= 0) {
    room_restart(); 
}