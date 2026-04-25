var _hp_percent = (hp / 30 * 100);
draw_healthbar(20, 25, 350, 60, _hp_percent, c_black, c_red, c_lime, 0, true, true);
draw_set_color(c_white);
draw_text_transformed(20, 2, "Health Bar", 1.25, 1.25, 0);