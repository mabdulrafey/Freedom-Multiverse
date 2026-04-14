if (iframes == 0) {
    hp -= 1;       
    iframes = 45; 
    var _hurt = audio_play_sound(snd_soldier_hurt, 10, false);
    audio_sound_pitch(_hurt, random_range(0.9, 1.1)); 
}