/// @description A piece of code.
// Written by Jacob.

level = 0;

win = false;

depth = -999;

player_turn = true;

arrowy = 0;

menutopset = 0;

instance_create_depth(-100,-100,100,obj_playerturn);

/*
var gridpos_x = 96; var gridpos_y = 96;
var grid_width = 13; var grid_height = 9;
grid = new Grid(gridpos_x, gridpos_y, grid_width, grid_height);
*/
world = new World();

pawns = ds_list_create(); // All pawns, including players


tile_memory = noone; // Last tile stood on
tiledata_memory = ds_list_create(); // All tiles changed during move

// Lists (Unused right now...)
pawn_friendly = [pawn_evildingo,pawn_pond,pawn_barrel,pawn_chead,pawn_ovenmitt,pawn_coals,pawn_ball,pawn_bboy,pawn_ebboy];

chosen_ability = noone;

performtimer = 0;
whoseturn = 0;

wave = 1;

function spawnPawn(instance, xpos, ypos, is_player){
	var t = GRID.tiles[xpos,ypos];
	var tospawn = instance_create_depth(t.xToWorld()+TS/2,t.yToWorld()+TS/2, 0, instance); // Evil
	tospawn.setToTile(xpos,ypos);
	tospawn.is_player = is_player;
	ds_list_add(pawns, tospawn);
	reSort();
}

/// @description Resorts pawns list and makes sure to bring whoseturn with it...
function reSort(){ // Oh yeah, the sorting algorithm this uses is a 'Bubble sort'.
	var n = ds_list_size(pawns);
	for(var i = 0; i < n; i++){
		for(var j = i + 1; j < n; j++){
			if(-pawns[|i].spd > -pawns[|j].spd){
				var temp = pawns[|i];
				pawns[|i] = pawns[|j];
				pawns[|j] = temp;
			}
		}
	}
	/*
	for(var xx = 0; xx < n; xx++){
		show_debug_message(pawns[|xx].name + " has speed " + string(pawns[|xx].spd) + ".");
	}
	*/
}

function nextTurn(){
	for(var xx = 0; xx < ds_list_size(pawns); xx++){
		
	}
}

world.atInit(); // <- Here's the world init!

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

function setPerformTimer(num){
	if(num > performtimer){
		performtimer = num;
	}
}

heyos = 0;

function startTurn(){
	var p = pawns[|whoseturn];
	p.onStartTurn();
	//show_debug_message(p.name + "'s turn...");
	/*
	if(p.tile.status = TileStatus.oil){
		p.status.oiled ++;
	}
	*/
}

function endTurn(){
	var p = pawns[|whoseturn];
	p.onEndTurn(); // Run player end turn event.
	p.status.endTurn(); // NOTE: Status ends AFTER player end turn.
	p.hasplayed = true;
	
	var endwave = true;
	for(var xx = 0; xx < ds_list_size(pawns); xx++){
		if(!pawns[|xx].hasplayed){
			whoseturn = xx;
			endwave = false;
			break;
		}
	}
	if(endwave){
		whoseturn = 0;
		wave++;
		endWave();
		
	}
	/*
	if(whoseturn+1 < ds_list_size(pawns)){
		
		whoseturn++;
	}else{
		whoseturn = 0;
		endWave();
	}
	*/
	
	var enemiesalive = 0;
	var playersalive = 0;
	
	if(p.tile.status == TileStatus.oil){
		if(p.status.oiled  <= 2){
			p.status.oiled = 2;
		}
	}
	
	for(var xx = 0; xx < ds_list_size(pawns); xx++){
		var p = pawns[|xx];
		
		if(!p.dead){
			if(p.is_player){
				playersalive++;
			}else{
				enemiesalive++;
			}
		}
		p.animating = false;
		p.anim.onEnd();
	}
	
	for(var xx = 0; xx < array_length(GRID.tiles); xx++){
		for(var yy = 0; yy < array_length(GRID.tiles[0]); yy++){
			/*
			var t = GRID.tiles[xx,yy];
			
			if(t.status == TileStatus.ruin){
				if(t.stander){
					if(!t.stander.dead){
						t.stander.takeDamage(999);
					}
				}
			}
			*/
			
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
					//spawnPawn(ttt.x,ttt.y,false); // Spawn enemy
					spawnPawn(nextenemy,ttt.x,ttt.y,false);
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

startTurn();

enemiesleft = global.enemymax;
nextenemy_turns = 0;
global.turnspace = 4;
nextenemy = pawn_tinman;
enemylist = [pawn_tinman,pawn_oilball,pawn_magmaball,pawn_sniper,pawn_evilbarrel];

/*
function spawnEnemy(xpos, ypos){
	var tospawn = instance_create_depth(-100,-100, 0, nextenemy); // Evil
	tospawn.setToTile(xpos,ypos);
	tospawn.is_player = false;
	ds_list_add(pawns, tospawn);
}
*/

function endWave(){
	
	// For each player...
	for(var xx = 0; xx < ds_list_size(pawns); xx++){
		var p = pawns[|xx];
		p.hasplayed = false;
		
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
	for(var xx = 0; xx < array_length(GRID.tiles); xx++){
		for(var yy = 0; yy < array_length(GRID.tiles[0]); yy++){
			var t = GRID.tiles[xx,yy];
			
			//t.update(); // May be needed in the future.
			
			if(t.status == TileStatus.fire){
				if(t.firetime > 0){
					t.firetime--;
				}else{
					t.firetime = 0;
					t.status = TileStatus.clear;
				}
			}
			if(t.status == TileStatus.water){
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
					spawnPawn(nextenemy,ttt.x,ttt.y,false);
					break;
				}
				tries--;
			}
		}
	}
	
	
}