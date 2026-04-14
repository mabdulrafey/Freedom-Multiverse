if (global.magicland_tutorial) {
    if (keyboard_check_pressed(vk_return)) {
        global.magicland_tutorial = false;
    }
}

if (global.magicland_lives <= 0) {
    global.magicland_lives = 3;
    global.magicland_scrolls = 0;
    room_restart();
}