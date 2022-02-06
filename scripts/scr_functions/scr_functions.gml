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
	//show_debug_message(string(xdif) + ", " + string(ydif));
	return max(xdif, ydif);
}

function getTileBiggestDistance(tile1, tile2){ // Returns biggest tile distance between two pawns.
	var xdif = abs(tile2.x-tile1.x); var ydif = abs(tile2.y-tile1.y);
	//show_debug_message(string(xdif) + ", " + string(ydif));
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
function getRandomSpecificPawn(pawn){ // Returns random pawn of type // UNTESTED!!!
	var p = pawn.object_index;
	if(pawnExists(pawn)){
		var returns = ds_list_create();
		for(var xx = 0; xx < ds_list_size(GH.pawns); xx++){
			if(p == GH.pawns[|xx].object_index){
				//return GH.pawns[|xx];
				ds_list_add(GH.pawns[|xx]);
			}
		}
		var ret = returns[|irandom(ds_list_size(returns)-1)];
		ds_list_destroy(returns);
		return ret;
		
	}
	return noone;
}

// **
//		ARRAY
// **

function rotateArray(array, origx, origy){
	var returnarray = array_create(array_length(array[0]));
	// Rotates left
	var newx; var newy;
		for (var xx = 0; xx < array_length(array); xx++) {
			for (var yy = 0; yy < array_length(array[0]); yy++) {
				//var num = array[xx, array_length(array[0])-yy-1];
				var num = array[array_length(array)-xx-1, yy];
				returnarray[yy,xx] = num;
				
		        //newarray[i,j] = array[j, array_length(array)-i-1]
		    }
		}
		newx = origy;
		newy = array_length(array)-1-origx;
		
		return [returnarray, newx, newy];
}

// **
//		TILES
// **
function posWithinGrid(_x,_y){ // Get if tile coordinates are within grid
	if(point_in_rectangle(_x,_y,0,0,array_length(GRID.tiles)-1,array_length(GRID.tiles[0])-1)){
		return true;
	}
	return false;
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