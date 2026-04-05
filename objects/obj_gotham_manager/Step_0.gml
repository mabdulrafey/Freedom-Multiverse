if (instance_exists(obj_batman) && instance_exists(obj_joker)) {
    
    // 1. Check if anyone has died
    if (obj_batman.hp <= 0 || obj_joker.hp <= 0) {
        game_over = true;
    }

    // 2. Countdown the timer if the match is active
    if (!game_over && fight_timer > 0) {
        frames_passed++;
        
        if (frames_passed >= 60) { // Since your game is 30 FPS, 30 frames = 1 real second
            fight_timer--;
            frames_passed = 0;
        }
    }

    // 3. Time Over Logic
    if (fight_timer <= 0 && !game_over) {
        game_over = true;
        
        // Whoever has less health instantly drops to 0 HP (KO)
        if (obj_batman.hp > obj_joker.hp) {
            obj_joker.hp = 0; 
        } else if (obj_joker.hp > obj_batman.hp) {
            obj_batman.hp = 0; 
        } else {
            // It's a draw! Both fall down.
            obj_batman.hp = 0;
            obj_joker.hp = 0;
        }
    }
}