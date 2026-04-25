y_offset -= scroll_speed;

if (credits_alpha < 1) {
    credits_alpha += 0.01;
}

if (y_offset < -500) {
    y_offset = 700;
}