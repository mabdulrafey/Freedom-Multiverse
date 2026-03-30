if (global.hogwarts_state.tutorial_active == true) {
    // If they press Enter, turn off the tutorial
    if (keyboard_check_pressed(vk_enter)) {
        global.hogwarts_state.tutorial_active = false;
		
    }
}