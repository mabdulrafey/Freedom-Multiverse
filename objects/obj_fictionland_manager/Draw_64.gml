draw_set_halign(fa_center);

if (global.fictionland_state == "tutorial") {
    draw_set_color(c_black);
    draw_set_alpha(0.3);
    draw_rectangle(0, 0, 1920, 1080, false);
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_text_transformed(960, 400, "TUTORIAL", 4, 4, 0);
    draw_text_transformed(960, 500, "Left / Right Arrow: Move\nSpace: Jump\nA: Kick\nS: Punch\nD: Block", 2, 2, 0);
    draw_text_transformed(960, 700, "Try all the movements before hitting ENTER!", 2, 2, 0);
    draw_text_transformed(960, 800, "Press ENTER to Start", 2, 2, 0);

} else {
    if (instance_exists(obj_apex) && instance_exists(obj_void)) {
        
        
        var apex_current = max(0, obj_apex.hp);
        var void_current = max(0, obj_void.hp);
        
        
        var apex_w = (apex_current / obj_apex.max_hp) * 700;
        var void_w = (void_current / obj_void.max_hp) * 700;
        
        
        draw_set_color(c_dkgray);
        draw_rectangle(95, 45, 805, 95, false);    
        draw_rectangle(1115, 45, 1825, 95, false); 
        
        
        draw_set_color(make_color_rgb(60, 0, 0)); 
        draw_rectangle(100, 50, 800, 90, false);
        draw_rectangle(1120, 50, 1820, 90, false);
        
       
        draw_set_color(make_color_rgb(0, 200, 50));
        if (apex_w > 0) {
            draw_rectangle(100, 50, 100 + apex_w, 90, false);
        }
        
        
        draw_set_color(make_color_rgb(220, 150, 0));
        if (void_w > 0) {
            draw_rectangle(1820 - void_w, 50, 1820, 90, false);
        }
        
       
        draw_set_color(c_white);
        
        
        draw_set_halign(fa_left);
        draw_text_transformed(100, 110, "CAPTAIN APEX", 1.5, 1.5, 0);
        
        
        draw_set_halign(fa_right);
        draw_text_transformed(1820, 110, "VOID", 1.5, 1.5, 0);
        
        
        draw_set_halign(fa_center);
    }
    
    
    if (global.fictionland_state == "gameover") {
        draw_set_color(c_yellow);
        draw_text_transformed(960, 500, "K.O.", 6, 6, 0);
    }
}