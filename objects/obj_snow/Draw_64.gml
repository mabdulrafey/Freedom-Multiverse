// 1. Calculate the health percentage
// Since we set Jon's max HP to 5, we divide his current hp by 5 and multiply by 100.
var _hp_percent = (hp / 20* 100);

// 2. Draw the actual health bar on the screen
// The numbers are the coordinates: (left_x, top_y, right_x, bottom_y)
// This draws a bar 180 pixels wide and 20 pixels tall in the top left corner.
draw_healthbar(20, 20, 200, 40, _hp_percent, c_black, c_red, c_lime, 0, true, true);

// 3. (Optional) Add a text label so you know whose health it is!
draw_set_color(c_white);
draw_text(20, 2, "Health Bar");