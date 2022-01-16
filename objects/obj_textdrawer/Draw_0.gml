/// @description A piece of code.
// Written by Jacob.

draw_set_font(font_times);
draw_set_color(c_white);

count+=0.5;

var newstring = string_copy(drawstring,0,count);
draw_text(x,y,newstring);

if(keyboard_check_pressed(ord("R"))){
	game_restart();
}