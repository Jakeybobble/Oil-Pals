/// @description A piece of code.
// Written by Jacob.

funny+=0.5;

var radius = 16;
for(var xx = 0; xx < ds_list_size(pages[cursor]); xx++){
	var posx = room_width-radius; var posy = xx*(radius*2);
	var spawn = pages[cursor][|xx];
	var hovered = false;
	if(point_in_circle(mouse_x,mouse_y,posx,posy+radius,radius)){
		hovered = true;
		if(mouse_check_button_pressed(mb_left)){
			GH.enemiesleft = 1337;
			GH.nextenemy_turns = 50000;
			var randx = irandom_range(0,array_length(GRID.tiles)-1);
			var randy = irandom_range(0,array_length(GRID.tiles[0])-1);
			var ttt = GRID.tiles[randx,randy];
			if(!ttt.occupied){
				ttt.status = TileStatus.clear;
				GH.spawnPawn(spawn.obj,ttt.x,ttt.y,GH.team_bot);
			}
		}	
	}
	draw_circle(posx,posy+radius,radius,hovered);
	//draw_sprite(spawn.spr,0,posx,posy+60);
	draw_sprite_ext(spawn.spr,0,posx,posy+(radius*2),0.5,0.5,funny+xx*32,c_white,1);
	
}