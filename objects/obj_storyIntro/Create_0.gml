/// obj_storyIntro – Create

// All the lines you want to show, in order
messages = [
    "Where am I? How did I end up here?",
    "Last thing I remember is stepping into this cave that was said to have mountains of gold."
];

msg_index = 0;
text = messages[msg_index];

// Lock player view while story is active
global.story_active = true;

with (obj_player) {
    view_initialized = false;
}