if (dialogue_timer > 0) {
    

    var _screen_w = display_get_gui_width();
    var _screen_h = display_get_gui_height();
    

    draw_set_alpha(0.7); 
    draw_set_color(c_black);

    draw_rectangle(0, _screen_h - 80, _screen_w, _screen_h, false); 
    draw_set_alpha(1.0); 
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_red); 
    
    draw_text(_screen_w / 2, _screen_h - 40, "Boss: \"You have to Earn your freedom!\"");

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}