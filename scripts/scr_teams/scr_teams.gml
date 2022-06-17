// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_teams(){

}

enum TeamType {
	player,
	bot
}

function Team(_type) constructor {
	type = _type;
	player = new Player(); // To-do: Create global players list or something, instead of init here.
}

function Player() constructor{
	name = choose("Dudeo", "Gamer", "Pete", "Schrödinger", "Pinko", "Sonnus", "System32", "Binkus", "Zoombini", "Bloptris", "Mushy", "Dankbob", "Fishfishfish", "Tree Grover", "Wambotron", "6-Deeps");
}