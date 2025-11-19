// ===== obj_hud : Create =====

if (instance_number(obj_hud) > 1) {
    instance_destroy();
    exit;
}

// Knife HUD (idle + swing)
knife_sprite   = spr_knife;    // exact resource
knife_frames   = sprite_get_number(knife_sprite);
weapon_scale   = (variable_global_exists("HUD_WEAPON_SCALE") ? global.HUD_WEAPON_SCALE : 0.55);
base_margin_x  = 140;
base_margin_y  = 120;

attack_duration = 0.45;   // seconds per swing
attack_timer    = 0;
is_attacking    = false;
sub             = 0;

// Bob timer used by hud_weapon_gui_pos()
if (!variable_global_exists("hud_t")) global.hud_t = 0;

// Sync animation with player trigger
listen_for_trigger = true;

// ===== Reticle settings =====
reticle_enabled   = true;
reticle_color     = c_white;
reticle_alpha     = 0.9;
reticle_thickness = 2;     // line width (px)
reticle_length    = 8;     // each arm length (px)
reticle_gap       = 4;     // gap around center (px)
reticle_dot_radius = 0;    // set >0 to draw a small center dot


/// Fairy helper HUD state (existing stuff)
helper_visible   = false;

helper_pos_x     = display_get_gui_width() + 64;
helper_pos_y     = display_get_gui_height() * 0.35;
helper_target_x  = display_get_gui_width() - 150;
helper_speed     = 8;

// --- Fairy dialogue (existing) ---
helper_talking         = false;
helper_text            = "";
helper_text_timer      = 0;
helper_text_duration   = room_speed * 5;
helper_message_shown   = false;

// --- Hover & sway ---
helper_hover_phase = 0;     // used for sin wave
helper_hover_amp   = 8;     // how many pixels up/down

helper_sway_offset = 0;     // current horizontal offset
helper_sway_target = 0;     // target horizontal offset
helper_sway_speed  = 0.6;   // how fast it drifts toward target
helper_sway_timer  = 0;     // frames until we pick a new target


