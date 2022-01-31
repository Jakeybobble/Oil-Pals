// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_functions(){
	// These are all helper functions for ai and such.

}

// **
//		PAWN RELATED FUNCTIONS
// **

function getBiggestDistance(pawn1, pawn2){ // Returns biggest tile distance between two pawns.
	var t1 = pawn1.tile; var t2 = pawn2.tile;
	var xdif = abs(t2.x-t1.x); var ydif = abs(t2.y-t1.y);
	return max(xdif, ydif);
}
function pawnExists(pawn){ // Returns true if pawn exists and is also alive
	if(instance_exists(pawn)){
		if(!pawn.dead){
			return true;
		}else{
			return false;
		}
	}
}
function getRandomSpecificPawn(pawn){ // Returns random pawn of type
	var p = pawn.object_index;
	if(pawnExists(pawn)){
		for(var xx = 0; xx < ds_list_size(GH.pawns); xx++){
			if(p == GH.pawns[|xx].object_index){
				return GH.pawns[|xx];
			}
		}
	}
	return noone;
}

// **
//		OTHER
// **

function mouseWithinBounds(){
	if(point_in_rectangle(mouse_x,mouse_y,GRID.x,GRID.y,x+(2+array_length(GRID.tiles))*TS,y+(2+array_length(GRID.tiles[0]))*TS)){
		return true;
	}
	return false;
}

function draw_sprite_animated(sprite,x,y,imgspd){
	var subimg = (current_time / imgspd) mod sprite_get_number(sprite);
	draw_sprite(sprite,subimg,x,y);
}