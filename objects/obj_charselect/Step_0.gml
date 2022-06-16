/// @description A piece of code.
// Written by Jacob.

if(keyboard_check_pressed(ord("G"))){
	ds_list_add(global.roster,pawn_griffin);
	room_goto(Room1);
}
if(keyboard_check_pressed(ord("J"))){
	ds_list_add(global.roster,pawn_jakey);
	room_goto(Room1);
}