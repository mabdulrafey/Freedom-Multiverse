// If the tutorial is active, freeze everything in this object
if (global.hogwarts_state.tutorial_active == true) {
    exit; 
}
instance_destroy(other); // Destroys the spell

hp -= 1; // Take 1 damage
if (hp <= 0) {
    instance_destroy(); // Die if HP hits 0
}