// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_abilitylist(){

}

// Note: Enemy abilities should be defined in their instances (and not here).

global.abilities = ds_map_create();

// Test attack
var _test = new Ability();
var a = new Attack(AttackType.normal,spr_noneicon);
_test.perform = function(tile,caster){
	caster.barks.freebark("Hooray! for testing!",caster.x,caster.y-32);
	caster.animhandler.play(global.anims[?"hop"]);
}
_test.pattern = [
	[a]
]
ds_map_add(global.abilities,"test",_test);

#region // OILMAN
var a = new Attack(AttackType.normal,spr_noneicon); var b = new Attack(AttackType.oil,spr_oilyicon); var c = new Attack(AttackType.oil,spr_specialicon);
a.perform = function(tile,caster){
	if(tile.stander != noone){
		tile.stander.takeDamage(1);
	}
}
b.perform = function(tile,caster){
	setToOil(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(5);
	}
}
c.perform = function(tile,caster){
	if(tile.status == TileStatus.oil){
		tile.status = TileStatus.clear;
		caster.hp+=2;
	}
}

var oilslap = new Ability();
oilslap.setInfo("Oil Slap", "Does extra damage on oil spot.",0);
oilslap.pattern = [
	[0,a,a,b]
];
oilslap.sound = sou_water1; // Placeholder
ds_map_add(global.abilities,"oilslap",oilslap);

var oilguzzle = new Ability();
oilguzzle.setInfo("Oil Guzzle", "Drink oil from the tile you are standing on, healing you.", 1);
oilguzzle.pattern = [
	[c]
];
oilguzzle.sound = sou_silly; // Placeholder
ds_map_add(global.abilities,"oilguzzle",oilguzzle);

var oildrool = new Ability();
oildrool.setInfo("Oil Drool","Leaves a high damage oily spit pool in front of you.",2);
oildrool.setCenter(1,-1);
oildrool.pattern = [
	[b],
	[b],
	[b]
];
oildrool.sound = sou_water2; // Placeholder
ds_map_add(global.abilities,"oildrool",oildrool);
#endregion
#region // POND
var a = new Attack(AttackType.normal,spr_noneicon); var b = new Attack(AttackType.water,spr_watericon);
a.perform = function(tile,caster){
	if(tile.stander != noone){
		tile.stander.takeDamage(2);
	}
}
b.perform = function(tile,caster){
	setToWater(tile);
}
var bambooartillery = new Ability();
bambooartillery.setInfo("Bamboo Artillery","Shoots medium damage at a spot anywhere.",9);
bambooartillery.is_distant = true;
bambooartillery.pattern = [
	[a]
];
ds_map_add(global.abilities,"bambooartillery",bambooartillery);

var tsunami = new Ability();
tsunami.setInfo("Tsunami","Spawns puddles in all adjacent tiles. No damage.",10);
tsunami.setCenter(1,1);
tsunami.pattern = [
	[b,b,b],
	[b,0,b],
	[b,b,b]
];
ds_map_add(global.abilities,"tsunami",tsunami);

var extinguisher = new Ability();
extinguisher.setInfo("Extinguisher", "Spawns a puddle anywhere. No damage.",11);
extinguisher.is_distant = true;
extinguisher.pattern = [
	[b]
];
ds_map_add(global.abilities,"extinguisher",extinguisher);
#endregion
#region // BARREL
var a = new Attack(AttackType.fire,spr_fireyicon); var b = new Attack(AttackType.oil,spr_oilyicon); var c = new Attack(AttackType.oil,spr_oilyicon);
a.perform = function(tile){
	setToFire(tile,2);
	if(tile.stander != noone){
		tile.stander.takeDamage(4);
	}
}
b.perform = function(tile){
	setToOil(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(2);
	}
}
c.perform = function(tile){
	setToOil(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(3);
	}
}

var cigarettetoss = new Ability();
cigarettetoss.setInfo("Cigarette Toss", "Spawns flames and deals high damage.",6);
cigarettetoss.pattern = [
	[0,0,a]
];
ds_map_add(global.abilities,"cigarettetoss",cigarettetoss);

var oilartillery = new Ability();
oilartillery.setInfo("Oil Artillery", "Shoots oil anywhere on the map.", 7);
oilartillery.is_distant = true;
oilartillery.pattern = [
	[c]
];
ds_map_add(global.abilities,"oilartillery",oilartillery);

var oilspray = new Ability();
oilspray.setInfo("Oil Spray", "Shoots oil a line of oil.", 8);
oilspray.pattern = [
	[0,b,b,b,b]
];
ds_map_add(global.abilities,"oilspray",oilspray);
#endregion
#region // CLEAVERHEAD
var a = new Attack(AttackType.oil,spr_oilyicon); var b = new Attack(AttackType.oil,spr_oilyicon); var c = new Attack(AttackType.oil,spr_oilyicon);
a.perform = function(tile){
	setToOil(tile);	
	if(tile.stander != noone){
		tile.stander.takeDamage(4);
	}	
}
b.perform = function(tile){
	setToOil(tile);
}
c.perform = function(tile){
	setToOil(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(2);
	}
}
var oiledswipe = new Ability();
oiledswipe.setInfo("Oiled Swipe", "High damage and create oil tiles.", 3);
oiledswipe.setCenter(1,-1);
oiledswipe.pattern = [
	[a],
	[a],
	[a]
];
ds_map_add(global.abilities,"oiledswipe",oiledswipe);

var splitskull = new Ability();
splitskull.setInfo("Split Skull", "Covers a massive radius in oil. No damage.", 4);
splitskull.setCenter(2,2);
splitskull.pattern = [
	[b,b,b,b,b],
	[b,b,b,b,b],
	[b,b,0,b,b],
	[b,b,b,b,b],
	[b,b,b,b,b]
];
ds_map_add(global.abilities,"splitskull",splitskull);

var sneeze = new Ability();
sneeze.setInfo("Sneeze","Spews medium damage oil ahead.",5);
sneeze.setCenter(1,0);
sneeze.pattern = [
	[0,0,c,c],
	[0,c,c,c],
	[0,0,c,c]
];
ds_map_add(global.abilities,"sneeze",sneeze);
#endregion
#region // OVENMITT
var a = new Attack(AttackType.normal,spr_specialicon); var b = new Attack(AttackType.normal,spr_noneicon); var c = new Attack(AttackType.fire,spr_fireyicon);

a.perform = function(tile,caster){
	if(tile.status != TileStatus.clear){
		tile.status = TileStatus.clear;
	}
	caster.status.clear();
}
b.perform = function(tile){
	if(tile.stander != noone){
		tile.stander.takeDamage(5);
		setToFire(tile,2);
	}
}
c.perform = function(tile){
	setToFire(tile,2);
	if(tile.stander != noone){
		tile.stander.takeDamage(3);
	}
}

var absorption = new Ability();
absorption.setInfo("Absorption", "Clears any terrain on the spot you are standing on.\nAlso clears status.", 24);
absorption.pattern = [
	[a]
];
ds_map_add(global.abilities,"absorption",absorption);

var bodyslam = new Ability();
bodyslam.setInfo("Body Slam", "Deals high damage. If it hits, spawn a flame.", 25);
bodyslam.pattern = [
	[0,b]
];
ds_map_add(global.abilities,"bodyslam",bodyslam);

var humanlighter = new Ability();
humanlighter.setInfo("Human(?) Lighter", "Spawns a flame.", 26);
humanlighter.pattern = [
	[0,c]
];
ds_map_add(global.abilities,"humanlighter",humanlighter);
#endregion
#region // COALS
var a = new Attack(AttackType.normal,spr_specialicon); var b = new Attack(AttackType.fire,spr_fireyicon); var c = new Attack(AttackType.fire,spr_fireyicon); var d = new Attack(AttackType.normal,spr_specialicon);
a.perform = function(_t,caster){
	if(!_t.occupied){
		caster.setToTile(_t.x,_t.y);
	}
}
a.condition = AttackCondition.mustBeFree;
b.perform = function(tile){
	setToFire(tile,2);
	if(tile.stander != noone){
		tile.stander.takeDamage(3);
	}
}
c.perform = function(tile){
	setToFire(tile,2);
}
d.perform = function(tile,caster){
	if(tile.status == TileStatus.fire){
		tile.status = TileStatus.clear;
		caster.hp+=2;
	}
}

var hop = new Ability();
hop.setInfo("Hop","Jump to a location and spawn fire in adjacent tiles.",21);
hop.setCenter(1,1); hop.is_distant = true;
hop.pattern = [
	[c,c,c],
	[c,a,c],
	[c,c,c]
];
ds_map_add(global.abilities,"hop",hop);

var flamewhistle = new Ability();
flamewhistle.setInfo("Flamewhistle", "Spawns a row of flames and deals medium damage.", 22);
flamewhistle.setCenter(0,-1);
flamewhistle.pattern = [
	[b,b,b]
];
ds_map_add(global.abilities,"flamewhistle",flamewhistle);

var ignite = new Ability();
ignite.setInfo("Ignite", "When standing on a flame, absorb it and heal.", 23);
ignite.pattern = [
	[d]
];
ds_map_add(global.abilities,"ignite",ignite);

#endregion
#region // BALL
var a = new Attack(AttackType.normal,spr_noneicon); var b = new Attack(AttackType.water,spr_watericon); var c = new Attack(AttackType.normal,spr_noneicon); var d = new Attack(AttackType.normal,spr_specialicon);
a.perform = function(tile){
	if(tile.stander != noone){
		tile.stander.takeDamage(4);
	}
}
b.perform = function(tile){
	setToWater(tile);
}
c.perform = function(tile){
	if(tile.stander != noone){
		tile.stander.takeDamage(3);
	}
}
d.perform = function(tile, caster){
	if(tile.status == TileStatus.water){
		tile.status = TileStatus.clear;
		caster.hp+=2;
	}
}
var soggychomp = new Ability();
soggychomp.setInfo("Soggy Chomp", "High damage and spews water where not attacking.", 12);
soggychomp.setCenter(1,1);
soggychomp.pattern = [
	[b,b,b],
	[b,0,a],
	[b,b,b]
];
ds_map_add(global.abilities,"soggychomp",soggychomp);

var osmosis = new Ability();
osmosis.setInfo("Osmosis", "Absorb water it is standing on. Heal if successful.", 13);
osmosis.pattern = [
	[d]

];
ds_map_add(global.abilities,"osmosis",osmosis);

var smash = new Ability();
smash.setInfo("Smash", "Medium damage, medium range attack.", 14);
smash.pattern = [
	[0,c,c,c]
];
ds_map_add(global.abilities,"smash",smash);

#endregion
#region // BRIGADE BOY
var a = new Attack(AttackType.normal,spr_noneicon); var b = new Attack(AttackType.water,spr_watericon); var c = new Attack(AttackType.water,spr_watericon); var d = new Attack(AttackType.water,spr_watericon);
a.perform = function(tile){ // Bruh.
	show_debug_message("Hey, it's working");
}
b.perform = function(tile){
	setToWater(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(7);
	}
}
c.perform = function(tile){
	setToWater(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(2);
	}
}
d.perform = function(tile){
	setToWater(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(3);
	}
}

var soggysniper = new Ability();
soggysniper.setInfo("Soggy Sniper","Extreme damage, but hard to aim.",15);
soggysniper.setCenter(0,-1);
soggysniper.pattern = [
	[0,0,0,0,b]
];
ds_map_add(global.abilities,"soggysniper",soggysniper);

var watercannon = new Ability();
watercannon.setInfo("Water Cannon", "Shoots a large low damage beam, leaving puddles behind.",16);
watercannon.setCenter(0,-1);
watercannon.pattern = [
	[c,c,c,c,c]
];
ds_map_add(global.abilities,"watercannon",watercannon);

var splash = new Ability();
splash.setInfo("Splash", "Medium damage, close range.", 17);
splash.setCenter(1,-1);
splash.pattern = [
	[d],
	[d],
	[d]
];
ds_map_add(global.abilities,"splash",splash);

#endregion
#region // EVIL BRIGADE BOY
var b = new Attack(AttackType.fire,spr_fireyicon); var c = new Attack(AttackType.fire,spr_fireyicon); var d = new Attack(AttackType.fire,spr_fireyicon);
b.perform = function(tile){
	setToFire(tile,2);
	if(tile.stander != noone){
		tile.stander.takeDamage(7);
	}
}
c.perform = function(tile){
	setToFire(tile,2);
	if(tile.stander != noone){
		tile.stander.takeDamage(2);
	}
}
d.perform = function(tile){
	setToFire(tile,2);
	if(tile.stander != noone){
		tile.stander.takeDamage(3);
	}
}

var sizzlingsniper = new Ability();
sizzlingsniper.setInfo("Sizzling Sniper","Extreme damage, but hard to aim.", 18);
sizzlingsniper.setCenter(0,-1);
sizzlingsniper.pattern = [
	[0,0,0,0,b]
];
ds_map_add(global.abilities,"sizzlingsniper",sizzlingsniper);

var lavacannon = new Ability();
lavacannon.setInfo("Lava Cannon", "Shoots a large low damage beam, leaving fire.", 19);
lavacannon.setCenter(0,-1);
lavacannon.pattern = [
	[c,c,c,c,c]
];
ds_map_add(global.abilities,"lavacannon",lavacannon);

var magmasplash = new Ability();
magmasplash.setInfo("Magma Splash", "Medium damage, close range.", 20);
magmasplash.setCenter(1,-1);
magmasplash.pattern = [
	[d],
	[d],
	[d]
];
ds_map_add(global.abilities,"magmasplash",magmasplash);
#endregion