/// enemy_hurt(inst, dmg)
/// Apply damage to a billboard enemy and handle death/feedback.
function enemy_hurt(inst, dmg) {
    if (!instance_exists(inst) || inst.is_dead) return;
    inst.hp -= max(0, dmg);
    inst.hit_flash = 8;
    if (inst.hp <= 0) {
        inst.is_dead = true;
        inst.to_destroy = true; // mark for later
    }
}
