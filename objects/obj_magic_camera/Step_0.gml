// 1. Check if Leo exists
if (instance_exists(obj_kid)) {

    var target_x = obj_kid.x;
    var target_y = obj_kid.y - 160;

    target_x = clamp(target_x, view_w_half, room_width - view_w_half);
    target_y = clamp(target_y, view_h_half, room_height - view_h_half);

    camera_set_view_pos(cam, target_x - view_w_half, target_y - view_h_half);
}