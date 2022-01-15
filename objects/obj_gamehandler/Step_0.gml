/// @description A piece of code.
// Written by Jacob.

if(keyboard_check_pressed(vk_space)){
	var thing = grid.tiles[3,3].stander;
}
//draw_text(0,0,string(px) + ", " + string(py));

if(keyboard_check_pressed(ord("R"))){
	room_restart();
}

if(pawn_moving){
	var p = pawns[|whoseturn];
	if(p.moveToTileAnim(pawn_moving_x,pawn_moving_y)){
		//p.failsafe_timer = 0;
		p.setToTile(pawn_moving_x,pawn_moving_y);
		pawn_moving = false;
		show_debug_message("Ended.");
		
	}
}