if (state == "punch" || state == "kick" || (state == "hurt" && hp > 0)) {
    state = "idle";
    attacked = false;
}