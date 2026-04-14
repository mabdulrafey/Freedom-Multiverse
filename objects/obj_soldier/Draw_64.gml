var _hp_percent = (hp / 20* 100);
draw_healthbar(20, 20, 200, 40, _hp_percent, c_black, c_red, c_lime, 0, true, true);
draw_set_color(c_white);
draw_text(20, 2, "Health Bar");