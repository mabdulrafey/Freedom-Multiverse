if (iframes == 0) {
    hp -= 1;       
    iframes = 30;  
    
    // --- PLAY HURT SOUND ---
    var _hurt = audio_play_sound(snd_enemy_hurt, 10, false);
    
    // Randomize the pitch widely so the soldiers sound different
    audio_sound_pitch(_hurt, random_range(0.5, 0.8)); 
}