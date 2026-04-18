if (state == "attack_kick" || state == "attack_punch" || (state == "hurt" && hp > 0)) {
    state = "idle";
}