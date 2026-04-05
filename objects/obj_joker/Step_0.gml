// --- 1. GRAVITY & GROUND CHECK ---
var _floor_y = 1050; 
var _on_ground = (y >= _floor_y);

if (!_on_ground) {
    vsp += grav;
} else {
    vsp = 0;
    y = _floor_y;
}

// --- 2. THE AI BRAIN ---
// Safety check: Only proceed if your manager exists
if (instance_exists(obj_gotham_manager)) {
    
    // Only let the AI "think" if the Tutorial is over and he isn't dead
    if (!obj_gotham_manager.tutorial_mode && state != STATE.DEAD) {
        if (instance_exists(obj_batman) && (state == STATE.IDLE || state == STATE.FORWARD || state == STATE.BACKWARD)) {
            
            var _dist = abs(obj_batman.x - x);
            var _dir = sign(obj_batman.x - x); 
            
            if (_dir != 0) facing = _dir; 
            
            if (_dist > attack_range) {
                state = STATE.FORWARD;
                hsp = walk_speed * facing;
            } else {
                hsp = 0;
                if (ai_timer <= 0) {
                    var _attack_choice = irandom(2); 
                    if (_attack_choice == 0) {
                        state = STATE.PUNCH;
                        image_index = 0;
                    } else if (_attack_choice == 1) {
                        state = STATE.KICK;
                        image_index = 0;
                    } else {
                        state = STATE.IDLE; 
                    }
                    ai_timer = irandom_range(20, 50); 
                } else {
                    state = STATE.IDLE;
                    ai_timer--;
                }
            }
        }
    } 
    // If we ARE in tutorial mode, stay still
    else if (obj_gotham_manager.tutorial_mode) {
        if (state != STATE.HIT) {
            hsp = 0;
            state = STATE.IDLE;
        }
    }
}

// --- 3. DEATH CHECK ---
if (hp <= 0 && state != STATE.DEAD) {
    state = STATE.DEAD;
    hsp = 0; 
}

// --- 4. STATE MACHINE LOGIC ---
switch (state) {
    case STATE.IDLE:
        sprite_index = spr_idle;
        hsp = 0;
        break;

    case STATE.FORWARD:
        sprite_index = spr_forward;
        break;

    case STATE.BACKWARD:
        sprite_index = spr_backward;
        break;

    case STATE.PUNCH:
        sprite_index = spr_punch;
        hsp = 0;
        
        // Balanced damage: 4
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
        
        // Balanced damage: 6
        if (floor(image_index) == 2 && !attack_spawned) {
            var _hitbox = instance_create_layer(x + (70 * facing), y - 100, "Instances", obj_hitbox);
            _hitbox.creator = id;
            _hitbox.damage = 6;
            attack_spawned = true;
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
        if (floor(image_index) >= image_number - 1) {
            image_speed = 0;
        }
        if (abs(hsp) > 0) {
            hsp -= sign(hsp) * 0.5; 
        }
        break;
}

// --- 5. APPLY MOVEMENT ---
if (hsp != 0) x += hsp;
y += vsp;

// --- 6. FIGHTING GAME PUSH-BOX (Soft Collision) ---
if (place_meeting(x, y, obj_batman)) {
    if (x <= obj_batman.x) {
        x -= 4; 
    } else {
        x += 4; 
    }
}

image_xscale = facing;