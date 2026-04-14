instance_destroy(other);
if (global.magicland_tutorial) exit;
hp -= 1;
instance_destroy(other);
if (hp <= 0) {
    instance_destroy();
}