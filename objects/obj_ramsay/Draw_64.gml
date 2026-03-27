if (dialogue_timer > 0) {
    
    // 1. Get screen dimensions
    var _screen_w = display_get_gui_width();
    var _screen_h = display_get_gui_height();
    
    // 2. Draw a semi-transparent black background box for readability
    draw_set_alpha(0.7); // 70% solid
    draw_set_color(c_black);
    // Draws a box across the bottom 80 pixels of the screen
    draw_rectangle(0, _screen_h - 80, _screen_w, _screen_h, false); 
    draw_set_alpha(1.0); // Reset alpha back to normal so the rest of the game doesn't go transparent!
    
    // 3. Draw Ramsay's dialogue text
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_red); // Bolton Red!
    
    draw_text(_screen_w / 2, _screen_h - 40, "Ramsay: \"You have to gain your freedom, so-called King of the North!\"");
    
    // 4. Reset the text alignment so Jon's health bar doesn't get messed up
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}