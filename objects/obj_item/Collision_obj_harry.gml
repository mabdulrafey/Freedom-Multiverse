// If the tutorial is active, freeze everything in this object
if (global.hogwarts_state.tutorial_active == true) {
    exit; 
}
// Increase the counter inside the struct
global.hogwarts_state.items_collected += 1;

// Destroy the item so it disappears from the room
instance_destroy();