/// @description A piece of code.
// Written by Jacob.

if(0){
	GRID.y = sin(current_time/700)*30;
	GRID.x = cos(current_time/700)*30;
}

if(keyboard_check_pressed(ord("O"))){
	restartGame();
}
if(keyboard_check_pressed(ord("N"))){
	room_goto(Room_Inbetween);
}
if(keyboard_check(ord("J")) && keyboard_check_pressed(ord("B"))){
	enemiesleft = 1337;
	nextenemy_turns = 50000;
	show_debug_message("!!!!!!!!!!!!!!!!IT'S TESTING TIME!!!!!!!!!!!!!!!!");
	nextenemy = pawn_jakey;
	spawnEnemy(8,5);
}

if(pawn_moving){
	state = PickState.moving;
}

sou_fire=choose(sou_fire1,sou_fire2,sou_fire3,sou_fire4);
sou_water=choose(sou_water1,sou_water2,sou_water3);

if(pawn_moving){
	var p = pawns[|whoseturn];
	//var px = (p.x div TS)- GRID.x/TS; var py = (p.y div TS) - GRID.y/TS;
	var px = floor((p.x-GRID.x)/TS); var py = floor((p.y-GRID.y)/TS);
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
		//show_debug_message("Ended.");
		
	}
}

// Stall performing turn every time there is an action...
if(state == PickState.performing){
	performtimer--;
	if(performtimer <= 0){
		endTurn();
	}
}