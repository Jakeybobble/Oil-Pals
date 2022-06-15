var xpos = 64;
var ypos = 96;
var s = 0;
var faces_spacing = 64;

var faces = [spr_face_oilman,spr_face_chead,spr_face_barrel,spr_face_pond,spr_face_ball,spr_face_bboy,spr_face_ebboy,spr_face_coals,spr_face_ovenmitt];
var face = 0;
var bsize = 64;
for(var yy = 0; yy < 3; yy++){
	for(var xx = 0; xx < 3; xx++){
		var _x = xpos + xx*faces_spacing; var _y = ypos + yy*faces_spacing;
		var info = global.charinfo[|face];
		
		draw_rectangle(_x,_y,_x+bsize,_y+bsize,true); // Just for testing...
		
		draw_sprite_ext(faces[face],0,_x,_y,2,2,s,c_white,1);
		if(point_in_rectangle(mouse_x,mouse_y,_x,_y,_x+bsize,_y+bsize)){
			
			// On click
			if(mouse_check_button_pressed(mb_left)){
				ds_list_add(global.roster,global.friendlies[face]);
				room_goto(Room1);
			}
			
			// Draw info
			
			var pos_x = 280; var pos_y = 98;
			
			draw_set_font(font_coderscruxsmall);
			draw_text_fancy_ext(pos_x,pos_y,info.name,c_white,300,3000);
			draw_text_fancy_ext(pos_x,pos_y+16,info.description,c_white,10,300);
			
			var icons_x = pos_x - 8; var icons_y = pos_y + 60;
			var spacing = 56;
			
			for(var zz = 0; zz < ds_list_size(info.abilities); zz++){
				var ability = info.abilities[|zz];
				var _yy = icons_y+spacing*zz;
				
				draw_rectangle_shadowed(icons_x-2,_yy-2,icons_x+48+1,icons_y+48+1+spacing*zz,0);
				draw_sprite_ext(spr_abilities,ability.id,icons_x,icons_y+spacing*zz,2,2,0,c_white,1);
				draw_text_fancy_ext(pos_x+60,_yy,ability.name,c_white,10,250);
				draw_text_fancy_ext(pos_x+60,_yy+20,ability.description,c_white,10,250);
			}
			
		}
		face++;
	}
}