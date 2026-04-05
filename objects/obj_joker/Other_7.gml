// Return to IDLE after an attack finishes
if (state == STATE.PUNCH || state == STATE.KICK || state == STATE.HIT) {
    state = STATE.IDLE;
    attack_spawned = false; // This reset is crucial so Joker can attack more than once!
}