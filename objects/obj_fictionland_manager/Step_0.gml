if (global.fictionland_state == "tutorial") {
    if (keyboard_check_pressed(vk_enter)) {
        global.fictionland_state = "playing";
        instance_activate_object(obj_void);
    }
}
if (global.fictionland_state == "gameover") {
    if (keyboard_check_pressed(vk_enter)) {
        if (instance_exists(obj_void) && obj_void.hp <= 0) {
            
            if (room_exists(room_next(room))) {
                room_goto_next(); 
            } else {
                
                game_restart(); 
            }
        } else {
            
            room_restart();
        }
    }
}