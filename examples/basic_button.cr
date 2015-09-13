require "../lib/elementary"

def elm_object_text_set(object, text)
  LibElementary.elm_object_part_text_set(object, nil, text)
end

exit if !LibElementary.elm_init ARGV.size, ARGV.empty? ? nil : ARGV.map(&.to_unsafe).to_unsafe
LibElementary.elm_policy_set(
  LibElementary::ElmPolicy::ELM_POLICY_QUIT,
  LibElementary::ElmPolicyQuit::ELM_POLICY_QUIT_LAST_WINDOW_CLOSED
)

win = LibElementary.elm_win_util_standard_add("Main", "Hello, World!")
LibElementary.elm_win_autodel_set(win, true)
# win 400x400
LibElementary.evas_object_resize(win, 400, 400)

button_text = LibElementary.elm_button_add(win)
elm_object_text_set(button_text, "Clik me")

# how a container object should resize a given child within its area
LibElementary.evas_object_size_hint_weight_set(
  button_text,
  LibElementary::EVAS_HINT_EXPAND,
  LibElementary::EVAS_HINT_EXPAND
)
# how to align an object
LibElementary.evas_object_size_hint_align_set(button_text, LibElementary::EVAS_HINT_FILL, 0.5)

LibElementary.evas_object_resize(button_text, 100, 30)
LibElementary.evas_object_show(button_text)

# Basic icon button
button_icon = LibElementary.elm_button_add(win)
icon = LibElementary.elm_icon_add(win)

# set the image file and the button as an icon
LibElementary.elm_image_file_set(icon, "icon.png", nil)
LibElementary.elm_object_part_content_set(button_icon, "icon", icon)

LibElementary.evas_object_size_hint_weight_set(
  button_icon,
  LibElementary::EVAS_HINT_EXPAND,
  LibElementary::EVAS_HINT_EXPAND
)

LibElementary.evas_object_size_hint_align_set(
  button_icon,
  LibElementary::EVAS_HINT_FILL,
  0.5
)

LibElementary.evas_object_resize(button_icon, 100, 30)
LibElementary.evas_object_move(button_icon, 110, 0)
LibElementary.evas_object_show(button_icon)

# Icon and text button
button_icon_text = LibElementary.elm_button_add(win)
icon2 = LibElementary.elm_icon_add(win)

LibElementary.elm_image_file_set(icon2, "icon.png", nil)
LibElementary.elm_object_part_content_set(button_icon_text, "icon", icon2)
elm_object_text_set(button_icon_text, "Press me")
LibElementary.evas_object_size_hint_weight_set(
  button_icon_text,
  LibElementary::EVAS_HINT_EXPAND,
  LibElementary::EVAS_HINT_EXPAND
)
LibElementary.evas_object_size_hint_align_set(
  button_icon_text,
  LibElementary::EVAS_HINT_FILL,
  0.5
)

LibElementary.evas_object_resize(button_icon_text, 100, 30)
LibElementary.evas_object_move(button_icon_text, 220, 0)
LibElementary.evas_object_show(button_icon_text)

# Clik event
LibElementary.evas_object_smart_callback_add(
  button_text,
  "clicked",
  -> (data : Void*, button : LibElementary::EvasObject, event_info : Void*) {
    elm_object_text_set(button, "Clicked!")
  },
  nil
)

# Press event
LibElementary.evas_object_smart_callback_add(
  button_icon,
  "pressed",
  -> (data : Void*, button : LibElementary::EvasObject, event_info : Void*) {
    elm_object_text_set(button, "Pressed!")
  },
  nil
)

# Unpress event
LibElementary.evas_object_smart_callback_add(
  button_icon,
  "pressed",
  -> (data : Void*, button : LibElementary::EvasObject, event_info : Void*) {
    elm_object_text_set(button, "Unpressed!")
  },
  nil
)

# Get whether the autorepeat feature is enabled.
LibElementary.elm_button_autorepeat_set(button_icon_text, true)

# Set the initial timeout before the autorepeat event is generated.
LibElementary.elm_button_autorepeat_initial_timeout_set(button_icon_text, 1.0)

# gap between two callbacks
LibElementary.elm_button_autorepeat_gap_timeout_set(button_icon_text, 0.5)

# "repeated": the user pressed the button without releasing it.
$repeat_count = 0
LibElementary.evas_object_smart_callback_add(
  button_icon_text,
  "repeated",
  -> (data : Void*, button : LibElementary::EvasObject, event_info : Void*) {
    $repeat_count += 1
    # print the number of time callback was called
    elm_object_text_set(button, "Repeat #{$repeat_count}")
  },
  nil
)

button = LibElementary.elm_button_add(win)
elm_object_text_set(button, "button")
LibElementary.evas_object_resize(button, 100, 30)
LibElementary.evas_object_move(button, 0, 40)
LibElementary.evas_object_show(button)

LibElementary.evas_object_smart_callback_add(
  button,
  "focused",
  -> (data : Void*, button : LibElementary::EvasObject, event_info : Void*) {
    elm_object_text_set(button, "Focused")
  },
  nil
)

LibElementary.evas_object_smart_callback_add(
  button,
  "unfocused",
  -> (data : Void*, button : LibElementary::EvasObject, event_info : Void*) {
    elm_object_text_set(button, "Unfocused")
  },
  nil
)

LibElementary.evas_object_show(win)
LibElementary.elm_run
LibElementary.elm_shutdown
