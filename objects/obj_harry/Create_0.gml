// Damage and Invincibility Variables
is_invincible = false;
invincibility_timer = 0;
// Movement variables
hsp = 0;       
vsp = 0;       
walk_spd = 6;  
jump_spd = -15; 
grav = 0.5;    

// Scale down the massive 300x350 sprites to fit the 1080p screen better
scale_factor = 0.5; 
image_xscale = scale_factor;
image_yscale = scale_factor;

image_speed = 0.25; 

// State management
is_casting = false;

// --- AUDIO TIMERS ---
step_timer = 0;       
step_delay = 15;      