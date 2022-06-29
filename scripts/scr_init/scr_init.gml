// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_init(){

}

#macro TS 32

global.booming = false;
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

function Grid(_world,_x, _y, width, height) constructor{
	
	x = _x; y = _y;
	tiles[0,0] = 0; // Tiles array
	world = _world;
	
	 for(var xx = 0; xx < width; xx++){
		 for(var yy = 0; yy < height; yy++){
			 
			 tiles[xx,yy] = new Tile(self,xx,yy);
			 
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
	 function updateTiles(){ // This is here so that one can stop updating during pause or w/e
		 for(var yy = 0; yy < array_length(tiles[0]); yy++){
			 for(var xx = 0; xx < array_length(tiles); xx++){
				 tiles[xx,yy].update();
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
function Tile(_grid, posx, posy) constructor{
	x = posx; y = posy;
	grid = _grid;
	status = TileStatus.clear;
	memory = status;
	occupied = false;
	stander = noone;
	firetime = 0;
	bd = spr_bdtest;
	
	held_effect = noone;
	
	previewed = false;
	
	//color_default = make_color_rgb(38,179,0);
	color_default = _grid.world.getDefaultTileColor();
	color = color_default;
	
	suffix = _grid.world.getSuffix();
	
	function getSprite(){
		switch(status){
			case TileStatus.clear:
				return spr_tileempty;
			case TileStatus.test:
				return spr_fireyplot;
			case TileStatus.fire:
				return spr_tileempty;
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
		if(y == 0){
			draw_sprite_part(bd,0,0+(32*(x-1)),0,32+(32*(x-1)),32,xpos-32,ypos-35);
		}
		// NOTE: Sprites happen here.
		var u = ""; // Underscore
		if(suffix != ""){
			u+="_";
		}
		var _pillar = asset_get_index("spr_tilepillar" + u + suffix);
		var _tile = asset_get_index("spr_tile" + u + suffix);
		draw_sprite_ext(_pillar, 0, xpos, ypos,1,1,0,c_white,1); 
		draw_sprite_ext(_tile, 0, xpos, ypos,1,1,0,color,1);
		draw_sprite_ext(spr, subimg, xpos, ypos,1,1,0,c_white,1); 
		/*
		if(status == TileStatus.fire){
			instance_create_depth(xpos+TS/2-1,ypos+TS/2+8,-(ypos+TS/2+8),obj_fire)
			//draw_sprite(spr_fire,0,xpos+TS/2-1,ypos+TS/2+8);
		}
		*/
	}
	function preview(attack){
		var _col = attack.getTypeColor();
		if(_col != undefined){
			var _colto = merge_color(color_default,_col,0.5);
			color = merge_color(color,_colto,0.2); // For Griffin - Change lerp value
		}
		previewed = true;
		
	}
	function update(){
		if(!previewed){
			color = merge_color(color, color_default,0.2);
		}
		previewed = false;
		
		if(status == TileStatus.fire){
			if(held_effect == noone){
				var _x = self.xToWorld()+TS/2 - 1; var _y = self.yToWorld()+TS/2 + 8;
				held_effect = instance_create_depth(_x,_y,-_y,obj_fire)
				if(firetime == 1){
					held_effect.scale = 0.6; // <-- Magic number! Sorry!
				}
			}else{
				held_effect.firetime = firetime;	
			}
		}else{
			if(held_effect != noone){
				held_effect.onDestroy();
				held_effect = noone;
			}
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

function randomSound(array) constructor{
	sounds = array;
	function get(){
		var r = irandom_range(0,array_length(sounds)-1);
		return sounds[r];
	}
}

global.sound_water = new randomSound([sou_water1,sou_water2,sou_water3]);
global.sound_fire = new randomSound([sou_fire1,sou_fire2,sou_fire4]);
global.sound_hit = new randomSound([hurt1,hurt2,hurt3]);

function setToOil(tile){
		if(tile.status == TileStatus.clear or tile.status == TileStatus.water){
			tile.status = TileStatus.oil;
		}
	}
function setToWater(tile){
	if(tile.status != TileStatus.ruin){
		tile.status = TileStatus.water;
	}
	tile.firetime = 2;
}
function setToFire(tile, strength){
	if(strength == undefined){
		strength = 2;
	}
	if(tile.status == TileStatus.clear){
		tile.status = TileStatus.fire;
		tile.firetime = strength;
	}else if(tile.status == TileStatus.oil){
		oilFire(tile);
	}
	tile.firetime = strength;
}
function oilFire(tile){
	// Create fire here...
	obj_gamehandler.performtimer = 20;
	
	instance_create_depth(tile.xToWorld(),tile.yToWorld(),-100,obj_explosion)
	
	tile.status = TileStatus.fire;
	tile.occupied = false;
	//instance_create_depth((tile.x*TS)+GRID.x+TS/2,(tile.y*TS)+GRID.y+TS/2,0,obj_fire);
		
	if(tile.stander){
		tile.stander.status.oiled = 0;
		tile.stander.takeDamage(10);
	}
	
	var Spread = function(_tile){
		//setToFire(_tile, 2) // Bring this line back for old fire spread...
		var str = 1;
		if(_tile.status == TileStatus.fire){
			if(_tile.firetime){
				str = 2;
			}
		}
		setToFire(_tile,str);
	}
	
	for(var xx = -1; xx < 2; xx+=2){
		if(tile.x + xx >= 0 && tile.x + xx < array_length(GRID.tiles)){
			//if(tile.y + yy > 0 && tile.y + yy < array_length(GRID.tiles[0])){
				var t = GRID.tiles[tile.x+xx,tile.y];
				var timer = time_source_create(time_source_game,10,time_source_units_frames,Spread,[t],1);
				time_source_start(timer)
				//oilFire(tile);
			//}
		}
	}
	for(var yy = -1; yy < 2; yy+=2){
		if(tile.y + yy >= 0 && tile.y + yy < array_length(GRID.tiles[0])){
				var t = GRID.tiles[tile.x,tile.y+yy];
				var timer = time_source_create(time_source_game,10,time_source_units_frames,Spread,[t],1);
				time_source_start(timer)
				//oilFire(tile);
		}
	}
}

function Status() constructor{
	// Number means duration...
	oiled = 0;
	superoiled = 0;
	wet = 0;
	onfire = 0;
	weaktowater = false;
	damageboost = 0;
	
	taunt = 0;
	
	// TO-DO: Make effects either block out or interupt eachother.
	
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
		if(onfire>0) onfire--;
		if(wet>0) wet--;
		if(taunt>0) taunt--;
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
			draw_sprite_animated(spr_effect_oiled,pawn.x,pawn.y,250);
		}
		if(onfire > 0){
			draw_sprite_animated(spr_effect_onfire,pawn.x,pawn.y,100);
		}
		if(wet > 0){
			draw_sprite_animated(spr_effect_wet,pawn.x,pawn.y,100);
		}
		if(taunt > 0){
			draw_sprite_animated(spr_effect_taunt,pawn.x,pawn.y,250);
		}
		
	}
	function clear(){ // Clears all status effects...
		oiled = 0; wet = 0; onfire = 0; damageboost = 0; taunt = 0;
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
		if(sound != noone){
			if(!audio_is_playing(sound)){
				audio_play_sound(sound,0,false);
			}
		}
	}
	
}