all:
	cc basic_tutorial.c -o basic_tutorial `pkg-config --cflags --libs elementary`
	crystal build basic_tutorial.cr -o basic_tutorial_cr
	cc basic_button.c -o basic_button `pkg-config --cflags --libs elementary`
	crystal build basic_button.cr -o basic_button_cr
	cc basic_label.c -o basic_label `pkg-config --cflags --libs elementary`
	crystal build basic_label.cr -o basic_label_cr
	cc basic_list.c -o basic_list `pkg-config --cflags --libs elementary`
	crystal build basic_list.cr -o basic_list_cr
	cc genlist_setup.c -o genlist_setup `pkg-config --cflags --libs elementary`
	crystal build genlist_setup.cr -o genlist_setup_cr

clean:
	rm basic_tutorial basic_tutorial_cr basic_button basic_button_cr basic_label basic_label_cr
	rm basic_list basic_list_cr genlist_setup
