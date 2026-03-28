current_wave = 1;
enemies_in_wave = 2;    // Starts at exactly 2 for Wave 1
enemies_spawned = 0;
spawn_timer = 60;       // 1 second between enemy spawns
wave_delay = 180;       // 3 seconds of peace between waves
state = "tutorial"; // Pauses the waves so the player can practice
ramsay_spawned = false; // Tracks if the boss has entered the battlefield

// Multiverse-safe variable!
global.north_state = "playing";