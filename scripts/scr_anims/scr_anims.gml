// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_anims(){
	// Index of anims for the Generalized Animation System
}

global.anims = ds_map_create();

var test = new Anim();
test.maxlength = 110;
test.onStart = function(_handler){
	audio_play_sound(sou_laugh,0,false);
}
test.draw = function(_handler){
	var actor = _handler.actor.anim; // To-do: Macro for this.
	var t = _handler.time; // Might pass this through function.
	actor.draw(_handler.actor.sprite_index,_handler.actor.image_index); // To-do: Make this all nicer... :-(
	for(var b = 0; b < array_length(_handler.sideactors); b++){ // Looping through side-actors.
		var sactor = _handler.sideactors[b].anim;
	}
	actor.x = _handler.actor.x+(sin(t/5)*4)-4;
	draw_sprite(spr_smile,0,actor.x,actor.y-t); // You should also be able to draw sprites at the same time.
}
ds_map_add(global.anims,"test",test);

var hop = new Anim();
hop.maxlength = 30;
hop.onStart = function(_handler){
	var actor = _handler.actor.anim;
	_handler.actor.a_vsp = -2;
}
hop.draw = function(_handler){
	var actor = _handler.actor.anim;
	_handler.actor.a_vsp += 0.2;
	actor.y = clamp(actor.y + _handler.actor.a_vsp,-100,_handler.actor.y);
	actor.draw(_handler.actor.sprite_index,_handler.actor.image_index);
}
ds_map_add(global.anims,"hop",hop);