// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_charInfo(){
	// This is just a remake of scr_info
}

function CharacterInfo(_name, _desc, _abilities) constructor{
	name = _name;
	description = _desc;
	abilities = ds_list_create();
	for(var xx = 0; xx < array_length(_abilities); xx++){
		ds_list_add(abilities,_abilities[xx]);
	}
}

function AbilityInfo(_id, _name, _desc) constructor{
	id = _id;
	name = _name;
	description = _desc;
}

global.charinfo = ds_list_create();

var i = 0; // This is just here because I'll be making everything in order anyways.
ds_list_add(global.charinfo, new CharacterInfo(
	"Oilman",
	"Big fan of oil. It's his favorite drink.",
	[
		new AbilityInfo(i++,"Oil Slap", "Does extra damage on oil spot."),
		new AbilityInfo(i++,"Oil Guzzle", "Drinks oil on the ground below you."),
		new AbilityInfo(i++,"Oil Drool", "Leaves a high damage oil drool pool."),
	]
));

ds_list_add(global.charinfo, new CharacterInfo(
	"Cleaverhead",
	"Forever doomed to spill his oil blood everywhere he goes. Leaves a trail of oil where he walks.",
	[
		new AbilityInfo(i++,"Oiled Swipe", "High damage and creates oil tiles."),
		new AbilityInfo(i++,"Split Skull", "Sprays oil everywhere. No damage."),
		new AbilityInfo(i++,"Sneeze", "Shoots high damage oil forward."),
	]
));

ds_list_add(global.charinfo, new CharacterInfo(
	"Barrel",
	"The sheriff of the oil rig. Can light fires with his cigarette as well as use oil.",
	[
		new AbilityInfo(i++,"Cigarette Toss", "Creates a fire tile and deals high damage."),
		new AbilityInfo(i++,"Oil Artillery", "Deals medium damage and creates an oil tile anywhere."),
		new AbilityInfo(i++,"Oil Spray", "Deals low damage and creates a line of oil tiles."),
	]
));

ds_list_add(global.charinfo, new CharacterInfo(
	"Pond",
	"Your friendly neighborhood pond. Spreads joy (and water).",
	[
		new AbilityInfo(i++,"Bamboo Artillery", "Deals low damage anywhere."),
		new AbilityInfo(i++,"Tsunami", "Creates puddles in all adjacent tiles. No damage."),
		new AbilityInfo(i++,"Extinguisher", "Creates a puddle anywhere. No damage."),
	]
));

ds_list_add(global.charinfo, new CharacterInfo(
	"Ball",
	"A very standard, soggy, ball creature.",
	[
		new AbilityInfo(i++,"Soggy Chomp", "Deals high damage and creates puddles in other tiles."),
		new AbilityInfo(i++,"Osmosis", "Absorbs water it is standing on, healing if successful."),
		new AbilityInfo(i++,"Smash", "Medium damage, medium range attack."),
	]
));

ds_list_add(global.charinfo, new CharacterInfo(
	"Brigade Boy",
	"Master of the super soaker. High damage but frail.",
	[
		new AbilityInfo(i++,"Soggy Sniper", "Extreme damage, but hard to aim."),
		new AbilityInfo(i++,"Water Cannon", "Shoots a large low damage beam, leaving puddles behind."),
		new AbilityInfo(i++,"Splash", "Medium damage, close range."),
	]
));

ds_list_add(global.charinfo, new CharacterInfo(
	"Evil Brigade Boy",
	"Master of the super scalder. Same as Brigade Boy, but fire-y.",
	[
		new AbilityInfo(i++,"Sizzling Sniper", "Extreme damage, but hard to aim."),
		new AbilityInfo(i++,"Lava Cannon", "Shoots a large low damage beam, leaving fire."),
		new AbilityInfo(i++,"Magma Splash", "Medium damage, close range."),
	]
));

ds_list_add(global.charinfo, new CharacterInfo(
	"Coals",
	"A group of mischevous coal monsters. Can hop anywhere, but leaves fire where they go. Immune to damage from fire tiles.",
	[
		new AbilityInfo(i++,"Hop", "Jump to a location and spawn fire in adjacent tiles."),
		new AbilityInfo(i++,"Flamewhistle", "Spawns a row of flames and does medium damage."),
		new AbilityInfo(i++,"Ignite", "When standing on a flame, absorb it and heal."),
	]
));

ds_list_add(global.charinfo, new CharacterInfo(
	"Oven Mitt",
	"Tasked with cleanup duty. Dreams of being a musician someday.",
	[
		new AbilityInfo(i++,"Absorbtion", "Clears any terrain on the spot you are standing on."),
		new AbilityInfo(i++,"Body Slam", "Deals high damage. If it hits, spawn a flame."),
		new AbilityInfo(i++,"Human(?) Lighter", "Spawns a flame."),
	]
));

