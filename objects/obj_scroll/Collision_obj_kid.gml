if (global.magicland_tutorial) exit;
audio_play_sound(snd_scroll_collected, 5, false);
global.magicland_scrolls += 1;
if (global.magicland_scrolls >= 5) {
    audio_stop_sound(snd_magicland); 
    audio_play_sound(snd_magicland_victory, 50, false); 
}
instance_destroy();