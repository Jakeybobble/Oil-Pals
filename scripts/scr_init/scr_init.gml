// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_init(){

}

#macro TS 48
#macro GH obj_gamehandler
#macro GRID obj_gamehandler.grid

global.enemymax = 3;
global.turnspace = 4;
global.friendlies = [pawn_evildingo,pawn_chead,pawn_barrel,pawn_pond,pawn_ball,pawn_bboy,pawn_ebboy,pawn_coals,pawn_ovenmitt];
global.roster = ds_list_create();
global.level = 0;


function restartGame(){
	ds_list_clear(global.roster);
	global.enemymax = 3;
	global.turnspace = 4;
	global.level = 0;
	game_restart();
}

function Grid(_x, _y, width, height) constructor{
	
	x = _x; y = _y;
	tiles[0,0] = 0; // Tiles array
	
	 for(var xx = 0; xx < width; xx++){
		 for(var yy = 0; yy < height; yy++){
			 
			 tiles[xx,yy] = new Tile(xx,yy);
			 
		 }
	 }
	 
	 function getWidth(){
		 return(array_length(tiles));
	 }
	 function getHeight(){
		 return(array_length(tiles[0]));
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
				 
				 t.drawTile(xpos + xx*TS, ypos + yy*TS);
				 /* This code was put into the function above...
				 var spr = t.getSprite();
				 var imgspd = 300;
				 var subimg = (current_time / imgspd) mod sprite_get_number(spr);
				 draw_sprite(spr, subimg, xpos + xx*TS, ypos + yy*TS);
				 */
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
	water,
	ruin
}

// To-do: Have tile standard for world...
function Tile(posx, posy) constructor{
	x = posx; y = posy;
	status = TileStatus.clear;
	memory = status;
	occupied = false;
	stander = noone;
	firetime = 0;
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
			case TileStatus.ruin:
				return spr_deadgrass;
		}
	}
	function drawTile(xpos,ypos){
		
		var spr = getSprite();
		var imgspd = 300;
		var subimg = (current_time / imgspd) mod sprite_get_number(spr);
		draw_sprite(spr, subimg, xpos, ypos);
		if(status == TileStatus.ruin){
			var firescale = 1+sin(current_time/200)*0.5;
			draw_sprite_ext(spr_coolfire,0,xpos+TS/2,ypos+TS/2,1,firescale,0,c_white,1);
			
		}
	}
	function update(){
		// In case things break or something...
		if(stander == noone){ // TO-DO: Add more conditions here
			occupied = false;
		}
	}
	function xToWorld(){
		return GRID.x + x*TS;
	}
	function yToWorld(){
		return GRID.y + y*TS;
	}
}

function xToWorld(_x){
	return GRID.x + _x*TS;
}
function yToWorld(_y){
	return GRID.y + _y*TS;
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
global.sound_fire = new randomSound([sou_fire1,sou_fire2,sou_fire3]);
global.sound_hit = new randomSound([hurt1,hurt2,hurt3]);

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
	
	sound = noone;
	sound_israndom = false;
	
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
							switch(attack.attacktype){
								case AttackType.fire:
									audio_play_sound(global.sound_fire.get(),1,0);
									var atkc = c_red;
									break;
								case AttackType.water:
									audio_play_sound(global.sound_water.get(),1,0);
									var atkc = c_aqua;
									break;
								case AttackType.oil:
									audio_play_sound(global.sound_water.get(),1,0);
									var atkc = c_purple;
									break;
								case AttackType.normal:
									if(attack.hint_icon != spr_specialicon){
										audio_play_sound(global.sound_hit.get(),1,0);	
									}
									var atkc = c_purple;
									break;
							}
							instance_create_depth((TS*t.x)+GRID.x,(TS*t.y)+GRID.y,-100,obj_hitfx);
						}
						
						var imgspd = 250;
						var subimg = (current_time / imgspd) mod sprite_get_number(attack.hint_icon);
						draw_sprite(attack.hint_icon,subimg,(TS*t.x)+GRID.x,(TS*t.y)+GRID.y);
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
		tile.stander.takeDamage(1); // Just default...
	}
}

function setToOil(tile){
		if(tile.status == TileStatus.clear or tile.status == TileStatus.water){
			tile.status = TileStatus.oil;
		}
	}
function setToWater(tile){
	tile.status = TileStatus.water;
	tile.firetime = 2;
}
function setToFire(tile){
	if(tile.status == TileStatus.clear){
		tile.status = TileStatus.fire;
		tile.firetime = 2;
	}else if(tile.status == TileStatus.oil){
		// Create fire here...
		tile.status = TileStatus.ruin;
		tile.occupied = true;
		//instance_create_depth((tile.x*TS)+GRID.x+TS/2,(tile.y*TS)+GRID.y+TS/2,0,obj_fire);
		/*
		if(tile.stander){
			tile.stander.takeDamage(999);
		}
		*/
		for(var xx = -1; xx < 2; xx+=2){
			if(tile.x + xx >= 0 && tile.x + xx < array_length(GRID.tiles)){
					//if(tile.y + yy > 0 && tile.y + yy < array_length(GRID.tiles[0])){
						var t = GRID.tiles[tile.x+xx,tile.y];
						setToFire(t);
						//oilFire(tile);
					//}
				}
			for(var yy = -1; yy < 2; yy+=2){
				if(tile.y + yy >= 0 && tile.y + yy < array_length(GRID.tiles[0])){
						var t = GRID.tiles[tile.x,tile.y+yy];
						setToFire(t);
						//oilFire(tile);
				}
			}
		}
		
	}
}
function oilFire(tile){
	//setToFire(tile);
	tile.status = TileStatus.ruin;
	
}

function Status() constructor{
	// Number means duration...
	oiled = 0;
	superoiled = 0;
	weaktowater = false;
	damageboost = 0;
	
	function affectDamage(dmg, type){
		var returndmg = dmg;
		if(oiled){
			returndmg*=2;
		}
		if(type == AttackType.water && weaktowater){
			returndmg*=2;
		}
		return returndmg;
	}
	function endWave(){
		if(oiled>0) oiled--;
	}
	function endTurn(){
		if(damageboost>0) damageboost--;
	}
	
	function duringMove(tile){
		//tile.status = TileStatus.fire;
		if(superoiled>0){
			setToOil(tile);
		}
		
	}
	function endTurn(){
		// TO-DO...
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

enum BarkTypes {
	waiting,
	death,
	damage
}

function Barks() constructor{ // Yes, with an S.
	waiting = ["Dang, I'm waiting..."];
	death = ["Dang, I'm dead..."];
	damage = ["Dang, I'm being damaged..."];
	sound = noone;
	
	function bark(_type, _x, _y){
		var b = instance_create_depth(_x,_y,-600,obj_bark);
		var which = noone;
		switch(_type){
			case BarkTypes.waiting:
				which = waiting;
			break;
			case BarkTypes.death:
				which = death;
			break;
			case BarkTypes.damage:
				which = damage;
			break;
		}
		if(_type != noone){
			var rand = irandom(array_length(which)-1);
			b.text = which[rand];
		}
		if(sound != noone){
			if(!audio_is_playing(sound)){
				audio_play_sound(sound,0,false);
			}
		}
	}
	
	function freebark(_text,_x,_y){
		var b = instance_create_depth(_x,_y,-600,obj_bark);
		b.text = _text;
	}
	
}