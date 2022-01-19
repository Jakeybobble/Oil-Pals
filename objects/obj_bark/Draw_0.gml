/// @description A piece of code.
// Written by Jacob.

// To-do because I was too lazy: Typewriter and longer text = higher span
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_font(font_squarecakes);
draw_set_color(c_black);
var xpos = x+sin(current_time/50)*4;
draw_text(xpos-1,y+1,text);
draw_set_color(c_white);
draw_text(xpos,y,text);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
timealive--;
if(timealive < 0){
	instance_destroy(self);
}
