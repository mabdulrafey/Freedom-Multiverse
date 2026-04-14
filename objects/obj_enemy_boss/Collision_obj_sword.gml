if (iframes == 0) {
    hp -= 1;       
    iframes = 30;  

    var _hurt = audio_play_sound(snd_enemy_hurt, 10, false);

    audio_sound_pitch(_hurt, random_range(0.5, 0.8)); 
}