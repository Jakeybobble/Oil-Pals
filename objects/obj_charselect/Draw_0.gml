var xx = 0;
var yy = 0;
var s = sin(current_time/200)*15;

while(xx != 3 and yy != 3){
	var xpos = 64+128*xx
	var ypos = 164+128*yy;
	var face = xx+(yy*3);
	//draw_rectangle(xpos,ypos,xpos+(48*2),ypos+(48*2),true);
	draw_sprite_ext(spr_testface2,face,xpos,ypos,2,2,s,c_white,1);
	if(mouse_check_button_pressed(mb_left)){
		if(point_in_rectangle(mouse_x,mouse_y,xpos-48,ypos-48,xpos+(48*2)-48,ypos+(48*2)-48)){
			
			ds_list_add(global.roster,global.friendlies[face]);
			room_goto(Room1);
		
		}
	}
	
	xx++;
	if(xx == 3){
		xx = 0;
		yy++;
	}
}