// Center the text alignment
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Find the center of the screen (GUI layer)
var _center_x = display_get_gui_width() / 2;
var _center_y = display_get_gui_height() / 2;

// Draw Victory Text
if (global.north_state == "win") {
    draw_set_color(c_yellow);
    draw_text(_center_x, _center_y, "You have earned your freedom");
    
    // Tell them how to restart
    draw_set_color(c_white);
    draw_text(_center_x, _center_y + 30, "Press ENTER to restart");
    
    if (keyboard_check_pressed(vk_enter)) { room_restart(); }
} 
// Draw Defeat Text
else if (global.north_state == "lose") {
    draw_set_color(c_red);
    draw_text(_center_x, _center_y, "You didn't fight hard enough to earn your freedom");
    
    // Tell them how to try again
    draw_set_color(c_white);
    draw_text(_center_x, _center_y + 30, "Press ENTER to try again");
    
    if (keyboard_check_pressed(vk_enter)) { room_restart(); }
}

// Reset the text alignment back to normal so Jon's health bar doesn't break!
draw_set_halign(fa_left);
draw_set_valign(fa_top);