
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
            attack_cooldown = 60;  
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
				var _step = audio_play_sound(snd_enemy_footstep, 1, false);
				audio_sound_pitch(_step, random_range(0.6, 0.9)); 
        
				footstep_timer = footstep_delay;
			}
		} else {
			footstep_timer = 0;
		}

        
        image_speed = 0.5; 

        
        if (abs(_hspd) > abs(_vspd)) { 
            
            if (_hspd > 0) {
                sprite_index = spr_enemy_soldier_right; 
                facing = "right";
            } else {
                sprite_index = spr_enemy_soldier_left;  
                facing = "left";
            }
        } else { 
            
            if (_vspd > 0) {
                sprite_index = spr_enemy_soldier_down;  
                facing = "down";
            } else {
                sprite_index = spr_enemy_soldier_up;    
                facing = "up";
            }
        }
    } 
    
    else {
        
        image_speed = 0;
        image_index = 0;

        
        if (can_attack == true) {
            
            var _spar = instance_create_layer(x, y, "Instances", obj_spar);

            
            if (facing == "right") { _spar.x += 32; _spar.image_angle = 0; }
            if (facing == "left") { _spar.x -= 32; _spar.image_angle = 180; }
            if (facing == "down") { _spar.y += 32; _spar.image_angle = 270; }
            if (facing == "up") { _spar.y -= 32; _spar.image_angle = 90; }
            can_attack = false;
        }
    }
} else {
    image_speed = 0;
    image_index = 0;
}