// 1. Tick down the invincibility timer
if (iframes > 0) {
    iframes -= 1;
    image_blend = c_red; // Flashes red when hit!
} else {
    image_blend = c_white; // Returns to normal color
}

// 2. Check if the enemy is dead
if (hp <= 0) {
    instance_destroy(); // Deletes the enemy from the game
}

// 1. Make sure Jon Snow actually exists in the room first!
if (instance_exists(obj_snow)) {

    // Calculate the distance and angle to Jon Snow
    var _dist = point_distance(x, y, obj_snow.x, obj_snow.y);
    var _dir = point_direction(x, y, obj_snow.x, obj_snow.y);

    // Handle the attack cooldown timer
    if (can_attack == false) {
        attack_cooldown -= 1;
        if (attack_cooldown <= 0) {
            can_attack = true;     // Ready to attack again
            attack_cooldown = 60;  // Reset the timer
        }
    }

    // 2. STATE: CHASING
    if (_dist > attack_range) {

        // Calculate movement based on direction
        var _hspd = lengthdir_x(move_speed, _dir);
        var _vspd = lengthdir_y(move_speed, _dir);

        // Move the enemy
        x += _hspd;
        y += _vspd;

        // Turn on walking animation
        image_speed = 0.5; // Adjust this to match your animation speed

        // Figure out which way to face based on horizontal vs vertical movement
        if (abs(_hspd) > abs(_vspd)) { 
            // Moving mostly left or right
            if (_hspd > 0) {
                sprite_index = spr_enemy_right; // Change to your exact sprite name
                facing = "right";
            } else {
                sprite_index = spr_enemy_left;  // Change to your exact sprite name
                facing = "left";
            }
        } else { 
            // Moving mostly up or down
            if (_vspd > 0) {
                sprite_index = spr_enemy_down;  // Change to your exact sprite name
                facing = "down";
            } else {
                sprite_index = spr_enemy_up;    // Change to your exact sprite name
                facing = "up";
            }
        }
    } 
    // 3. STATE: ATTACKING
    else {
        // Stop walking animation while attacking
        image_speed = 0;
        image_index = 0;

        // Strike with the spar!
        if (can_attack == true) {
            // Spawn the spar exactly where the enemy is
            var _spar = instance_create_layer(x, y, "Instances", obj_spar);

            // Position and rotate the spar based on where the enemy is facing
            if (facing == "right") { _spar.x += 32; _spar.image_angle = 0; }
            if (facing == "left") { _spar.x -= 32; _spar.image_angle = 180; }
            if (facing == "down") { _spar.y += 32; _spar.image_angle = 270; }
            if (facing == "up") { _spar.y -= 32; _spar.image_angle = 90; }

            // Put the enemy on cooldown so they don't spam the attack
            can_attack = false;
        }
    }
} else {
    // If Jon Snow is destroyed, the enemy stands still
    image_speed = 0;
    image_index = 0;
}