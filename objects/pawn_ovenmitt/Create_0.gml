/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Oven Mitt";
desc = "Tasked with cleanup duty. Dreams of being a musician someday."
hp = 13;
maxhp = 13;
spd = 4;
movespace = 3;

faceicon = spr_face_ovenmitt;

move1 = global.abilities[?"absorption"];
move2 = global.abilities[?"bodyslam"];
move3 = global.abilities[?"humanlighter"];

ds_list_add(actions, move1, move2, move3);