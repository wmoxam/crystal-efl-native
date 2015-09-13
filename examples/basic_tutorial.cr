require "../lib/elementary"

exit if !LibElementary.elm_init ARGV.size, ARGV.empty? ? nil : ARGV.map(&.to_unsafe).to_unsafe
LibElementary.elm_policy_set(
  LibElementary::ElmPolicy::ELM_POLICY_QUIT,
  LibElementary::ElmPolicyQuit::ELM_POLICY_QUIT_LAST_WINDOW_CLOSED
)

win = LibElementary.elm_win_util_standard_add("Main", "Hello, World!")
LibElementary.elm_win_autodel_set(win, true)
# win 400x400
LibElementary.evas_object_resize(win, 400, 400)
LibElementary.evas_object_show(win)
LibElementary.elm_run
LibElementary.elm_shutdown
