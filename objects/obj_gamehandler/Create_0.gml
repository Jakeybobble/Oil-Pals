/// @description A piece of code.
// Written by Jacob.

depth = 99;

player_turn = true;

gridpos_x = 96;
gridpos_y = 96;

var grid_x = 13; var grid_y = 9; // ((((WIDTH!!!))))
grid = new Grid(gridpos_x, gridpos_y, grid_x, grid_y);

pawns = ds_list_create(); // All pawns, including players

var coolpawn = instance_create_depth(gridpos_x,gridpos_y, 0, pawn_chead);
coolpawn.setToTile(5,5);
ds_list_add(pawns, coolpawn);

var twopawn = instance_create_depth(gridpos_x,gridpos_y, 0, pawn_ball);
twopawn.setToTile(6,6);
ds_list_add(pawns, twopawn);

//coolpawn.tile = grid.tiles[0,0];

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
pawn_friendly = [obj_pawn,pawn_evildingo,pawn_pond];

chosen_action = noone;

performtimer = 0;
whoseturn = 0;

function setPerformTimer(num){
	if(num > performtimer){
		performtimer = num;
	}
}

function endTurn(){
	if(whoseturn+1 < ds_list_size(pawns)){
		
		whoseturn++;
	}else{
		whoseturn = 0;
		endWave();
	}
	state = PickState.choosemove;
}
function endWave(){
	for(var xx = 0; xx < ds_list_size(pawns); xx++){
		var p = pawns[|xx];
		p.status.endWave();
	}
	
	for(var xx = 0; xx < array_length(grid.tiles); xx++){
		for(var yy = 0; yy < array_length(grid.tiles[0]); yy++){
			var t = grid.tiles[xx,yy];
			/* Just a test...
			if(t.status == TileStatus.clear){
				t.status = TileStatus.fire;
			}
			*/
		}
	}
	
}
