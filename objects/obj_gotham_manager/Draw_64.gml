if (instance_exists(obj_batman) && instance_exists(obj_joker)) {
    
    var _bar_height = 40;
    var _bar_y = 50; 
    
    // --- 1. HEALTH BARS ---
    draw_healthbar(50, _bar_y, 850, _bar_y + _bar_height, obj_batman.hp, c_dkgray, c_red, c_green, 0, true, true);
    draw_healthbar(1070, _bar_y, 1870, _bar_y + _bar_height, obj_joker.hp, c_dkgray, c_red, c_green, 1, true, true);
    
    // --- 2. CHARACTER NAMES ---
    draw_set_color(c_white);
    draw_set_valign(fa_top);
    draw_set_halign(fa_left); 
    draw_text_transformed(50, _bar_y + _bar_height + 10, "BATMAN", 2, 2, 0);
    
    draw_set_halign(fa_right); 
    draw_text_transformed(1870, _bar_y + _bar_height + 10, "JOKER", 2, 2, 0);
    
    // --- 3. THE TIMER ---
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    if (fight_timer <= 10) draw_set_color(c_red);
    else draw_set_color(c_yellow);
    
    draw_text_transformed(1920 / 2, _bar_y + (_bar_height / 2), string(fight_timer), 4, 4, 0);
    
    // ==========================================
    // 4. THE TUTORIAL SCREEN
    // ==========================================
    if (tutorial_mode) {
        // Dramatic Intro Lore
        draw_set_color(c_yellow);
        draw_text_transformed(1920 / 2, 250, "The soul of Gotham hangs in the balance.", 3, 3, 0);
        draw_text_transformed(1920 / 2, 320, "Fight to restore freedom to its streets!", 3, 3, 0);
        
        // Controls
        draw_set_color(c_white);
        draw_text_transformed(1920 / 2, 500, "- CONTROLS -", 2, 2, 0);
        draw_text_transformed(1920 / 2, 580, "Arrow Keys : Move & Jump", 2, 2, 0);
        draw_text_transformed(1920 / 2, 640, "Hold 'A' : Block", 2, 2, 0);
        draw_text_transformed(1920 / 2, 700, "'S' : Punch", 2, 2, 0);
        draw_text_transformed(1920 / 2, 760, "'D' : Kick", 2, 2, 0);
        
        // Start Prompt
        draw_set_color(c_green);
        draw_text_transformed(1920 / 2, 950, "PRESS [ENTER] TO BEGIN", 4, 4, 0);
    }
    
    // ==========================================
    // 5. THE GAME OVER SCREEN
    // ==========================================
    if (game_over) {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        if (fight_timer <= 0 && obj_batman.hp == obj_joker.hp) {
            draw_set_color(c_yellow);
            draw_text_transformed(1920 / 2, 1080 / 2, "TIME OVER\nDRAW", 5, 5, 0);
        } 
        // BATMAN WINS
        else if (obj_joker.hp <= 0) {
            draw_set_color(c_yellow);
            draw_text_transformed(1920 / 2, 1080 / 2 - 50, "BATMAN WINS", 6, 6, 0);
            draw_set_color(c_white);
            draw_text_transformed(1920 / 2, 1080 / 2 + 50, "You have restored freedom to Gotham's streets.", 3, 3, 0);
        } 
        // JOKER WINS
        else if (obj_batman.hp <= 0) {
            draw_set_color(c_red);
            draw_text_transformed(1920 / 2, 1080 / 2 - 50, "JOKER WINS", 6, 6, 0);
            draw_set_color(c_white);
            draw_text_transformed(1920 / 2, 1080 / 2 + 50, "Gotham falls deeper into chaos. Freedom is lost.", 3, 3, 0);
        }
    }
    
    // Reset draw settings
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}