/// @description Check Win Condition and Enter Door

// --- 1. UNLOCK LOGIC ---
if (is_locked) {
    // Check if collected items meet or exceed the total required
    if (global.hogwarts_state.items_collected >= global.hogwarts_state.total_items) {
        // Unlock the door and change the sprite
        is_locked = false;
        sprite_index = spr_door_open;
    }
}

// --- 2. DOOR ENTRY LOGIC ---
if (!is_locked) {
    // Manually check if Harry is touching the door
    if (place_meeting(x, y, obj_harry)) {
        
        // Listen specifically for the Right Arrow key, just as you requested
        var _key_enter = keyboard_check_pressed(vk_right);
        
        if (_key_enter) {
            // Check if a next room exists in your game
            if (room_next(room) != -1) {
                room_goto_next(); 
            } else {
                // If there is no next room, restart the game as a placeholder
                game_restart();
            }
        }
    }
}