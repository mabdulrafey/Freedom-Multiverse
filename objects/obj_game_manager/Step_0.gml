// --- GLOBAL CHEAT CODES ---
if (string_count("skip", string_lower(keyboard_string)) > 0) {
    keyboard_string = ""; 

    if (room_next(room) != -1) {
        room_goto_next(); 
    }
}

if (string_count("reset", string_lower(keyboard_string)) > 0) {
    keyboard_string = ""; 
    room_restart();
}