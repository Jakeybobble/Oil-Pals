/// @description A piece of code.
// Written by Jacob.

if(keyboard_check_pressed(ord("R"))){
	room_restart();
}

if(pawn_moving){
	state = PickState.moving;
}

sou_fire=choose(sou_fire1,sou_fire2,sou_fire3,sou_fire4);
sou_water=choose(sou_water1,sou_water2,sou_water3);
/*
if(keyboard_check_pressed(vk_space)){
	var t = pawns[|whoseturn].tile;
	//t.status = TileStatus.test;
	var action = new Action();
	action.perform(t.x,t.y, AttackDir.left);
}
//draw_text(0,0,string(px) + ", " + string(py));


if(keyboard_check_pressed(vk_anykey)){
	var t = pawns[|whoseturn].tile;
	var action = new Action();
	var dir = noone;
	switch(keyboard_lastkey){
		case vk_left:
			dir = AttackDir.left;
		break;
		case vk_right:
			dir = AttackDir.right;
		break;
		case vk_up:
			dir = AttackDir.up;
		break;
		case vk_down:
			dir = AttackDir.down;
		break;
	}
	if(dir != noone) action.perform(t.x,t.y, dir);
	
}
*/



if(pawn_moving){
	var p = pawns[|whoseturn];
	if(p.moveToTileAnim(pawn_moving_x,pawn_moving_y)){
		//p.failsafe_timer = 0;
		p.setToTile(pawn_moving_x,pawn_moving_y);
		pawn_moving = false;
		state = PickState.chooseaction;
		show_debug_message("Ended.");
		
	}
}