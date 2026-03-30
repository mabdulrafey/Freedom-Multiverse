// 1. Center the text alignment
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// 2. Find screen center & Define Colors
var _cx = display_get_gui_width() / 2;
var _cy = display_get_gui_height() / 2;

var _col_gold = make_color_rgb(255, 215, 0);
var _col_text = make_color_rgb(220, 220, 220);
var _col_red = make_color_rgb(220, 50, 50);


if (global.north_state == "playing" && state == "tutorial") {
    
    // A. Darken the background to focus the player
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1); // Reset alpha for text
    
    // B. Draw Title (With a black drop-shadow for a 3D pop effect)
    draw_set_font(fnt_big_bold);
    draw_set_color(c_black);
    draw_text(_cx + 2, _cy - 128, "EARN YOUR FREEDOM"); // Shadow
    draw_set_color(_col_gold);
    draw_text(_cx, _cy - 130, "EARN YOUR FREEDOM");   // Real text
    
    // C. Draw the Story/Mission Objective
    draw_set_font(-1);
    draw_set_color(c_white);
    draw_text(_cx, _cy - 75, "You have to fight 5 waves of very strong and capable soldiers.");
    draw_text(_cx, _cy - 50, "In the last wave, you must fight their commander Ramsay to earn your freedom.");
    
    // D. Draw Controls (Cleanly formatted)
    draw_set_color(_col_text);
    draw_text(_cx, _cy + 10, "Movement: Arrow Keys (Up, Left, Right)");
    draw_text(_cx, _cy + 35, "Attack: Press 'S' to Swing Sword");
    
    // E. Draw a subtle divider line
    draw_set_color(c_dkgray);
    draw_line(_cx - 150, _cy + 75, _cx + 150, _cy + 75);
    
    // F. Draw the start prompt
    draw_set_color(c_white);
    draw_text(_cx, _cy + 110, "[ PRESS ENTER TO START WAVE 1 ]");
}


if (global.north_state == "win") {
    // Background Dimmer
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);

    // Title with Drop Shadow
    draw_set_font(fnt_big_bold); 
    draw_set_color(c_black);
    draw_text(_cx + 2, _cy + 2, "YOU HAVE EARNED YOUR FREEDOM");
    draw_set_color(_col_gold);
    draw_text(_cx, _cy, "YOU HAVE EARNED YOUR FREEDOM");
    
    // Instructions
    draw_set_font(-1); 
    draw_set_color(c_white);
    draw_text(_cx, _cy + 50, "[ Press ENTER to go to next Universe ]"); 
    
    if (keyboard_check_pressed(vk_enter)) { room_goto_next(); }
} 


else if (global.north_state == "lose") {
    // Background Dimmer (Slightly darker for defeat)
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);

    // Title with Drop Shadow
    draw_set_font(fnt_big_bold); 
    draw_set_color(c_black);
    draw_text(_cx + 2, _cy + 2, "YOU DIDN'T FIGHT HARD ENOUGH");
    draw_set_color(_col_red);
    draw_text(_cx, _cy, "YOU DIDN'T FIGHT HARD ENOUGH");
    
    // Instructions
    draw_set_font(-1); 
    draw_set_color(c_gray);
    draw_text(_cx, _cy + 50, "[ Press ENTER to try again ]");
    
    if (keyboard_check_pressed(vk_enter)) { room_restart(); }
}


draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);