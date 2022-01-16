/// @description A piece of code.
// Written by Jacob.

if(keyboard_check_pressed(ord("O"))){
	restartGame();
}

if(pawn_moving){
	state = PickState.moving;
}

sou_fire=choose(sou_fire1,sou_fire2,sou_fire3,sou_fire4);
sou_water=choose(sou_water1,sou_water2,sou_water3);

if(pawn_moving){
	var p = pawns[|whoseturn];
	var px = (p.x div TS)- gridpos_x/TS; var py = (p.y div TS) - gridpos_y/TS;
	var tilepassing = grid.tiles[px,py];
	//show_debug_message();
	if(ds_list_find_index(tiledata_memory,tilepassing) == -1){
		//show_debug_message("Yeet");
		tilepassing.memory = tilepassing.status;
		ds_list_add(tiledata_memory,tilepassing);
	}
	p.status.duringMove(tilepassing);
	//tilepassing.status = TileStatus.fire;
	
	if(p.moveToTileAnim(pawn_moving_x,pawn_moving_y)){
		//p.failsafe_timer = 0;
		p.setToTile(pawn_moving_x,pawn_moving_y);
		pawn_moving = false;
		state = PickState.chooseaction;
		show_debug_message("Ended.");
		
	}
}

// Stall performing turn every time there is an action...
if(state == PickState.performing){
	performtimer--;
	if(performtimer <= 0){
		endTurn();
	}
}