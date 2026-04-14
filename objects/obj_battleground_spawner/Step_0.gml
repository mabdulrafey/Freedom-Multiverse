if (global.north_state == "playing") {
    
    if (state == "tutorial") {
        if (keyboard_check_pressed(vk_enter)) {
            state = "spawning"; 
        }
    }
    
    else if (state == "spawning") {
        spawn_timer -= 1;
        
        if (spawn_timer <= 0) {
            var _spawn_x = choose(-32, room_width + 32); 
            var _spawn_y = random_range(50, room_height - 50);
            
            if (current_wave == 5 && boss_spawned == false) {
                // FIXED: Changed to obj_enemy_boss
                instance_create_layer(room_width / 2, 100, "Instances", obj_enemy_boss); 
                boss_spawned = true; 
            }
            
            if (enemies_spawned < enemies_in_wave) {
                instance_create_layer(_spawn_x, _spawn_y, "Instances", obj_enemy_soldier);
                enemies_spawned += 1;
                spawn_timer = 60; 
            }
            
            if (enemies_spawned >= enemies_in_wave) {
                state = "waiting";
            }
        }
    } 
    
    else if (state == "waiting") {
        // FIXED: Changed to obj_enemy_boss
        if (!instance_exists(obj_enemy_soldier) && !instance_exists(obj_enemy_boss)) {
            if (current_wave == 5) {
                global.north_state = "win"; 
            } else {
                state = "delay";
                current_wave += 1;
            }
        }
    } 
    
    else if (state == "delay") {
        wave_delay -= 1;
        
        if (wave_delay <= 0) {
            state = "spawning";
            enemies_spawned = 0;
            enemies_in_wave = current_wave * 2; 
            wave_delay = 180; 
        }
    }
}