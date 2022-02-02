if(state == PickState.chooseaction){
	var p = pawns[|whoseturn];
	if(p.is_player){
		#region Is Player
		var count = ds_list_size(p.actions);
		draw_set_color(c_black);
		draw_set_alpha(0.5);
		draw_rectangle(220,416,580,1000,0);
		draw_set_alpha(1);
		draw_set_color(c_white);
		for(var xx = 0; xx < count; xx++){
			var action = p.actions[|xx];
			var hovered = false;
			var posx = 240 + 128*xx;
			var posy = 496;
			var drawcolor = c_white;
			if(point_in_rectangle(mouse_x,mouse_y,posx,posy,posx+32*2,posy+(32*2))){
				drawcolor = c_red;
				hovered = true;
				draw_set_color(c_black);
				draw_set_font(font_coderscrux);
				draw_text(242,438,p.actions[|xx].name);
				draw_text_ext(242,454,p.actions[|xx].description,16,340);
				draw_set_color(c_white);
				draw_text(240,436,p.actions[|xx].name);
				draw_text_ext(240,452,p.actions[|xx].description,16,340);
			
			}
			
			if(mouse_check_button_pressed(mb_left)){
				if(hovered){
					state = PickState.chooseactionposition;
					chosen_ability = p.actions[|xx];
					mouse_clear(mb_left);
				}
			}else if(mouse_check_button_pressed(mb_right)){
				p.setToTile(tile_memory.x,tile_memory.y);
				for(var _d = 0; _d < ds_list_size(tiledata_memory); _d++){
					var _t = tiledata_memory[|_d];
					_t.status = _t.memory;
				}
				ds_list_clear(tiledata_memory);
				tile_memory = noone;
				state = PickState.choosemove;
				mouse_clear(mb_right);
			}else if(keyboard_check_pressed(vk_anykey)){
				if(keyboard_lastkey == ord(string(xx+1))){
					//show_debug_message("Wow! " + string(xx+1));
					state = PickState.chooseactionposition;
					chosen_ability = p.actions[|xx];
				}
			}
		
			draw_sprite_ext(spr_abilities,action.icon_id,posx,posy,2,2,0,drawcolor,1);
		}
		#endregion
	}else if(!p.is_player){
		// Beep boop.
		
		state = PickState.chooseactionposition;
		//var rand = irandom_range(0,ds_list_size(p.actions)-1);
		p.doConditions(true);
		var _pick = p.brain.nextaction
		chosen_ability = p.actions[|_pick];
		
		
		//state = PickState.performing;
	}
	
}

var pcount = 0;
var ecount = 0;

for(var xx = 0; xx < ds_list_size(pawns); xx++){
	var p = pawns[|xx];
	if(!p.dead){
		if(p.is_player){
			var s = sin(current_time/200)*15;
			draw_sprite_ext(p.faceicon,0,48,48+86*pcount,1.4,1.4,s,c_white,1);
			if(whoseturn == xx){
				arrowy = 40+86*pcount;
				draw_sprite_ext(spr_arrow,0,88+(s/2),arrowy,1,1,0,c_white,1);
			}
			pcount++;
		}
		else{
			var s = sin(current_time/200)*15;
			draw_sprite_ext(p.faceicon,0,672+48,48+86*ecount,1.4,1.4,s,c_white,1);
			if(whoseturn == xx){
				arrowy = 40+86*ecount;
				draw_sprite_ext(spr_arrow,0,680+(s/2),arrowy,-1,1,0,c_white,1);
			}
			ecount++;
		}
	}
	
}

draw_set_font(font_squarecakes);
draw_text_transformed(0,room_height-58,"Level " + string(global.level) + "\nWave: " + string(wave) +"\nEnemies spawning: " + string(enemiesleft),2,2,0);

