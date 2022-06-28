/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

name = "Bow down for your god";
hp = 999;
maxhp = hp;
spd = irandom(100);
movespace = 5;

faceicon = spr_face_jakey;

barks.death = ["HA! Nice try.", "I'm not going away that easily...", "lol", "Never gonna happen", "Why don't you try that again?", "Missed me!", "Nope.", "Heyo.", "You know I coded this, right?", ""];
barks.damage = ["Owie.", "Oof.", "Ouch, ow ow.", ":-(", "What the heck.", "Dang brugh."];
barks.sound = sou_laugh;
//barks.freebark("Oh yeaaaaah", x, y);

brain.movingtype = MovingType.straightToTarget_exact;
brain.offset = 3;

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

// Attack 1 :-)
move1 = global.abilities[?"test"];

// Attack 2
var b = new Attack(AttackType.normal, spr_noneicon);
b.perform = function(tile){
	barks.freebark("This is an odd round, it is...",x,y-32);
	repeat(5){
		//takeDamage(1);
		// This is just here for no reason now.
	}
}
move2 = new Ability();
move2.pattern = [
	[b]
];
move2.centerx = 0; move1.centery = 0;
move2.icon_id = 15;

ds_list_add(actions,move1,move2);
#endregion
