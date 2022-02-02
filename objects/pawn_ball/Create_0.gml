/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Ball";
desc = "A very standard, soggy, ball creature."
hp = 12;
maxhp = 12;
spd = 5;
movespace = 5;

faceicon = spr_face_ball;

move1 = global.abilities[?"soggychomp"];
move2 = global.abilities[?"osmosis"];
move3 = global.abilities[?"smash"];

ds_list_add(actions, move1, move2, move3);