// Play the spell sound, don't loop it, and save the unique ID to 'my_sound'
my_spell= audio_play_sound(snd_spell, 1, false);

// Add the random pitch variation
audio_sound_pitch(my_spell, random_range(0.9, 1.1));