// If the tutorial is active, freeze everything in this object
if (global.hogwarts_state.tutorial_active == true) {
    exit; 
}
// Destroy the spell that hit it
instance_destroy(other); 

// Subtract 1 from its health
hp -= 1; 

// Check if it has run out of health
if (hp <= 0) {
    instance_destroy(); 
}