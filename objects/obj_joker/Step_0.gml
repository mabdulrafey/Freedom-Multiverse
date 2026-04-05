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
if (instance_exists(obj_batman) && (state == STATE.IDLE || state == STATE.FORWARD || state == STATE.BACKWARD)) {
    
    // Calculate distance and direction to Batman
    var _dist = abs(obj_batman.x - x);
    var _dir = sign(obj_batman.x - x); // Returns 1 if Batman is to the right, -1 if to the left
    
    if (_dir != 0) facing = _dir; // Always look at Batman
    
    // AI LOGIC: Move or Attack
    if (_dist > attack_range) {
        // Batman is too far, walk towards him
        state = STATE.FORWARD;
        hsp = walk_speed * facing;
    } else {
        // Batman is in range, stop walking
        hsp = 0;
        
        // Wait for the AI timer to hit 0 before attacking
        if (ai_timer <= 0) {
            var _attack_choice = irandom(2); // Pick a random number: 0, 1, or 2
            
            if (_attack_choice == 0) {
                state = STATE.PUNCH;
                image_index = 0;
            } else if (_attack_choice == 1) {
                state = STATE.KICK;
                image_index = 0;
            } else {
                state = STATE.IDLE; // Sometimes just wait menacingly
            }
            
            // Reset the timer (e.g., wait between 20 and 50 frames before attacking again)
            ai_timer = irandom_range(20, 50); 
        } else {
            // Count down the timer while waiting to attack
            state = STATE.IDLE;
            ai_timer--;
        }
    }
}
// --- DEATH CHECK ---
if (hp <= 0 && state != STATE.DEAD) {
    state = STATE.DEAD;
    hsp = 0; // Stop moving
}

// --- 3. STATE MACHINE LOGIC (Handling Sprites & Locks) ---
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
        
        // Spawn hitbox on Frame 1 (Fixed to 70 * facing and y - 100)
        if (floor(image_index) == 1 && !attack_spawned) {
            var _hitbox = instance_create_layer(x + (70 * facing), y - 100, "Instances", obj_hitbox);
            _hitbox.creator = id;
            _hitbox.damage = 10;
            attack_spawned = true;
        }
        break;

    case STATE.KICK:
        sprite_index = spr_kick;
        hsp = 0;
        
        // Spawn hitbox on Frame 2 (Fixed to 70 * facing and y - 100)
        if (floor(image_index) == 2 && !attack_spawned) {
            var _hitbox = instance_create_layer(x + (70 * facing), y - 100, "Instances", obj_hitbox);
            _hitbox.creator = id;
            _hitbox.damage = 15;
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
if (place_meeting(x, y, obj_batman)) {
    if (x <= obj_batman.x) {
        x -= 4; // Slide Joker to the left
    } else {
        x += 4; // Slide Joker to the right
    }
}

image_xscale = facing;