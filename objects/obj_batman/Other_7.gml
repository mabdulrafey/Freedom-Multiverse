if (state == STATE.PUNCH || state == STATE.KICK || state == STATE.HIT) {
    state = STATE.IDLE;
    attack_spawned = false; 
}

if (state == STATE.JUMP_PUNCH || state == STATE.JUMP_KICK) {
    state = STATE.JUMP;
    attack_spawned = false; 
}