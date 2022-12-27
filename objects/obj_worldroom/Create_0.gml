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
	var planet = new GUI_SimpleButton(planets_area,_x,0,planets[xx]);
	planet.width = 48; planet.height = 52;
	planet.num = xx;
	with(planet){
		world = new World();
		if(num == 1) {
			world.worldtype = WorldType.test;
			world.debugname = "Stinky";
		}
		if(num == 2) {
			world.build = function(){
				/* TEMPORARY GRID CREATION! */
				var gridpos_x = 32; var gridpos_y = 128;
				var grid_width = 18; var grid_height = 3;
				world.grid = new Grid(world,gridpos_x, gridpos_y, grid_width, grid_height);
			}
			
			world.debugname = "Slimmy";
		}
		func = function(){
			ds_list_add(global.roster,pawn_evildingo); // So that there isn't just a single character.
			show_debug_message(world.worldtype);
			world.load();
		}
	}
}