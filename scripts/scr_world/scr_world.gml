// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_world(){

}

enum WorldType {
	test,
	grassy
}
function World() constructor{
	
	grid = undefined;
	function build(){
		
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