attack_spawned = false; 

// --- PHYSICS & STATS ---
hp = 100;
walk_speed = 6;
jump_speed = -28; 
grav = 0.8;

hsp = 0; 
vsp = 0; 

// --- STATE MACHINE ENUM ---
enum STATE {
    IDLE,
    FORWARD,
    BACKWARD,
    JUMP,
    BLOCK,
    PUNCH,
    KICK,
    HIT,
    JUMP_PUNCH, 
    JUMP_KICK,
	DEAD
}

// Start in the idle state
state = STATE.IDLE;
facing = 1; // 1 = right, -1 = left

spr_idle = spr_batman_idle;
spr_forward = spr_batman_forward;
spr_backward = spr_batman_backward;
spr_jump = spr_batman_jump;
spr_block = spr_batman_block;
spr_punch = spr_batman_punch;
spr_kick = spr_batman_kick;
spr_hit = spr_batman_hit;

image_speed = 0.25; // Plays the animation at 25% speed