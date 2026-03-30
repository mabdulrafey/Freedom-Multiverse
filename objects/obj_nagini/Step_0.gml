// If the tutorial is active, freeze everything in this object
if (global.hogwarts_state.tutorial_active == true) {
    exit; 
}
// Apply gravity
vsp += grav;

// --- LEDGE AND WALL DETECTION ---

var _at_wall = place_meeting(x + (move_dir * walk_spd), y, obj_wall);

var _at_ledge = !place_meeting(x + (move_dir * (sprite_width/2 + 5)), y + 1, obj_wall);

if (_at_wall || _at_ledge) {
    move_dir *= -1; 
}

// Horizontal Movement
x += move_dir * walk_spd;

// Vertical Collision (Standard)
if (place_meeting(x, y + vsp, obj_wall)) {
    while (!place_meeting(x, y + sign(vsp), obj_wall)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;

// Update Sprite Direction
image_xscale = move_dir;