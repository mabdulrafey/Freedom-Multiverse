if (dialogue_timer > 0) {
    dialogue_timer -= 1;
}

if (iframes > 0) {
    iframes -= 1;
    image_blend = c_red; 
} else {
    image_blend = c_white;
}

if (hp <= 0) {
    instance_destroy(); 
}


if (instance_exists(obj_soldier)) {
    
    var _dist = point_distance(x, y, obj_soldier.x, obj_soldier.y);
    var _dir = point_direction(x, y, obj_soldier.x, obj_soldier.y);
    

    if (can_attack == false) {
        attack_cooldown -= 1;
        if (attack_cooldown <= 0) {
            can_attack = true;
            attack_cooldown = 90; 
        }
    }

    if (_dist > attack_range) {
        var _hspd = lengthdir_x(move_speed, _dir);
        var _vspd = lengthdir_y(move_speed, _dir);
        
        x += _hspd;
        y += _vspd;
		
        if (_hspd != 0 || _vspd != 0) {
            footstep_timer -= 1;
            
            if (footstep_timer <= 0) {
                var _step = audio_play_sound(snd_footstep_soldier, 1, false);

                audio_sound_pitch(_step, random_range(0.5, 0.7)); 
                
                footstep_timer = footstep_delay;
            }
        } else {
            footstep_timer = 0;
        }
        
        image_speed = 0.5; 

        if (abs(_hspd) > abs(_vspd)) { 
            if (_hspd > 0) { sprite_index = spr_enemy_boss_right; facing = "right"; image_speed = 0.25; } 
            else { sprite_index = spr_enemy_boss_left; facing = "left";image_speed = 0.25;  }
        } else { 
            if (_vspd > 0) { sprite_index = spr_enemy_boss_down; facing = "down";image_speed = 0.25;  } 
            else { sprite_index = spr_enemy_boss_up; facing = "up"; image_speed = 0.25; }
        }
    } 
    else {
        image_speed = 0; 
        image_index = 0;
        
        if (_dir > 45 && _dir <= 135) { sprite_index = spr_enemy_boss_up; }
        else if (_dir > 135 && _dir <= 225) { sprite_index = spr_enemy_boss_left; }
        else if (_dir > 225 && _dir <= 315) { sprite_index = spr_enemy_boss_down; }
        else { sprite_index = spr_enemy_boss_right; }

        if (can_attack == true) {
            var _thrown_spar = instance_create_layer(x, y, "Instances", obj_spar);

            _thrown_spar.direction = _dir;
            _thrown_spar.image_angle = _dir; 
            _thrown_spar.speed = 4;          

            _thrown_spar.alarm[0] = 120; 
            
            can_attack = false;
        }
    }
} else {
    image_speed = 0;
}