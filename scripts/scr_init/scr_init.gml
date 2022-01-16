// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_init(){

}

#macro TS 48
#macro GH obj_gamehandler
#macro GRID obj_gamehandler.grid

function Grid(x, y, width, height) constructor{
	
	pos_x = x; pos_y = y;
	tiles[0,0] = 0; // Tiles array
	
	 for(var xx = 0; xx < width; xx++){
		 for(var yy = 0; yy < height; yy++){
			 
			 tiles[xx,yy] = new Tile(xx,yy);
			 
		 }
	 }
	 tiles[2,2].occupied = true;
	 
	 function getTile(xpos, ypos){
		 return tiles[xpos,ypos];
	 }
	 function drawTiles(xpos, ypos){
		 var num = 0;
		 
		 for(var yy = 0; yy < array_length(tiles[0]); yy++){
			 for(var xx = 0; xx < array_length(tiles); xx++){
				 t = tiles[xx,yy];
				 
				 if(t.occupied){
					 //draw_set_color(c_red);
				 }
				 //draw_rectangle(xpos + xx*TS, ypos + yy*TS, xpos + (xx*TS)+TS, ypos + (yy*TS)+TS, true);
				 
				 var spr = t.getSprite();
				 var imgspd = 300;
				 var subimg = (current_time / imgspd) mod sprite_get_number(spr);
				 draw_sprite(spr, subimg, xpos + xx*TS, ypos + yy*TS);
				 //draw_text(xpos + 6 + xx*TS, ypos + 6 + yy*TS, string(t.x) + ", " + string(t.y));
				 num++;
				 
				 draw_set_color(c_white);
			 }
		 }
		 
		 
	 }
}

enum TileStatus {
	clear,
	test
}

// To-do: Have tile standard for world...
function Tile(posx, posy) constructor{
	x = posx; y = posy;
	status = TileStatus.clear;
	occupied = false;
	stander = noone;
	function getSprite(){
		switch(status){
			case TileStatus.clear:
				return spr_tiletest;
			case TileStatus.test:
				return spr_fireyplot;
		}
	}
}

enum AttackType {
	normal
}

function Action() constructor{
	
	var a = new Attack(2,AttackType.normal,spr_fireyicon);
	var b = new Attack(0,AttackType.normal,spr_fireyicon);
	centerx = 1; centery = 1;
	pattern = [ // Note: this points downwards ->
	[0,0,a,a,0,0,0],
	[0,a,0,0,a,0,0], 
	[a,0,0,0,0,a,a]
	];
	
	ability_icon_id = 0;
	
	is_distant = false;
	
	name = "Cool attack";
	description = "Does a cool thing...";
	
	function preview(pos_x, pos_y, rotation, doaction){
		var newarray = pattern;
		var newx = centerx;
		var newy = centery;
		if(rotation != 0){
			repeat(rotation){
				var results = scr_rotateArray(newarray, newx, newy);
				newarray = results[0];
				newx = results[1]; newy = results[2];
			}
		}
		
		for(var xx = 0; xx < array_length(newarray); xx++){ // Loop through pattern
			for(var yy = 0; yy < array_length(newarray[0]); yy++){
				
				var cxpos = pos_x + xx - newx; var cypos = pos_y + yy - newy;
				if(cxpos >= 0 && cxpos < array_length(GRID.tiles) && cypos >= 0 && cypos < array_length(GRID.tiles[0])){
					
					var t = GRID.tiles[cxpos,cypos];
					var attack = newarray[xx,yy];
					
					if(attack != 0){
						if(doaction){
							attack.perform(t);
						}
						
						var imgspd = 250;
						var subimg = (current_time / imgspd) mod sprite_get_number(attack.hint_icon);
						draw_sprite(attack.hint_icon,subimg,(TS*t.x)+GH.gridpos_x,(TS*t.y)+GH.gridpos_y);
					}
					
				}
				
				
			}
		}
		
	}
}

function Attack(dmg, type, icon) constructor{
	
	damage = dmg;
	attacktype = type;
	hint_icon = icon;
	
	function perform(tile){
		if(tile.status == TileStatus.test){
			tile.status = TileStatus.clear;
		}else{
			tile.status = TileStatus.test;	
		}
	}
}