if (other.hp < other.max_hp) {
    other.hp = min(other.max_hp, other.hp + pickup_amount);
}

instance_destroy();