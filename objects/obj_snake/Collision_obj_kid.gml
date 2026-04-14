if (global.magicland_tutorial) exit;
if (!other.invincible) {
    global.magicland_lives -= 1;
    other.invincible = true;
    other.invincible_timer = 90; 
}
