// --- CHECK COLLISION WITH JOKER ---
var _hit_joker = instance_place(x, y, obj_joker);

// If touching Joker, AND Joker didn't create this hitbox, AND Joker isn't already getting hit
if (_hit_joker != noone && creator != _hit_joker.id && _hit_joker.state != STATE.HIT) {
    
    // 1. Is Joker Blocking?
    if (_hit_joker.state == STATE.BLOCK) {
        _hit_joker.hp -= (damage / 5); // Take minor chip damage
        _hit_joker.hsp = 2 * sign(_hit_joker.x - x); // Small pushback
    } 
    // 2. Joker is NOT blocking (Clean Hit)
    else {
        _hit_joker.hp -= damage; // Take full damage
        _hit_joker.state = STATE.HIT; // Force him into the hit stun state
        _hit_joker.image_index = 0; // Start hit animation from frame 0
        _hit_joker.hsp = 6 * sign(_hit_joker.x - x); // Big pushback (Knockback)
    }
    
    // Destroy the hitbox immediately so it only hits once
    instance_destroy();
}

// --- CHECK COLLISION WITH BATMAN ---
var _hit_batman = instance_place(x, y, obj_batman);

if (_hit_batman != noone && creator != _hit_batman.id && _hit_batman.state != STATE.HIT) {
    
    if (_hit_batman.state == STATE.BLOCK) {
        _hit_batman.hp -= (damage / 5);
        _hit_batman.hsp = 2 * sign(_hit_batman.x - x);
    } else {
        _hit_batman.hp -= damage;
        _hit_batman.state = STATE.HIT;
        _hit_batman.image_index = 0;
        _hit_batman.hsp = 6 * sign(_hit_batman.x - x);
    }
    
    instance_destroy();
}