if (sprite_index != -1) {
    draw_sprite_stretched(sprite_index, 0, 0, 0, display_get_gui_width(), display_get_gui_height());
}

draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_text(display_get_gui_width() - 20, display_get_gui_height() - 20, "Press ENTER to continue...");