// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_abilities(){

}

enum AttackCondition {
	mustIncludePawn,
	mustBeFree
}
enum AttackType {
	normal,
	oil,
	fire,
	water
}
function Attack(_type,icon) constructor{
	
	type = _type;
	hint_icon = icon;
	condition = noone;
	color = undefined;
	
	function perform(tile,caster){
		if(tile.stander != noone){
			tile.stander.takeDamage(1); // Just default...
		}
		return true; // If this returns false, the attack cannot be performed.
	}
	function getTypeColor(){
		switch(type){
			case AttackType.normal:
				return undefined;
				break;
			case AttackType.oil:
				return #4c2f9a;
				break;
			case AttackType.fire:
				return #ff807b; // <--- Change this
				break;
			default:
				return undefined;
				break;
		}
	}
	function returnIcon(tile){
		switch(type){
			case AttackType.fire:
				switch(tile.status){
					case TileStatus.oil:
						return spr_boomyicon;
					break;
					default:
						return hint_icon;
					break;
				}
			break;
			case AttackType.oil:
				switch(tile.status){
					case TileStatus.fire:
						return spr_canticon;
					break;
					default:
						return hint_icon;
					break;
				}
			break;
			default:
				return hint_icon;
			break;
		}
	}
}

enum AttackOrder { // Attack will be dealt...
	instant, // ...before PickState.performing
	onDemand, // ...when called in PickState.performing. Will not default to post.
	post // ...at the end of PickState.performing
}

function Ability() constructor{
	centerx = 0; centery = 0;
	sound = undefined;
	pattern = [0];
	icon_id = 0;
	is_distant = false;
	name = "Cool Ability";
	description = "Does a cool thing...";
	
	ordertype = AttackOrder.instant;
	
	tier = 0;
	upgradesto = undefined;
	
	function getTiles(pos_x, pos_y, dir, pawn){
		// Returns false if action conditions aren't met.
		
		var returns = [];
		
		if(!is_distant){
			pos_x = pawn.tile.x; pos_y = pawn.tile.y;
		}
		
		var pattern_rotated = pattern;
		var centerx_new = centerx; var centery_new = centery;
		if(dir != 0 && !is_distant){
			repeat(dir){
				var results = rotateArray(pattern_rotated, centerx_new, centery_new);
				pattern_rotated = results[0];
				centerx_new = results[1]; centery_new = results[2];
			}
		}
		for(var xx = 0; xx < array_length(pattern_rotated); xx++){
			for(var yy = 0; yy < array_length(pattern_rotated[0]); yy++){
				var cxpos = pos_x + xx - centerx_new; var cypos = pos_y + yy - centery_new;
				if(posWithinGrid(cxpos,cypos)){
					var t = GRID.tiles[cxpos,cypos];
					var attack = pattern_rotated[xx,yy];
					
					if(attack != 0){
						array_push(returns,[t,attack]);
					}
				}
			}
			
		}
		return returns;
		
	}
	function preview(tiles){
		for(var xx = 0; xx < array_length(tiles); xx++){
			var t = tiles[xx][0];
			var attack = tiles[xx][1];
			//var cancel = false;
			if(passesConditions(attack.condition,t)){
				draw_sprite_animated(attack.returnIcon(t), t.xToWorld(), t.yToWorld(), 250);
				t.preview(attack);
				
			}
		}
	}
	function onPerform(){ // Repleable method that runs at the end of perform()
		
	}
	function perform(tiles, caster){
		var cancel = false;
		for(var xx = 0; xx < array_length(tiles); xx++){ // Check whether to cancel...
			var t = tiles[xx][0];
			var attack = tiles[xx][1];
			if(!passesConditions(attack.condition,t)){
				cancel = true;
			}
			
		}
		if(cancel){
			return false; // Make sure not to give enemies attacks with conditions.
		}
		
		for(var xx = 0; xx < array_length(tiles); xx++){
			var t = tiles[xx][0];
			var attack = tiles[xx][1];
			attack.perform(t,caster);
			instance_create_depth(t.xToWorld(),t.yToWorld(),-100,obj_hitfx);
		}
		
		// TO-DO: Create new sound system and then change this basic code...
		if(sound != undefined){
			audio_play_sound(sound,1,false);
		}
		
		onPerform(); // Note to self: Is it really a good idea to put this at the end?
		
		return true;
	}
	
	function setInfo(_name, _desc, _iconid){
		name = _name;
		description = _desc;
		icon_id = _iconid;
	}
	function setCenter(_x, _y){
		centerx = _x;
		centery = _y;
	}
	
}

function passesConditions(_condition, _tile){
	switch(_condition){
		case AttackCondition.mustBeFree:
		if(_tile.stander != noone){
			return false;
		}
		break;
		case AttackCondition.mustIncludePawn:
		if(_tile.stander == noone){
			return false;
		}
		break;
	}
	return true;
}