// Tick down the dialogue timer
if (dialogue_timer > 0) {
    dialogue_timer -= 1;
}

// 1. Handle I-Frames and Death
if (iframes > 0) {
    iframes -= 1;
    image_blend = c_red; // Flashes red when Jon hits him
} else {
    image_blend = c_white;
}

if (hp <= 0) {
    instance_destroy(); // Ramsay is defeated!
}

// 2. Chase and Shoot Logic
if (instance_exists(obj_snow)) {
    
    var _dist = point_distance(x, y, obj_snow.x, obj_snow.y);
    var _dir = point_direction(x, y, obj_snow.x, obj_snow.y);
    
    // Cooldown timer
    if (can_attack == false) {
        attack_cooldown -= 1;
        if (attack_cooldown <= 0) {
            can_attack = true;
            attack_cooldown = 90; // Reset timer
        }
    }

    // STATE: CHASING (If Jon is too far away)
    if (_dist > attack_range) {
        var _hspd = lengthdir_x(move_speed, _dir);
        var _vspd = lengthdir_y(move_speed, _dir);
        
        x += _hspd;
        y += _vspd;
		// --- RAMSAY FOOTSTEP AUDIO ---
        if (_hspd != 0 || _vspd != 0) {
            footstep_timer -= 1;
            
            if (footstep_timer <= 0) {
                var _step = audio_play_sound(snd_footstep_snow, 1, false);
                
                // Make Ramsay's footsteps even deeper and heavier than the grunts!
                audio_sound_pitch(_step, random_range(0.5, 0.7)); 
                
                footstep_timer = footstep_delay;
            }
        } else {
            footstep_timer = 0;
        }
        
        image_speed = 0.5; // Walking animation
        
        // Update Sprites based on direction
        if (abs(_hspd) > abs(_vspd)) { 
            if (_hspd > 0) { sprite_index = spr_ramsay_right; facing = "right"; } 
            else { sprite_index = spr_ramsay_left; facing = "left"; }
        } else { 
            if (_vspd > 0) { sprite_index = spr_ramsay_down; facing = "down"; } 
            else { sprite_index = spr_ramsay_up; facing = "up"; }
        }
    } 
    // STATE: ATTACKING (If Jon is within range)
    else {
        image_speed = 0; // Stop walking
        image_index = 0;
        
        // Face Jon Snow even while standing still to shoot
        if (_dir > 45 && _dir <= 135) { sprite_index = spr_ramsay_up; }
        else if (_dir > 135 && _dir <= 225) { sprite_index = spr_ramsay_left; }
        else if (_dir > 225 && _dir <= 315) { sprite_index = spr_ramsay_down; }
        else { sprite_index = spr_ramsay_right; }

        // Throw the Spar!
        if (can_attack == true) {
            var _thrown_spar = instance_create_layer(x, y, "Instances", obj_spar);
            
            // Make it fly toward Jon
            _thrown_spar.direction = _dir;
            _thrown_spar.image_angle = _dir; // Points the spear head forward
            _thrown_spar.speed = 4;          // Projectile speed
            
            // Override the 15-frame deletion so it can actually cross the screen
            _thrown_spar.alarm[0] = 120; 
            
            can_attack = false;
        }
    }
} else {
    image_speed = 0;
}