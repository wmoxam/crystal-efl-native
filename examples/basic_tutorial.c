#include <Elementary.h>

int
main(int argc, char **argv)
{
  Evas_Object *win;

  if (!elm_init(argc, argv)) return -1;

  elm_policy_set(ELM_POLICY_QUIT, ELM_POLICY_QUIT_LAST_WINDOW_CLOSED);

  win = elm_win_util_standard_add("Main", "Hello, World!");
  elm_win_autodel_set(win, EINA_TRUE);
  //win 400x400
  evas_object_resize(win, 400, 400);

  /*basic tutorial code*/

  evas_object_show(win);

  elm_run();
  elm_shutdown();
  return 0;
}
