if (global.magicland_tutorial) {
    if (keyboard_check_pressed(vk_enter)) { 
        if (instance_exists(obj_kid)) {
            obj_kid.x = obj_kid.spawn_x;
            obj_kid.y = obj_kid.spawn_y;
        }
        global.magicland_tutorial = false;
    }
}

if (global.magicland_lives <= 0) {
    global.magicland_lives = 3;
    global.magicland_scrolls = 0;
    room_restart();
}