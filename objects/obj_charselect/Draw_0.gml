var xx = 0;
var yy = 0;
var s = sin(current_time/200)*15;

while(xx != 3 and yy != 3){
	draw_sprite_ext(spr_testface2,xx+(yy*3),64+128*xx,164+128*yy,2,2,s,c_white,1);
	xx++;
	if(xx == 3){
		xx = 0;
		yy++;
	}
}