draw_set_halign(fa_center);

if (global.fictionland_state == "tutorial") {
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, 1920, 1080, false);
    draw_set_alpha(1.0);
    
    draw_set_color(c_white);
    draw_text_transformed(960, 400, "TUTORIAL", 4, 4, 0);
    draw_text_transformed(960, 500, "Left / Right Arrow: Move\nSpace: Jump\nA: Kick\nS: Punch\nD: Block", 2, 2, 0);
    draw_text_transformed(960, 800, "Press ENTER to Start", 2, 2, 0);
} else {
    if (instance_exists(obj_apex) && instance_exists(obj_void)) {
        draw_healthbar(100, 50, 800, 90, obj_apex.hp, c_maroon, c_red, c_lime, 0, true, true);
        draw_healthbar(1120, 50, 1820, 90, obj_void.hp, c_maroon, c_red, c_lime, 1, true, true);
    }
    
    if (global.fictionland_state == "gameover") {
        draw_set_color(c_yellow);
        draw_text_transformed(960, 500, "GAME OVER", 5, 5, 0);
    }
}