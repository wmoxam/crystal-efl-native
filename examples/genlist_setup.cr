require "../lib/elementary"

exit if !LibElementary.elm_init ARGV.size, ARGV.empty? ? nil : ARGV.map(&.to_unsafe).to_unsafe
LibElementary.elm_policy_set(
  LibElementary::ElmPolicy::ELM_POLICY_QUIT,
  LibElementary::ElmPolicyQuit::ELM_POLICY_QUIT_LAST_WINDOW_CLOSED
)

win = LibElementary.elm_win_util_standard_add("Genlist", "Genlist Basic Tutorial")
LibElementary.elm_win_autodel_set(win, true)
# win 400x400
LibElementary.evas_object_resize(win, 400, 400)

list = LibElementary.elm_genlist_add(win)

genlist_text_get = -> (data : Void*, object : LibElementary::EvasObject, part : LibElementary::CStr) {
  puts object
  i = (data as Int32*).value
  part_str = String.new(part)
  if part_str == "elm.text"
    text = "Entry #{i}."
    p = LibC.malloc(text.bytesize + 1) as LibC::Char*
    p.copy_from(text.to_unsafe, text.bytesize + 1)
    p
  else
    nil
  end
}

genlist_content_get = -> (data : Void*, object : LibElementary::EvasObject, part : LibElementary::CStr) {
  i = (data as Int32*).value
  part_str = String.new(part)

  puts "genlist_content_get, part: #{part_str}"
  case part_str
  when "elm.swallow.icon"
    LibElementary.elm_bg_add(object).tap do |bg|
      LibElementary.elm_bg_color_set(bg, (255 * Math.cos(i / 10.to_f)).to_i, 0, i % 255)
    end
  when "elm.swallow.end"
    LibElementary.elm_bg_add(object).tap do |bg|
      LibElementary.elm_bg_color_set(bg, 0, (255 * Math.sin(i / 10.to_f)).to_i, i % 255)
    end
   else
     nil
   end
}

itc = LibElementary.elm_genlist_item_class_new()
itc.value.item_style        = "default".to_unsafe
itc.value.func.text_get     = genlist_text_get
itc.value.func.content_get  = genlist_content_get
itc.value.func.state_get    = nil
itc.value.func.del          = nil

itc2 = LibElementary.elm_genlist_item_class_new()
itc2.value.item_style        = "group_index".to_unsafe
itc2.value.func.text_get     = genlist_text_get
itc2.value.func.content_get  = genlist_content_get
itc2.value.func.state_get    = nil
itc2.value.func.del          = nil

(0..19).to_a.each do |i|
  puts i
  LibElementary.elm_genlist_item_append(
    list,
    itc,
    pointerof(i) as Void*,   # Item data
    nil,            # Parent item for trees, NULL if none
    LibElementary::ElmGenlistItemType::ELM_GENLIST_ITEM_NONE,   # Item type; this is the common one
    -> (data : Void*, object : LibElementary::EvasObject, event_info : Void*) {
      puts "IN CALLBACK"
      item = event_info as LibElementary::ElmObjectItem
      LibElementary.elm_genlist_item_item_class_update(item, data as LibElementary::ElmGenItemClass*)
    },
    itc2 as Void*                   # Data for that callback function
  )
end

puts "Yay!"

LibElementary.evas_object_size_hint_weight_set(list, LibElementary::EVAS_HINT_EXPAND, LibElementary::EVAS_HINT_EXPAND)
LibElementary.elm_win_resize_object_add(win, list)
LibElementary.evas_object_show(list)

LibElementary.evas_object_show(win)
LibElementary.elm_run
LibElementary.elm_shutdown
