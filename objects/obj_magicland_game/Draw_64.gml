draw_set_color(c_white);

if (global.magicland_tutorial) {
    draw_set_halign(fa_center);
    
    draw_set_color(c_black);
    draw_set_alpha(0.3);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1); 
	
    draw_set_font(fnt_big_bold);
    draw_set_color(make_color_rgb(255, 215, 0));
    draw_text(960, 250, "EARN YOUR FREEDOM");
    
    
    draw_set_font(-1); 
    draw_set_color(c_white);
    draw_text(960, 350, "You have to collect 5 scrolls hidden across the Magic Land.");
    draw_text(960, 390, "Avoid the deadly snakes and the wandering ghost to earn your freedom.");
    
    
    draw_text(960, 550, "Movement: Arrow Keys (Up, Left, Right)");
    draw_text(960, 590, "Attack: Press 'S' to Cast Spell");
    
    
    draw_text(960, 750, "[ PRESS ENTER TO START ]");
    
    draw_set_halign(fa_left); 
} else {
  
    draw_set_font(-1);
    draw_set_color(c_white);
    draw_text(50, 50, "Lives: " + string(global.magicland_lives));
    draw_text(50, 80, "Scrolls: " + string(global.magicland_scrolls) + " / 5");
}

    
if (global.magicland_scrolls >= 5) {
        var _center_x = display_get_gui_width() / 2; 
        
        draw_set_halign(fa_center); 
        
        draw_set_color(make_color_rgb(255, 215, 0)); 
        draw_set_font(fnt_big_bold); 
        draw_text(_center_x, 500, "You have earned your freedom!");
        
        draw_set_font(-1); 
        draw_set_color(c_white);
        draw_text(_center_x, 600, "Wall is removed! GO TO NEXT UNIVERSE");
        
        draw_set_halign(fa_left); 
  }