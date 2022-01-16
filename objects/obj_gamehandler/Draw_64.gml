if(state == PickState.chooseaction){
	var p = pawns[|whoseturn];
	var count = ds_list_size(p.actions);
	for(var xx = 0; xx < count; xx++){
		var action = p.actions[|xx];
		var hovered = false;
		var posx = 240 + 128*xx;
		var posy = 496;
		var drawcolor = c_white;
		if(point_in_rectangle(mouse_x,mouse_y,posx,posy,posx+32*2,posy+(32*2))){
			drawcolor = c_red;
			hovered = true;
		}
		
		if(mouse_check_button_pressed(mb_left)){
			if(hovered){
				state = PickState.chooseactionposition;
				chosen_action = p.actions[|xx];
				mouse_clear(mb_left);
			}
		}else if(mouse_check_button_pressed(mb_right)){
			p.setToTile(tile_memory.x,tile_memory.y);
			tile_memory = noone;
			state = PickState.choosemove;
			mouse_clear(mb_right);
		}
		
		draw_sprite_ext(spr_abilities,action.ability_icon_id,posx,posy,2,2,0,drawcolor,1);
	}
}