/// @description A piece of code.
// Written by Jacob.

is_player = true;
name = "Dingo";
hp = 5;
spd = 5;

faceicon = spr_testface2;

tile = noone;

/// Set tile position of a pawn, also updates tile.
/// Animations will be set in another function which runs before this.
function setToTile(xpos, ypos){
	var t = obj_gamehandler.grid.tiles[xpos,ypos]; // Tile to set to
	if(tile != noone){
		tile.occupied = false;
		tile.stander = noone;
	}
	tile = t;
	t.occupied = true;
	t.stander = self;
	
}

failsafe_timer = 0;
function moveToTileAnim(xpos, ypos){
	var t = obj_gamehandler.grid.tiles[xpos,ypos];
	failsafe_timer++;
	if(failsafe_timer > 500){
		failsafe_timer = 0;
		return true;
	}
	
	// Do anim stuff
	// If close to position, return true, otherwise, return false.
	var mspd = 4;
	var xto = obj_gamehandler.gridpos_x + (TS/2) + t.x * TS;
	var yto = obj_gamehandler.gridpos_y + (TS/2) + t.y * TS;
	var dir = point_direction(x,y,xto,yto);
	var xang = lengthdir_x(1, dir); var yang = lengthdir_y(1, dir);
	x+=xang*mspd; y+=yang*mspd;
	//show_debug_message("Yeet");
	//show_debug_message(point_distance(x,y,xto,yto));
	if(point_distance(x,y,xto,yto) < mspd){
		failsafe_timer = 0;
		return true;
	}else{
		return false;	
	}
	
}

actions = ds_list_create();