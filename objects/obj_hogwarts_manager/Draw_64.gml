// Set text color to white so it stands out against spr_hogwarts
draw_set_color(c_white);

// Pull the values from our state struct
var _collected = global.hogwarts_state.items_collected;
var _total = global.hogwarts_state.total_items;

// Format and draw the text
var _ui_text = "Items Found: " + string(_collected) + " / " + string(_total);
draw_text(50, 20, _ui_text);