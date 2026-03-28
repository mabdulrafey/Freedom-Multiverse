// Only run the wave logic if Jon Snow is still alive and fighting
if (global.north_state == "playing") {
    
    // --- TUTORIAL STATE ---
    if (state == "tutorial") {
        // Wait for the player to press ENTER to start the battle
        if (keyboard_check_pressed(vk_enter)) {
            state = "spawning"; 
        }
    }
    
    // --- SPAWNING STATE ---
    else if (state == "spawning") {
        spawn_timer -= 1;
        
        if (spawn_timer <= 0) {
            var _spawn_x = choose(-32, room_width + 32); 
            var _spawn_y = random_range(50, room_height - 50);
            
            // Is it Wave 5? If so, spawn Ramsay ONCE!
            if (current_wave == 5 && ramsay_spawned == false) {
                instance_create_layer(room_width / 2, 100, "Instances", obj_ramsay); 
                ramsay_spawned = true; // Prevents him from spawning again
            }
            
            // Spawn the regular enemy grunts
            if (enemies_spawned < enemies_in_wave) {
                instance_create_layer(_spawn_x, _spawn_y, "Instances", obj_enemy);
                enemies_spawned += 1;
                spawn_timer = 60; // Reset the timer for the next grunt
            }
            
            // Check if all grunts for this wave have been spawned
            if (enemies_spawned >= enemies_in_wave) {
                state = "waiting";
            }
        }
    } 
    
    // --- WAITING STATE ---
    // Wait for Jon Snow to clear the battlefield
    else if (state == "waiting") {
        
        // Check if ALL enemies (grunts AND Ramsay) are defeated
        if (!instance_exists(obj_enemy) && !instance_exists(obj_ramsay)) {
            
            // If you beat Wave 5, you win the game!
            if (current_wave == 5) {
                global.north_state = "win"; // Triggers the victory screen
            } else {
                // If it's Waves 1-4, start the delay for the next wave
                state = "delay";
                current_wave += 1;
            }
        }
    } 
    
    // --- DELAY STATE ---
    // Give the player a 3-second breather before the next wave
    else if (state == "delay") {
        wave_delay -= 1;
        
        if (wave_delay <= 0) {
            state = "spawning";
            enemies_spawned = 0;
            
            // Automatically scales the enemies! (Wave 2 = 4, Wave 3 = 6, etc.)
            enemies_in_wave = current_wave * 2; 
            
            wave_delay = 180; // Reset the breather timer
        }
    }
}