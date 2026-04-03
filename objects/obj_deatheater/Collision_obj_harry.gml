// If the tutorial is active, freeze everything in this object
if (global.hogwarts_state.tutorial_active == true) {
    exit; 
}
if (!other.is_invincible) {
	// --- NEW: PLAY THE HURT SOUND ---
    audio_play_sound(snd_harry_hurt, 1, false);
    global.hogwarts_state.harry_hp = 0; 
}