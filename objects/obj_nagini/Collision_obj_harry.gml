// If the tutorial is active, freeze everything in this object
if (global.hogwarts_state.tutorial_active == true) {
    exit; 
}
// Damage Harry, but only if he isn't already flashing
if (!other.is_invincible) {
    global.hogwarts_state.harry_hp -= 1; // Take 1 damage
    
    // Trigger his I-Frames
    other.is_invincible = true;
    other.invincibility_timer = 60; // 60 frames = 1 second of invincibility
}