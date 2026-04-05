// 1. Always check for the Start Key first
if (keyboard_check_pressed(vk_enter)) {
    if (tutorial_mode == true) {
        tutorial_mode = false;
        // Optional: Reset the timer to 99 exactly when the fight starts
        fight_timer = 99;
        frames_passed = 0;
    }
}

// 2. Only run the rest if both fighters are in the room
if (instance_exists(obj_batman) && instance_exists(obj_joker)) {
    
    // ==========================================
    // PHASE 1: TUTORIAL MODE
    // ==========================================
    if (tutorial_mode) {
        // Keep both characters at full health while practicing
        obj_batman.hp = 100;
        obj_joker.hp = 100;
        
        // We stop the rest of the code here so the timer doesn't tick
        exit; 
    }

    // ==========================================
    // PHASE 2 & 3: THE FIGHT & GAME OVER
    // ==========================================
    
    // 1. Check if anyone has died
    if (obj_batman.hp <= 0 || obj_joker.hp <= 0) {
        game_over = true;
    }

    // 2. Countdown the timer if the match is active
    if (!game_over && fight_timer > 0) {
        frames_passed++;
        if (frames_passed >= 30) {
            fight_timer--;
            frames_passed = 0;
        }
    }

    // 3. Time Over Logic
    if (fight_timer <= 0 && !game_over) {
        game_over = true;
        if (obj_batman.hp > obj_joker.hp) obj_joker.hp = 0; 
        else if (obj_joker.hp > obj_batman.hp) obj_batman.hp = 0; 
        else {
            obj_batman.hp = 0;
            obj_joker.hp = 0;
        }
    }
}