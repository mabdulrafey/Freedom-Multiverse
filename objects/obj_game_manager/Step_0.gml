// --- GLOBAL CHEAT CODES ---

// 1. The Room Skipper
if (string_count("skip", string_lower(keyboard_string)) > 0) {
    keyboard_string = ""; // Clear the memory
    
    // Safety Check: Only skip if a next room actually exists!
    if (room_next(room) != -1) {
        room_goto_next(); 
    }
}

// 2. The Game Restarter (Bonus Cheat!)
// Type "reset" anywhere to instantly restart the entire game
if (string_count("reset", string_lower(keyboard_string)) > 0) {
    keyboard_string = ""; 
    game_restart();
}