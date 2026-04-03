
hp = 3; // NEW: Takes 3 hits to defeat
fly_spd = 3;
aggro_range = 400; // How close Harry has to be before it attacks
state = "patrol";

path_start(path_death_eater, fly_spd, path_action_reverse, true);
deatheater_snd = audio_play_sound(snd_deatheater, 1, true);
audio_sound_pitch(deatheater_snd, random_range(0.8, 1.2));