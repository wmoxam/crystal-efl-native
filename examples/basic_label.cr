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

# text_label
label_text = LibElementary.elm_label_add(win)

elm_object_text_set(label_text,"My label")
LibElementary.evas_object_color_set(label_text, 0, 0, 255, 255)

LibElementary.evas_object_resize(label_text, 90, 30)
LibElementary.evas_object_show(label_text)

# sliding text
label_slide = LibElementary.elm_label_add(win)

elm_object_text_set(label_slide, "<b>Some long bold text for our label_slide, that is long but</b><b>not too long.</b>");

LibElementary.elm_object_style_set(label_slide, "slide_bounce")
LibElementary.elm_label_slide_duration_set(label_slide, 3)
LibElementary.elm_label_slide_mode_set(label_slide, LibElementary::ElmLabelSlideMode::ELM_LABEL_SLIDE_MODE_ALWAYS)

LibElementary.elm_label_slide_go(label_slide)

LibElementary.evas_object_resize(label_slide, 200, 15)
LibElementary.evas_object_move(label_slide,0,40)
LibElementary.evas_object_show(label_slide)

LibElementary.evas_object_show(win)
LibElementary.elm_run
LibElementary.elm_shutdown
