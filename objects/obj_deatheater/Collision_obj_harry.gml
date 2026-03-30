// If the tutorial is active, freeze everything in this object
if (global.hogwarts_state.tutorial_active == true) {
    exit; 
}
if (!other.is_invincible) {
    global.hogwarts_state.harry_hp = 0; 
}