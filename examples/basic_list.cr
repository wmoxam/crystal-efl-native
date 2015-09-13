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

list = LibElementary.elm_list_add(win)
#LibElementary.elm_list_horizontal_set(list, true) #uncoment to get horizontal
# size giving scrollbar
LibElementary.evas_object_resize(list, 320, 300)
LibElementary.elm_list_mode_set(list, LibElementary::ElmListMode::ELM_LIST_LIMIT)
LibElementary.elm_scroller_bounce_set(list, true, true)

# first item: text
LibElementary.elm_list_item_append(list, "Text item", nil, nil, nil, nil)

# second item: icon
icon = LibElementary.elm_icon_add(list)
LibElementary.elm_icon_standard_set(icon, "chat")
LibElementary.elm_list_item_append(list, "Icon item", icon, nil, nil, nil)

# third item: button
button = LibElementary.elm_button_add(list)
elm_object_text_set(button, "Button")
itembutton = LibElementary.elm_list_item_append(list, "Button item", nil, button, nil, nil)


LibElementary.elm_list_go(list)
LibElementary.evas_object_show(list)

puts "itembutton :: #{itembutton}"

$selected_counter = 0
LibElementary.evas_object_smart_callback_add(
  list,
  "selected",
  -> (data : LibElementary::EvasObject, list : LibElementary::EvasObject, event_info : Void*) {
    selected = LibElementary.elm_list_selected_item_get(list)
    if selected == data
      list_it = LibElementary.elm_list_item_prepend(list, "Item #{$selected_counter}", nil, nil, nil, nil)
      $selected_counter += 1
      LibElementary.elm_list_go(list)
      puts "Error adding item" if pointerof(list_it).null?
    end
  },
  itembutton
)

LibElementary.evas_object_show(win)
LibElementary.elm_run
LibElementary.elm_shutdown
