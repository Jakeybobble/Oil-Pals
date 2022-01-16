/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Cleaverhead";
hp = 5;
maxhp = 5;
spd = 5;
movespace = 5;

//actions = ds_list_create();

var a = new Attack(4,AttackType.oil,spr_oilyicon);
var b = new Attack(0,AttackType.oil,spr_oilyicon);
var c = new Attack(2,AttackType.oil,spr_oilyicon);
a.perform = function(tile){
	if(tile.status == TileStatus.clear){
		tile.status = TileStatus.oil;
	}
	if(tile.stander != noone){
		tile.stander.takeDamage(2);
	}
	
}
b.perform = function(tile){
	if(tile.status == TileStatus.clear){
		tile.status = TileStatus.oil;
	}
}
c.perform = function(tile){
	if(tile.status == TileStatus.clear){
		tile.status = TileStatus.oil;
	}
}

move1 = new Action();
move1.pattern = [
	[a],
	[a],
	[a]
];
move1.centerx = 1; move1.centery = -1;
move1.ability_icon_id = 3;
move1.name = "Oiled Swipe";
move1.description = "High damage and create oil tiles.";

move2 = new Action();
move2.pattern = [
	[b,b,b,b,b],
	[b,b,b,b,b],
	[b,b,0,b,b],
	[b,b,b,b,b],
	[b,b,b,b,b]
];
move2.ability_icon_id = 4;
move2.centery = 2;
move2.centerx = 2;
move2.name = "Split Skull";
move2.description = "Covers a massive radius in oil. No damage.";

move3 = new Action();
move3.pattern = [
	[0,0,c,c],
	[0,c,c,c],
	[0,0,c,c]
];
move3.ability_icon_id = 5;
move3.centerx = 1; move3.centery = 0;
move3.name = "Sneeze";
move3.description = "Spews medium damage oil ahead.";

ds_list_add(actions, move1, move2, move3);