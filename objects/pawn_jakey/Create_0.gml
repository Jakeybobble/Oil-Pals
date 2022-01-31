/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = false;
name = "Bow down for your god";
hp = 999;
maxhp = hp;
spd = irandom(100);
movespace = 3;

faceicon = spr_face_jakey;

barks.death = ["HA! Nice try.", "I'm not going away that easily...", "lol", "Never gonna happen", "Why don't you try that again?", "Missed me!", "Nope.", "Heyo.", "You know I coded this, right?", ""];
barks.damage = ["Owie.", "Oof.", "Ouch, ow ow.", ":-(", "What the heck.", "Dang brugh."];
barks.sound = sou_laugh;
//barks.freebark("Oh yeaaaaah", x, y);

brain.movingtype = MovingType.straightToTarget_front;

function doConditions(hasmoved){
	// Conditions are unique to every enemy... Probably.
	//show_debug_message(GH.wave % 2);
	brain.nextaction = 0;
	if(GH.wave % 2 == 0){
		brain.nextaction = 0;
	}else{
		brain.nextaction = 1;
	}
}

function onDeath(){
	dead = false;
	hp = maxhp;
	var randx = irandom(GRID.getWidth()-1);
	var randy = irandom(GRID.getHeight()-1);
	setToTile(randx,randy);
	barks.bark(BarkTypes.death,xToWorld(randx)+TS/2,yToWorld(randy)-32);
}

function onEndTurn(){
	hp = maxhp;
}
function onTakeDamage(dmg, type){
	barks.bark(BarkTypes.damage,x,y-32);
}

#region Actions
// Attack 1
var a = new Attack(3,AttackType.normal,spr_noneicon);
a.perform = function(tile){
	/*
	if(tile.stander != noone){
		tile.stander.takeDamage(2);
	}
	*/
	barks.freebark("Wohoo! The round is even.",x,y-32);
}

move1 = new Action();
move1.pattern = [
	[a]
];
move1.centerx = 0; move1.centery = 0;
move1.ability_icon_id = 15;

// Attack 2
var b = new Attack(3,AttackType.normal,spr_noneicon);
b.perform = function(tile){
	barks.freebark("Dang. The round is odd.",x,y-32);
}

move2 = new Action();
move2.pattern = [
	[b]
];
move2.centerx = 0; move1.centery = 0;
move2.ability_icon_id = 15;

ds_list_add(actions,move1,move2);
#endregion
