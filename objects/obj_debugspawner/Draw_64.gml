/// @description A piece of code.
// Written by Jacob.

for(var xx = 0; xx < ds_list_size(pages[cursor]); xx++){
	var posx = room_width-32; var posy = xx*64;
	var spawn = pages[cursor][|xx];
	var hovered = false;
	if(point_in_circle(mouse_x,mouse_y,posx,posy+32,32)){
		hovered = true;
		if(mouse_check_button_pressed(mb_left)){
			GH.enemiesleft = 1337;
			GH.nextenemy_turns = 50000;
			var randx = irandom_range(0,array_length(GRID.tiles)-1);
			var randy = irandom_range(0,array_length(GRID.tiles[0])-1);
			var ttt = GRID.tiles[randx,randy];
			if(!ttt.occupied){
				ttt.status = TileStatus.clear;
				GH.spawnPawn(spawn.obj,ttt.x,ttt.y,false);
			}
		}	
	}
	draw_circle(posx,posy+32,32,hovered);
	draw_sprite(spawn.spr,0,posx,posy+60);
	
}