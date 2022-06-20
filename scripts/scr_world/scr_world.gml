// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_world(){

}

#macro GH obj_gamehandler
#macro GRID obj_gamehandler.world.grid

enum WorldType {
	test,
	grassy
}
enum SpawnType_player {
	topleft,
	middle // In a square
}
function World() constructor{
	
	grid = undefined;
	//spawntype_player = SpawnType_player.topleft;
	spawntype_player = SpawnType_player.middle;
	spawntype_enemy = undefined; // <- To-do.
	function build(){
		/* TEMPORARY GRID CREATION! */
		var gridpos_x = 96; var gridpos_y = 96;
		var grid_width = 14; var grid_height = 7;
		grid = new Grid(gridpos_x, gridpos_y, grid_width, grid_height);
	}
	build(); // May call this from elsewhere
	
	function spawnFriendlies(){
		switch(spawntype_player){
			// TO-DO: More spawn types, spawn parameters
			case SpawnType_player.topleft:
			for(var xx = 0; xx < ds_list_size(global.roster); xx++){
				GH.spawnPawn(global.roster[|xx],xx,0,GH.team_player); // TO-DO: Change this during MP implemenation.
			}
			break;
			case SpawnType_player.middle: // In a spiral
			var mov_x = 0; var mov_y = 0;
			var m = 0; var mx = 0; var s = 0;
			var dir = 0;
			var mid_x = floor(GRID.getWidth()/2); var mid_y = floor(GRID.getHeight()/2); // TO-DO: Better alignment to center
			for(var xx = 0; xx < ds_list_size(global.roster); xx++){
				
				var dir_x = lengthdir_x(1,dir); var dir_y = lengthdir_y(1,dir);
				var xpos = mid_x + mov_x;
				var ypos = mid_y + mov_y;
				if(m < mx){
					m++;
				}else{
					if(s == 0){
						s = 1;
					}else{
						mx++; s = 0;
					}
					m = 0; dir+=90;
				}
				
				mov_x+=dir_x;
				mov_y+=dir_y;
				GH.spawnPawn(global.roster[|xx],xpos,ypos,GH.team_player);
				
			}
			
			break;
		}
		
	}
	
	// Events
	function atInit(){
		spawnFriendlies();
	}
	
}

enum TileSetterType {
	pattern	
}
function TileSetter() constructor{
	
	
	
	function get(){
		
	}
	
	function getFromPattern(_grid, _pattern){ // Has extra arguments for each number...
		/*
			SO CONFUSING!
		*/
		newgrid = ds_list_create(); // TO-DO: Create array instead? GH.grid is an array.
		var test = ["01000","01000","01000"];  // 5x3
		var w = string_length(_pattern[0]); var h = array_length(_pattern);
		for(var yy = 0; xx < h; yy++){
			for(var xx = 0; xx < w; xx++){
				var num = real(string_char_at(_pattern[yy],xx)); // Untested, may not be right...
				var t = argument[1+num];
				// TO-DO: Put tiles in here somehow? Wait, should tiles be initialized in here?
			}
		}
		
		ds_list_copy(_grid,newgrid); // TO-DO: Move this when there are more preparations
		ds_list_destroy(newgrid);
	}
}

global.tilesetters = ds_list_create();

var ts = new TileSetter();

ds_list_add(global.tilesetters,ts);