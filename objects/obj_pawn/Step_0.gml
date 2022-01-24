/// @description A piece of code.
// Written by Jacob.

depth = -y;

image_yscale = 1+sin(current_time/300)*0.15;

var xpos = GRID.x; var ypos = GRID.y;
if(tile != noone){ // Note: Player may appear at corner of grid?
	xpos+=tile.x*TS;ypos+=tile.y*TS;
}


// Note: Don't set position like this during animation...
if(GH.pawn_moving && GH.pawns[|GH.whoseturn].id == id){
	
}else{
	x = xpos + TS/2; y = ypos + TS/2;
}

hp = clamp(hp,0,maxhp);

if(tile.status == TileStatus.water){
	defense = 2;
}
else{
	defense = 0;
}