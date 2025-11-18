/// obj_storyIntro – Step

var dismiss = mouse_check_button_pressed(mb_left)
           || keyboard_check_pressed(vk_space);

if (dismiss) {
    msg_index += 1;

    // If there are more messages, show the next one
    if (msg_index < array_length(messages)) {
        text = messages[msg_index];

        // when we change text, make sure the camera re-centers nicely
        with (obj_player) {
            view_initialized = false;
        }
    }
    else {
        // No more messages: unlock player and remove this object
        global.story_active = false;

        with (obj_player) {
            view_initialized = false;
        }

        instance_destroy();
    }
}