if (global.fictionland_state == "tutorial") {
    if (keyboard_check_pressed(vk_enter)) {
        global.fictionland_state = "playing";
        instance_activate_object(obj_void);
    }
}