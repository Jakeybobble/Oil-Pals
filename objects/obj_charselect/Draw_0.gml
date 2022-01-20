var xx = 0;
var yy = 0;
var s = sin(current_time/200)*15;

while(xx != 3 and yy != 3){
	var xpos = 64+128*xx
	var ypos = 164+128*yy;
	var face = xx+(yy*3);
	draw_rectangle(xpos-48,ypos-48,xpos+48,ypos+48,true);
	draw_sprite_ext(spr_testface2,face,xpos,ypos,2,2,s,c_white,1);
	if(point_in_rectangle(mouse_x,mouse_y,xpos-48,ypos-48,xpos+(48*2)-48,ypos+(48*2)-48)){
		draw_rectangle(398,258,465,325,0);
		draw_rectangle(398,358,465,425,0);
		draw_rectangle(398,458,465,525,0);
		draw_sprite_ext(spr_abilities,(face*3),400,260,2,2,0,c_white,1);
		draw_sprite_ext(spr_abilities,(face*3+1),400,360,2,2,0,c_white,1);
		draw_sprite_ext(spr_abilities,(face*3+2),400,460,2,2,0,c_white,1);
		if(mouse_check_button_pressed(mb_left)){
			ds_list_add(global.roster,global.friendlies[face]);
			room_goto(Room1);
		}
		draw_set_font(font_coderscrux);
		draw_set_color(c_black);
		draw_text(408+2,128+2,global.charnames[face]);
		draw_text_ext(408+2,160+2,global.chardescs[face],16,300);
		draw_text_ext(488+2,260+2,global.charabilities[(face*3),0],16,250);
		draw_text_ext(488+2,280+2,global.charabilities[(face*3),1],16,250);
		draw_text_ext(488+2,360+2,global.charabilities[(face*3+1),0],16,250);
		draw_text_ext(488+2,380+2,global.charabilities[(face*3+1),1],16,250);
		draw_text_ext(488+2,460+2,global.charabilities[(face*3+2),0],16,250);
		draw_text_ext(488+2,480+2,global.charabilities[(face*3+2),1],16,250);
		draw_set_color(c_white);
		draw_text(408,128,global.charnames[face]);
		draw_text_ext(408,160,global.chardescs[face],16,300);
		draw_text_ext(488,260,global.charabilities[(face*3),0],16,250);
		draw_text_ext(488,280,global.charabilities[(face*3),1],16,250);
		draw_text_ext(488,360,global.charabilities[(face*3+1),0],16,250);
		draw_text_ext(488,380,global.charabilities[(face*3+1),1],16,250);
		draw_text_ext(488,460,global.charabilities[(face*3+2),0],16,250);
		draw_text_ext(488,480,global.charabilities[(face*3+2),1],16,250);
	}

	xx++;
	if(xx == 3){
		xx = 0;
		yy++;
	}
}