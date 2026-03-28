if (iframes == 0) {
    hp -= 1;       
    iframes = 45; 
    
    // --- PLAY HURT SOUND ---
    
    var _hurt = audio_play_sound(snd_jon_hurt, 10, false);
    
    // Pitch variation so it doesn't sound like the exact same grunt every time
    audio_sound_pitch(_hurt, random_range(0.9, 1.1)); 
}