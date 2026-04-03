global.hogwarts_state = {
    items_collected: 0,
    total_items: 5,
    harry_hp: 3,
    tutorial_active: true, // NEW: Game starts paused for the tutorial
	victory_achieved: false 
};
ambient_breeze = audio_play_sound(snd_hogwarts, 0, true);
victory_sound_played = false;
