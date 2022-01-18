/// @description A piece of code.
// Written by Jacob.

level = 0;

depth = 99;

player_turn = true;

arrowy = 0;

var gridpos_x = 96; var gridpos_y = 96;
var grid_width = 13; var grid_height = 9;
grid = new Grid(gridpos_x, gridpos_y, grid_width, grid_height);

pawns = ds_list_create(); // All pawns, including players


for(var xx = 0; xx < ds_list_size(global.roster); xx++){
	var newpawn = instance_create_depth(GRID.x,GRID.y, 0, global.roster[|xx]);
	newpawn.setToTile(xx,0);
	ds_list_add(pawns,newpawn);
}

pawn_moving = false;
pawn_moving_x = 0; pawn_moving_y = 0; // Tile moving to

enum PickState {
	choosemove,
	moving,
	chooseaction,
	chooseactionposition,
	performing
	
}
state = PickState.choosemove;

tile_memory = noone; // Last tile stood on
tiledata_memory = ds_list_create(); // All tiles changed during move

// Lists
pawn_friendly = [pawn_evildingo,pawn_pond,pawn_barrel,pawn_chead,pawn_ovenmitt,pawn_coals,pawn_ball,pawn_bboy,pawn_ebboy];

chosen_action = noone;

performtimer = 0;
whoseturn = 0;

function setPerformTimer(num){
	if(num > performtimer){
		performtimer = num;
	}
}

function startTurn(){
	var p = pawns[|whoseturn];
	if(p.tile.status = TileStatus.oil){
		p.status.oiled ++;
	}
}

function endTurn(){
	var p = pawns[|whoseturn];
	p.onEndTurn(); // Run player end turn event.
	
	if(whoseturn+1 < ds_list_size(pawns)){
		
		whoseturn++;
	}else{
		whoseturn = 0;
		endWave();
	}
	
	var enemiesalive = 0;
	var playersalive = 0;
	
	for(var xx = 0; xx < ds_list_size(pawns); xx++){
		var p = pawns[|xx];
		
		if(!p.dead){
			if(p.is_player){
				playersalive++;
			}else{
				enemiesalive++;
			}
		}
		
	}
	
	for(var xx = 0; xx < array_length(grid.tiles); xx++){
		for(var yy = 0; yy < array_length(grid.tiles[0]); yy++){
			var t = grid.tiles[xx,yy];
			
			if(t.status == TileStatus.ruin){
				if(t.stander){
					if(!t.stander.dead){
						t.stander.takeDamage(999);
					}
				}
			}
			
			//t.update();
			/*
			if(t.status == TileStatus.clear){
				t.status = TileStatus.fire;
			}
			*/
		}
	}
	
	
	if(playersalive == 0){
		// GAME OVER
		//instance_create_depth(0,0,-600,obj_transition);
		room_goto(Room_Between);
	}else if(enemiesalive == 0){
		// WIN
		if(enemiesleft == 0){
			// DO WIN HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!
			global.enemymax += 2;
			if(global.turnspace > 1){
				global.turnspace--;
			}
			global.level++;
			
			if(ds_list_size(global.roster) < 9){
				room_goto(Room_Inbetween);
			}else{
				room_restart();	
			}
			
			
		}
		else{
			enemiesleft--;
			var tries = 100;
			while(tries > 0){
				var randx = irandom_range(0,array_length(GRID.tiles)-1);
				var randy = irandom_range(0,array_length(GRID.tiles[0])-1);
				var ttt = GRID.tiles[randx,randy];
				if(!ttt.occupied){
					ttt.status = TileStatus.clear;
					nextenemy = enemylist[irandom_range(0,array_length(enemylist)-1)];
					spawnEnemy(ttt.x,ttt.y);
					break;
				}
				tries--;
			}
		}
		//instance_create_depth(0,0,-600,obj_transition);
	}
	
	startTurn();
	state = PickState.choosemove;
}

enemiesleft = global.enemymax;
nextenemy_turns = 0;
global.turnspace = 4;
nextenemy = pawn_tinman;
enemylist = [pawn_tinman,pawn_oilball,pawn_magmaball,pawn_sniper,pawn_evilbarrel];

function spawnEnemy(xpos, ypos){
	var tospawn = instance_create_depth(GRID.x,GRID.y, 0, nextenemy); // Evil
	tospawn.setToTile(xpos,ypos);
	tospawn.is_player = false;
	ds_list_add(pawns, tospawn);
}

function endWave(){
	
	// For each player...
	for(var xx = 0; xx < ds_list_size(pawns); xx++){
		var p = pawns[|xx];
		
		if(p.tile.status == TileStatus.fire){
			if(p.fireimmunity){
				
			}else{
				p.takeDamage(1);
			}
			
		}
		
		p.onEndWave();
		p.status.endWave();
		
	}
	
	// For each tile...
	for(var xx = 0; xx < array_length(grid.tiles); xx++){
		for(var yy = 0; yy < array_length(grid.tiles[0]); yy++){
			var t = grid.tiles[xx,yy];
			
			//t.update(); // May be needed in the future.
			
			if(t.status == TileStatus.fire){
				if(t.firetime > 0){
					t.firetime--;
				}else{
					t.firetime = 0;
					t.status = TileStatus.clear;
				}
			}
		}
	}
	
	if(nextenemy_turns > 0){
		nextenemy_turns--;
	}else{
		nextenemy_turns = global.turnspace;
		if(enemiesleft > 0){
			enemiesleft--;
			var tries = 100;
			while(tries > 0){
				var randx = irandom_range(0,array_length(GRID.tiles)-1);
				var randy = irandom_range(0,array_length(GRID.tiles[0])-1);
				var ttt = GRID.tiles[randx,randy];
				if(!ttt.occupied){
					ttt.status = TileStatus.clear;
					nextenemy = enemylist[irandom_range(0,array_length(enemylist)-1)];
					spawnEnemy(ttt.x,ttt.y);
					break;
				}
				tries--;
			}
		}
	}
	
	
}