@[Link("elementary")]
lib LibElementary
  EVAS_HINT_EXPAND = 1.0
  EVAS_HINT_FILL = -1.0

  alias CStr = UInt8*
  alias EvasObject = Void*
  alias EvasSmartCallback = (Void*, EvasObject, Void* -> Void)

  fun elm_init(argc : Int32, argv : CStr*) : Bool
  fun elm_run()
  fun elm_shutdown()

  fun elm_button_add(win : EvasObject) : EvasObject
  fun elm_button_autorepeat_set(button : EvasObject, autorepeat : Bool)
  fun elm_button_autorepeat_initial_timeout_set(button : EvasObject, timeout : Float64)
  fun elm_button_autorepeat_gap_timeout_set(button : EvasObject, gap : Float64)

  fun elm_icon_add(win : EvasObject) : EvasObject
  fun elm_icon_standard_set(icon : EvasObject, standard : CStr)

  fun elm_image_file_set(object : EvasObject, filename : CStr, group : CStr)

  fun elm_label_add(win : EvasObject) : EvasObject
  fun elm_label_slide_duration_set(object : EvasObject, duration : Int32)
  fun elm_label_slide_mode_set(object : EvasObject, mode : LibElementary::ElmLabelSlideMode)
  fun elm_label_slide_go(slide : EvasObject)

  fun elm_list_add(win : EvasObject) : EvasObject
  fun elm_list_go(list : EvasObject)
  fun elm_list_horizontal_set(list : EvasObject, is_horizontal : Bool)
  fun elm_list_item_append(object : EvasObject, label : CStr, icon : EvasObject, end_obj : EvasObject, cb : EvasSmartCallback, data : Void*) : EvasObject
  fun elm_list_item_prepend(object : EvasObject, label : CStr, icon : EvasObject, end_obj : EvasObject, cb : EvasSmartCallback, data : Void*) : EvasObject
  fun elm_list_mode_set(list : EvasObject, mode : ElmListMode)
  fun elm_list_selected_item_get(list : EvasObject) : EvasObject

  fun elm_object_part_content_set(object : EvasObject, part : CStr, content : EvasObject)
  fun elm_object_part_text_set(object : EvasObject, part : CStr, text : CStr)
  fun elm_object_style_set(object : EvasObject, style : CStr)

  fun elm_policy_set(policy : LibElementary::ElmPolicy, value : LibElementary::ElmPolicyQuit)

  fun elm_scroller_bounce_set(object : EvasObject, h_bounce : Bool, v_bounce : Bool)

  fun elm_win_util_standard_add(name : CStr, title : CStr) : EvasObject
  fun elm_win_autodel_set(win : EvasObject, autodel : Bool)

  fun evas_object_color_set(object : EvasObject, r : Int32, g : Int32, b : Int32, a : Int32)
  fun evas_object_move(object : EvasObject, x : Int32, y : Int32)
  fun evas_object_resize(object : EvasObject, width : Int32, height : Int32)
  fun evas_object_show(object : EvasObject)
  fun evas_object_size_hint_align_set(object : EvasObject, x : Float64, y : Float64)
  fun evas_object_size_hint_weight_set(object : EvasObject, x : Float64, y : Float64)
  fun evas_object_smart_callback_add(object : EvasObject, event : CStr, callback : EvasSmartCallback, data : Void*)

  enum ElmLabelSlideMode
    ELM_LABEL_SLIDE_MODE_NONE
    ELM_LABEL_SLIDE_MODE_AUTO
    ELM_LABEL_SLIDE_MODE_ALWAYS
  end

  enum ElmListMode
    ELM_LIST_COMPRESS = 0
    ELM_LIST_SCROLL
    ELM_LIST_LIMIT
    ELM_LIST_EXPAND
    ELM_LIST_LAST
  end

  enum ElmPolicy
    ELM_POLICY_QUIT
    ELM_POLICY_EXIT
    ELM_POLICY_THROTTLE
  end

  enum ElmPolicyQuit
    ELM_POLICY_QUIT_NONE = 0
    ELM_POLICY_QUIT_LAST_WINDOW_CLOSED
  end
end
