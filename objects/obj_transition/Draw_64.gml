/// @description A piece of code.
// Written by Jacob.
vsp+=0.5;
blinds+=vsp;
draw_set_color(c_black);
draw_rectangle(0,0,room_width,blinds,false);
if(blinds > room_height){
	room_goto(Room_Between);
	
}