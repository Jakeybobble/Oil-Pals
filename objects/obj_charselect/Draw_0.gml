var xpos = 64;
var ypos = 164;
var s = sin(current_time/200)*15;
var faces_spacing = 128;

var faces = [spr_face_oilman,spr_face_chead,spr_face_barrel,spr_face_pond,spr_face_ball,spr_face_bboy,spr_face_ebboy,spr_face_coals,spr_face_ovenmitt];
var face = 0;
var bsize = 48;
for(var yy = 0; yy < 3; yy++){
	for(var xx = 0; xx < 3; xx++){
		var _x = xpos + xx*faces_spacing; var _y = ypos + yy*faces_spacing;
		var info = global.charinfo[|face];
		
		draw_rectangle(_x-bsize,_y-bsize,_x+bsize,_y+bsize,true); // Just for testing...
		
		draw_sprite_ext(faces[face],0,_x,_y,2,2,s,c_white,1);
		if(point_in_rectangle(mouse_x,mouse_y,_x-bsize,_y-bsize,_x+bsize,_y+bsize)){
			
			// On click
			if(mouse_check_button_pressed(mb_left)){
				ds_list_add(global.roster,global.friendlies[face]);
				room_goto(Room1);
			}
			
			// Draw info
			
			var pos_x = 408; var pos_y = 116;
			
			draw_set_font(font_coderscrux);
			draw_text_shadowed(pos_x,pos_y,info.name);
			draw_text_shadowed_ext(pos_x,pos_y+32,info.description,16,300);
			
			var icons_x = pos_x - 8; var icons_y = pos_y + 120;
			var spacing = 100;
			
			for(var zz = 0; zz < ds_list_size(info.abilities); zz++){
				var ability = info.abilities[|zz];
				var _yy = icons_y+spacing*zz;
				
				draw_rectangle_shadowed(icons_x-2,_yy-2,icons_x+64+1,icons_y+64+1+spacing*zz,0);
				draw_sprite_ext(spr_abilities,ability.id,icons_x,icons_y+spacing*zz,2,2,0,c_white,1);
				draw_text_shadowed_ext(pos_x+80,_yy,ability.name,16,250);
				draw_text_shadowed_ext(pos_x+80,_yy+20,ability.description,16,250);
			}
			
		}
		face++;
	}
}