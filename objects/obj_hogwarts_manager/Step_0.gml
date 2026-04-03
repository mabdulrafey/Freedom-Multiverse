if (global.hogwarts_state.tutorial_active == true) {
    // If they press Enter, turn off the tutorial
    if (keyboard_check_pressed(vk_enter)) {
        global.hogwarts_state.tutorial_active = false;
		
    }
}
if (global.hogwarts_state.victory_achieved == false) {
    
   
    if (global.hogwarts_state.items_collected >= global.hogwarts_state.total_items) && 
       (!instance_exists(obj_nagini)) && 
       (!instance_exists(obj_deatheater)) {
           
        // Trigger the win state!
        global.hogwarts_state.victory_achieved = true;
    }
} 
else {
    // THIS CODE RUNS THE MOMENT YOU WIN
    audio_stop_sound(ambient_breeze);
    
    // 2. Play the victory sound EXACTLY ONCE
    if (victory_sound_played == false) {
        snd_victory = audio_play_sound(snd_hogwarts_victory, 1, false);
        victory_sound_played = true; 
    }
}