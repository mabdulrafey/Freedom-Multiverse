if (global.magicland_tutorial) exit;
if (!other.invincible) {
	var _hurt_snd = audio_play_sound(snd_kid_hurt, 50, false);
	audio_sound_pitch(_hurt_snd, 1.5);
    global.magicland_lives -= 1;
    other.invincible = true;
    other.invincible_timer = 90; 
}
