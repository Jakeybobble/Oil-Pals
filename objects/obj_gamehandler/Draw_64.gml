if(state == PickState.chooseaction or state == PickState.chooseactionposition){
	var p = pawns[|whoseturn];
	if(p.is_player){
		#region Is Player
		var count = ds_list_size(p.actions);
		draw_set_color(c_black);
		if(state == PickState.chooseactionposition){
			menutopset = lerp(menutopset,307,0.1);
		}
		else{
			menutopset = lerp(menutopset,256,0.1);
		}
		draw_set_alpha(0.5);
		draw_rectangle(224,menutopset,415,359,0);
		draw_set_alpha(1);
		draw_sprite(spr_abmenuframe,0,224,menutopset);
		draw_set_color(c_white);
		for(var xx = 0; xx < count; xx++){
			var action = p.actions[|xx];
			var hovered = false;
			var posx = 260 + 48*xx;
			var posy = 319;
			var drawcolor = c_white;
			if(point_in_rectangle(mouse_x,mouse_y,posx,posy,posx+24,posy+(24)) and state != PickState.chooseactionposition){
				drawcolor = c_red;
				hovered = true;
				draw_set_font(font_coderscruxsmall);
				draw_set_color(c_white);
				draw_text_fancy_ext(230,260,p.actions[|xx].name,c_white,12,30000);
				draw_text_fancy_ext(230,278,p.actions[|xx].description,c_white,11,180);
			
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
			if(p.actions[|xx] == chosen_ability){
				drawcolor = c_red;
			}
			draw_sprite_ext(spr_abilityframe,0,posx,posy,1,1,0,c_white,1);
			draw_sprite_ext(spr_abilities,action.icon_id,posx,posy,1,1,0,drawcolor,1);
			draw_set_font(font_coderscruxsmall);
			draw_set_halign(fa_center);
			draw_text_fancy_ext(319,350,"[SPACE] Skip - [M2] Back",c_white,12,300);
			draw_set_halign(fa_left);
		}
		#endregion
	}else if(!p.is_player){
		// Beep boop.
		
		state = PickState.chooseactionposition;
		//var rand = irandom_range(0,ds_list_size(p.actions)-1);
		if(p.brain.willreconsider){
			p.doConditions(true);
		}
		if(!p.brain.abstain){
			var _pick = p.brain.nextaction
			chosen_ability = p.actions[|_pick];
			
			
		}else{ // If abstaining attack.
			p.brain.abstain = false;
			state = PickState.performing;
		}
		
		//state = PickState.performing;
	}
	
}

var pcount = 0;
var ecount = 0;

for(var xx = 0; xx < ds_list_size(pawns); xx++){
	var p = pawns[|xx];
	if(p.is_player){
		var s = 0;
		draw_sprite_ext(spr_ropes,0,32,0+48*pcount,1,1,s,c_white,1);
		draw_set_color(c_black)
		draw_rectangle(31,15+48*pcount,64,48+48*pcount,0)
		draw_set_color(c_white)
		draw_sprite_ext(p.faceicon,0,32,16+48*pcount,1,1,s,c_white,1);
		/* drawing boards always breaks so i'm just disabling
		if(xx == 0){
			draw_sprite_ext(spr_board,0,32,16+48*pcount,1,1,s,c_white,1);
		}
		if(xx == ds_list_size(pawns)-1){
			draw_sprite_ext(spr_board,0,32,16+48*pcount+32,1,1,s,c_white,1);
		}
		*/
		if(whoseturn == xx){
			arrowy = 20+48*pcount;
			draw_sprite_ext(spr_arrow,0,8,arrowy,1,1,0,c_white,1);
		}
		pcount++;
	}
	else{
		var s = sin(current_time/200)*15;
		draw_sprite_ext(p.faceicon,0,672+48,48+86*ecount,1,1,s,c_white,1);
		if(whoseturn == xx){
			arrowy = 40+86*ecount;
			draw_sprite_ext(spr_arrow,0,680+(s/2),arrowy,-1,1,0,c_white,1);
		}
		ecount++;
	}
}

draw_set_font(font_squarecakes);
draw_text_transformed(0,room_height-58,"Level " + string(global.level) + "\nWave: " + string(wave) +"\nEnemies spawning: " + string(enemiesleft),2,2,0);

