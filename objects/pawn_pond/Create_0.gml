/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Pond";
hp = 7;
maxhp = 7;
spd = 5;
movespace = 3;

//actions = ds_list_create();

var a = new Attack(2,AttackType.normal,spr_noneicon);
var b = new Attack(0,AttackType.water,spr_watericon);
b.perform = function(tile){
	if(tile.status == TileStatus.clear){
		tile.status = TileStatus.water;
	}
}
a.perform = function(tile){
	show_debug_message("Hey, it's working");
}

move1 = new Action();
move1.pattern = [
	[a]
];
move1.is_distant = true;
move1.centerx = 0; move1.centery = 0;
move1.ability_icon_id = 9;

move1.name = "Bamboo Artillery";
move1.description = "Shoots medium damage at a spot anywhere.";

move2 = new Action();
move2.pattern = [
	[b,b,b],
	[b,0,b],
	[b,b,b]
];
move2.ability_icon_id = 10;
move2.centery = 1;
move2.centerx = 1;

move2.name = "Tsunami";
move2.description = "Spawns puddles in all adjacent tiles. No damage.";

move3 = new Action();
move3.pattern = [
	[b]
];
move3.ability_icon_id = 11;
move3.is_distant = true;

move3.name = "Extinguisher";
move3.description = "Spawns a puddle anywhere. No damage.";

ds_list_add(actions, move1, move2, move3);