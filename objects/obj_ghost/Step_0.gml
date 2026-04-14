if (global.magicland_tutorial) {
    path_speed = 0; 
    exit; 
} else if (state == "patrol") {
    path_speed = fly_spd; 
}

if (instance_exists(obj_kid)) {
    
    var _dist = point_distance(x, y, obj_kid.x, obj_kid.y);
    
    if (state == "patrol") {
        if (_dist < aggro_range) {
            state = "chase";
            path_end(); 
        }
    } 
    else if (state == "chase") {
        var _dir = point_direction(x, y, obj_kid.x, obj_kid.y);
        x += lengthdir_x(fly_spd, _dir);
        y += lengthdir_y(fly_spd, _dir);
    }
    
    if (x - xprevious != 0) {
        image_xscale = sign(x - xprevious);
    }
}
if (flash_timer > 0) {
    flash_timer -= 1;
    image_blend = c_red; 
} else {
    image_blend = c_white; 
}