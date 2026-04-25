draw_set_alpha(credits_alpha);
draw_set_halign(fa_center);


draw_sprite_stretched(spr_endscreen, 0, 0, 0, room_width, room_height);

draw_set_alpha(0.3);
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);


draw_set_alpha(credits_alpha);


draw_set_color(c_white);
draw_set_font(fnt_title);
draw_text(room_width/2, y_offset, "FREEDOM MULTIVERSE");

draw_set_font(fnt_normal);
draw_set_color(make_color_rgb(200, 200, 200));
draw_text(room_width/2, y_offset + 60, "A Mind & Machine Production");

draw_set_color(make_color_rgb(80, 80, 80));
draw_line(room_width/2 - 120, y_offset + 100, room_width/2 + 120, y_offset + 100);


draw_set_color(make_color_rgb(160, 160, 160));
draw_set_font(fnt_normal);
draw_text(room_width/2, y_offset + 130, "CREATED BY");

draw_set_color(c_white);
draw_set_font(fnt_title);
draw_text(room_width/2, y_offset + 165, "Muhammad Abdul Rafey");

draw_set_color(make_color_rgb(200, 200, 200));
draw_set_font(fnt_normal);
draw_text(room_width/2, y_offset + 215, "Producer  /  Programmer  /  Designer");
draw_text(room_width/2, y_offset + 245, "Artist  /  Sound Curator");

draw_set_color(make_color_rgb(80, 80, 80));
draw_line(room_width/2 - 120, y_offset + 285, room_width/2 + 120, y_offset + 285);


draw_set_color(make_color_rgb(160, 160, 160));
draw_set_font(fnt_normal);
draw_text(room_width/2, y_offset + 310, "SPECIAL THANKS");

draw_set_color(c_white);
draw_set_font(fnt_title);
draw_text(room_width/2, y_offset + 345, "Gemini  &  Claude");

draw_set_color(make_color_rgb(80, 80, 80));
draw_line(room_width/2 - 120, y_offset + 395, room_width/2 + 120, y_offset + 395);


draw_set_color(make_color_rgb(140, 140, 140));
draw_set_font(fnt_normal);
draw_text(room_width/2, y_offset + 425, "Made with passion - solo, start to finish.");


draw_set_alpha(1);
draw_set_color(c_white);