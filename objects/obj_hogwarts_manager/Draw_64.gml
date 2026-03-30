if (global.hogwarts_state.tutorial_active == true) {
    // 1. Draw a dark transparent background over everything
    draw_set_color(c_black);
    draw_set_alpha(0.5);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    
    // 2. Setup text formatting (centered and white)
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Find the center of the screen
    var _cx = display_get_gui_width() / 2;
    var _cy = display_get_gui_height() / 2;
    
    // 3. Draw your custom tutorial text
    draw_text(_cx, _cy - 60, "Earn your freedom via collecting all the hidden items!");
    draw_text(_cx, _cy - 30, "Once the hidden items are collected, the door");
    draw_text(_cx, _cy, "will be opened to go to the next universe.");
    
    draw_set_color(c_yellow);
    draw_text(_cx, _cy + 50, "CONTROLS:");
    draw_set_color(c_white);
    draw_text(_cx, _cy + 80, "Arrow Up, Right, Left for movement");
    draw_text(_cx, _cy + 110, "Press 'S' to cast a spell that kills Nagini and Death Eaters");
    
    // 4. Draw flashing prompt to start
    draw_set_color(c_yellow);
    draw_text(_cx, _cy + 180, "[ PRESS ENTER TO BEGIN ]");
    
    // 5. Reset alignment for the rest of the game
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    
} else {
    // THIS IS YOUR NORMAL HUD (Only draws when tutorial is over)
    draw_set_color(c_white);
    var _collected = global.hogwarts_state.items_collected;
    var _total = global.hogwarts_state.total_items;
    var _hp = global.hogwarts_state.harry_hp;
    
    var _ui_text = "Items: " + string(_collected) + "/" + string(_total) + " | Lives: " + string(_hp);
    draw_text(50, 50, _ui_text);
}