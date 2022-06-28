/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

hp = 999;
maxhp = hp;
spd = 100;
movespace = 5;

dumbocount = 0;

brain.movingtype = MovingType.randomSpot;
brain.offset = 3;

var b = new Attack(AttackType.normal, spr_noneicon);
b.perform = function(tile){
	barks.freebark(dumbocount,x,y-32);
	if(dumbocount < MovingType.NUM){
		dumbocount++;
	}else{
		dumbocount = 0;
	}
	brain.movingtype = dumbocount;
	
	
}
move = new Ability();
move.pattern = [
	[b]
];

move.centerx = 0; move.centery = 0;
move.icon_id = 15;

ds_list_add(actions,move);