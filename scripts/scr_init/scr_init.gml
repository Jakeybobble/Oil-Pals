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
	test,
	fire,
	oil,
	water
}

// To-do: Have tile standard for world...
function Tile(posx, posy) constructor{
	x = posx; y = posy;
	status = TileStatus.clear;
	memory = status;
	occupied = false;
	stander = noone;
	function getSprite(){
		switch(status){
			case TileStatus.clear:
				return spr_tiletest;
			case TileStatus.test:
				return spr_fireyplot;
			case TileStatus.fire:
				return spr_fireyplot;
			case TileStatus.water:
				return spr_tilewet;
			case TileStatus.oil:
				return spr_oilyplot;
		}
	}
	function update(){
		// In case things break or something...
		if(stander == noone){ // TO-DO: Add more conditions here
			occupied = false;
		}
	}
}

enum AttackType {
	normal,
	oil,
	fire,
	water
}

function randomSound(array) constructor{
	sounds = array;
	function get(){
		var r = irandom_range(0,array_length(sounds)-1);
		return sounds[r];
	}
}

global.sound_water = new randomSound([sou_water1,sou_water2,sou_water3]);

function Action() constructor{
	
	var a = new Attack(2,AttackType.normal,spr_fireyicon);
	var b = new Attack(0,AttackType.normal,spr_fireyicon);
	centerx = 0; centery = 0;
	pattern = [ // Note: this points downwards ->
	[0,0,a,a,0,0,0],
	[0,a,0,0,a,0,0], 
	[a,0,0,0,0,a,a]
	];
	
	ability_icon_id = 0;
	
	is_distant = false;
	
	sound = global.sound_water;
	sound_israndom = true;
	
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
		
		if(doaction){
			if(sound != noone){
				var snd = sound;
				if(sound_israndom){
					snd = sound.get();
					show_debug_message(snd);
				}
				audio_play_sound(snd,1,false);
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
		tile.stander.takeDamage(1); // Just default...
	}
}

function setToOil(tile){
		if(tile.status == TileStatus.clear or tile.status == TileStatus.water){
			tile.status = TileStatus.oil;
		}
	}
function setToWater(tile){
	if(tile.status == TileStatus.clear or tile.status == TileStatus.fire){
		tile.status = TileStatus.water;
	}
}
function setToFire(tile){
	if(tile.status == TileStatus.clear or tile.status == TileStatus.oil){
		tile.status = TileStatus.fire;
	}
}

function Status() constructor{
	// Number means duration...
	oiled = 0;
	
	function affectDamage(dmg){
		var returndmg = dmg;
		if(oiled){
			returndmg*=2;
		}
		return returndmg;
	}
	function endWave(){
		if(oiled>0) oiled--;
	}
	
	function duringMove(tile){
		//tile.status = TileStatus.fire;
		if(oiled>0){
			tile.status = TileStatus.oil;
		}
	}
	function onMove(){
		
	}
	
	function drawStatus(pawn){
		if(oiled > 0){
			var imgspd = 250;
			var subimg = (current_time / imgspd) mod sprite_get_number(spr_effect_oiled);
			draw_sprite(spr_effect_oiled,subimg,pawn.x,pawn.y);
		}
		
	}
	
}

function flyingNumber(_x,_y,num){
	var inst = instance_create_depth(_x,_y,-300,obj_flyingnumbers);
	inst.number = num;
}