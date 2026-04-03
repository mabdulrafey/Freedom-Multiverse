
hp = 3;
walk_spd = 3;
vsp = 0;
grav = 0.5;
move_dir = 1; // 1 for right, -1 for left


my_hiss = audio_play_sound(snd_nagini, 1, true);


audio_sound_pitch(my_hiss, random_range(0.8, 1.2));