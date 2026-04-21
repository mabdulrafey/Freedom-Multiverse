var _xscale = (300 / sprite_get_width(sprite_index)) * facing;
var _yscale = (400 / sprite_get_height(sprite_index));
draw_sprite_ext(sprite_index, image_index, x, y, _xscale, _yscale, 0, c_white, image_alpha);