// --- HEALTH VARIABLES ---
hp = 3;            
iframes = 0;  

// --- SCALE SETUP ---
// We save his size here so the Step event can use it to flip him properly!
base_scale = 0.5; 
image_xscale = base_scale;
image_yscale = base_scale;

// --- PHYSICS VARIABLES ---
hspd = 0;         // Horizontal speed
vspd = 0;         // Vertical speed
grv = 0.3;        // Gravity weight
walk_speed = 4;   // Running speed
jump_speed = -9;  // Jump force (Negative goes UP)

can_shoot = true;
shoot_cooldown = 0;
is_shooting = false;