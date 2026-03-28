// Center the text alignment
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Find the center of the screen (GUI layer)
var _center_x = display_get_gui_width() / 2;
var _center_y = display_get_gui_height() / 2;
// Draw Tutorial Screen
if (global.north_state == "playing" && state == "tutorial") {
    
    // 1. Draw a see-through dark background so the text pops
    draw_set_alpha(0.6);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1.0); // Reset alpha
    
    // 2. Draw the big title
    draw_set_font(fnt_big_bold);
    draw_set_color(c_white);
    draw_text(_center_x, _center_y - 80, "EARN THE FREEDOM BY DEFENDING NORTH");
    
    // 3. Draw the controls (Change these if your buttons are different!)
    draw_set_font(-1);
    draw_text(_center_x, _center_y - 10, "Use  Arrow Keys  to Move");
    draw_text(_center_x, _center_y + 20, "Press S key to Swing Sword");
    
    // 4. Draw the start prompt
    draw_set_color(c_yellow);
    draw_text(_center_x, _center_y + 80, "Press ENTER to Start Wave 1");
}
// Draw Victory Text
if (global.north_state == "win") {
    // 1. Set the big bold font for the main message
    draw_set_font(fnt_big_bold); 
    draw_set_color(c_yellow);
    draw_text(_center_x, _center_y, "You have earned your freedom");
    
    // 2. Reset back to the default small font (-1) for the instructions
    draw_set_font(-1); 
    draw_set_color(c_white);
    // Increased the +30 to +50 so it sits nicely under the giant text
    draw_text(_center_x, _center_y + 50, "Press ENTER to go to next Universe"); 
    
    if (keyboard_check_pressed(vk_enter)) { room_goto_next(); }
} 
// Draw Defeat Text
else if (global.north_state == "lose") {
    // 1. Set the big bold font for the main message
    draw_set_font(fnt_big_bold); 
    draw_set_color(c_red);
    draw_text(_center_x, _center_y, "You didn't fight hard enough to earn your freedom");
    
    // 2. Reset back to the default small font (-1) for the instructions
    draw_set_font(-1); 
    draw_set_color(c_white);
    draw_text(_center_x, _center_y + 50, "Press ENTER to try again");
    
    if (keyboard_check_pressed(vk_enter)) { room_restart(); }
}

// Reset the text alignment AND font back to normal so Jon's health bar doesn't break!
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);