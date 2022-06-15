// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_text_fancy_ext(xx,yy,str,color,sep,w){
	draw_set_color(c_black);
	draw_text_ext(xx-1,yy-1,str,sep,w);
	draw_text_ext(xx+1,yy-1,str,sep,w);
	draw_text_ext(xx-1,yy+1,str,sep,w);
	draw_text_ext(xx+1,yy+1,str,sep,w);
	draw_text_ext(xx-1,yy,str,sep,w);
	draw_text_ext(xx+1,yy,str,sep,w);
	draw_text_ext(xx,yy+1,str,sep,w);
	draw_text_ext(xx,yy-1,str,sep,w);
	draw_set_color(color);
	draw_text_ext(xx,yy,str,sep,w);
}