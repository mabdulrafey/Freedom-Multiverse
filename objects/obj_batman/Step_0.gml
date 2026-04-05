// --- 1. GET INPUTS (Player 1 - Arrows & A/S/D) ---
var _key_right = keyboard_check(vk_right);
var _key_left = keyboard_check(vk_left);
var _key_jump = keyboard_check_pressed(vk_up);
var _key_block = keyboard_check(ord("A")); 
var _key_punch = keyboard_check_pressed(ord("S"));
var _key_kick = keyboard_check_pressed(ord("D"));

// --- 2. GRAVITY & GROUND CHECK ---
var _floor_y = 1050; 
var _on_ground = (y >= _floor_y);

if (!_on_ground) {
    vsp += grav; 
} else {
    vsp = 0;
    y = _floor_y; 
}
// --- DEATH CHECK ---
if (hp <= 0 && state != STATE.DEAD) {
    state = STATE.DEAD;
    hsp = 0; // Stop moving
}

// --- 3. STATE MACHINE LOGIC ---
switch (state) {
    
    case STATE.IDLE:
        sprite_index = spr_idle;
        hsp = 0;
        
        // Transitions
        if (_key_right) { facing = 1; state = STATE.FORWARD; }
        else if (_key_left) { facing = -1; state = STATE.BACKWARD; }
        else if (_key_jump && _on_ground) { vsp = jump_speed; state = STATE.JUMP; }
        else if (_key_block) { state = STATE.BLOCK; }
        else if (_key_punch) { image_index = 0; state = STATE.PUNCH; }
        else if (_key_kick) { image_index = 0; state = STATE.KICK; }
        break;

    case STATE.FORWARD:
    case STATE.BACKWARD:
        if ((_key_right && facing == 1) || (_key_left && facing == -1)) {
            sprite_index = spr_forward;
        } else {
            sprite_index = spr_backward;
        }
        
        var _move = _key_right - _key_left;
        hsp = _move * walk_speed;
        
        if (_move == 0) state = STATE.IDLE;
        if (_key_jump && _on_ground) { vsp = jump_speed; state = STATE.JUMP; }
        if (_key_block) { state = STATE.BLOCK; }
        if (_key_punch) { image_index = 0; state = STATE.PUNCH; }
        if (_key_kick) { image_index = 0; state = STATE.KICK; }
        break;

    case STATE.JUMP:
        sprite_index = spr_jump;
        
        if (_on_ground) { state = STATE.IDLE; }
        else if (_key_punch) { image_index = 0; state = STATE.JUMP_PUNCH; }
        else if (_key_kick) { image_index = 0; state = STATE.JUMP_KICK; }
        break;

    case STATE.BLOCK:
        sprite_index = spr_block;
        hsp = 0; 
        
        if (!_key_block) state = STATE.IDLE; 
        break;

    case STATE.PUNCH:
        sprite_index = spr_punch;
        hsp = 0;
        
        if (floor(image_index) == 1 && !attack_spawned) {
            var _hitbox = instance_create_layer(x + (70 * facing), y - 100, "Instances", obj_hitbox);
            _hitbox.creator = id;
            _hitbox.damage = 4;
            attack_spawned = true; 
        }
        break;

    case STATE.KICK:
        sprite_index = spr_kick;
        hsp = 0;
        
        if (floor(image_index) == 2 && !attack_spawned) {
            var _hitbox = instance_create_layer(x + (70 * facing), y - 100, "Instances", obj_hitbox);
            _hitbox.creator = id;
            _hitbox.damage = 6;
            attack_spawned = true;
        }
        break;

    case STATE.JUMP_PUNCH:
        sprite_index = spr_punch;
        
        if (floor(image_index) == 1 && !attack_spawned) {
            var _hitbox = instance_create_layer(x + (70 * facing), y - 100, "Instances", obj_hitbox);
            _hitbox.creator = id;
            _hitbox.damage = 10;
            attack_spawned = true;
        }
        
        if (_on_ground) {
            state = STATE.IDLE; 
            attack_spawned = false;
        }
        break;

    case STATE.JUMP_KICK:
        sprite_index = spr_kick;
        
        if (floor(image_index) == 2 && !attack_spawned) {
            var _hitbox = instance_create_layer(x + (70 * facing), y - 100, "Instances", obj_hitbox);
            _hitbox.creator = id;
            _hitbox.damage = 15;
            attack_spawned = true;
        }
        
        if (_on_ground) {
            state = STATE.IDLE; 
            attack_spawned = false;
        }
        break;
    
    case STATE.HIT:
        sprite_index = spr_hit;
        
        if (abs(hsp) > 0) {
            hsp -= sign(hsp) * 0.5; 
        }
        
        break;
		
	case STATE.DEAD:
        sprite_index = spr_hit;
        
        // Stop the animation on the very last frame so they don't loop
        if (floor(image_index) >= image_number - 1) {
            image_speed = 0;
        }
        
        // Apply friction so they slide to a halt if they died from a heavy hit
        if (abs(hsp) > 0) {
            hsp -= sign(hsp) * 0.5; 
        }
        break;
}

// --- 4. APPLY MOVEMENT ---
if (hsp != 0) x += hsp;
y += vsp;

// --- 5. FIGHTING GAME PUSH-BOX (Soft Collision) ---
if (place_meeting(x, y, obj_joker)) {
    if (x <= obj_joker.x) {
        x -= 4; // Slide Batman to the left
    } else {
        x += 4; // Slide Batman to the right
    }
}

image_xscale = facing;