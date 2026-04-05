attack_spawned = false;

// --- PHYSICS & STATS ---
hp = 100;
walk_speed = 4; // Slightly slower than Batman so the player can space properly
jump_speed = -18;
grav = 0.8;

hsp = 0;
vsp = 0;

ai_timer = 0; 
attack_range = 150; 

state = STATE.IDLE;
facing = -1; 

spr_idle = spr_joker_idle;
spr_forward = spr_joker_forward;
spr_backward = spr_joker_backward;
spr_jump = spr_joker_jump;
spr_block = spr_joker_block;
spr_punch = spr_joker_punch;
spr_kick = spr_joker_kick;
spr_hit = spr_joker_hit;

image_speed = 0.25;