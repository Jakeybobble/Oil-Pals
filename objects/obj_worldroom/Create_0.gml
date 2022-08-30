/// @description A piece of code.
// Oil Pals moment.

audio_play_sound(mus_worlddebugging,10,true);

gui = new GUI();

text = new GUI_Text(gui,16,16,"Welcome to the holy world testing room!\n(You have been blessed)");
text.setColor(#ffe100);
text.setShadow(#905318);

planets_area = new GUI_Element(gui,room_width/2,room_height/2);

var planets = [spr_planet_womby,spr_planet_gorgo,spr_planet_greger];
for(var xx = 0; xx < array_length(planets); xx++){
	var _b = 64;
	var _x = (xx*_b)-(_b*array_length(planets)/2);
	var planet = new GUI_Sprite(planets_area,_x,0,planets[xx]);
}