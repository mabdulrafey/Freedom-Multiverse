// If the tutorial is active, freeze everything in this object
if (global.hogwarts_state.tutorial_active == true) {
    exit; 
}
if (instance_exists(obj_harry)) {
    
    // Check how far away Harry is
    var _dist = point_distance(x, y, obj_harry.x, obj_harry.y);
    
    if (state == "patrol") {
        // We don't need manual movement code here anymore! 
        // GameMaker's path_start() is handling the flying in the background.
        
        // If Harry gets too close, break off the path!
        if (_dist < aggro_range) {
            state = "chase";
            path_end(); // Instantly stops following the drawn path
        }
    } 
    else if (state == "chase") {
        // Calculate the exact angle towards Harry and fly directly at him
        var _dir = point_direction(x, y, obj_harry.x, obj_harry.y);
        x += lengthdir_x(fly_spd, _dir);
        y += lengthdir_y(fly_spd, _dir);
    }
    
    // Face the direction it is moving (works for both Path moving and Chasing)
    if (x - xprevious != 0) {
        image_xscale = sign(x - xprevious);
    }
}