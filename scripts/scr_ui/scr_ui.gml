// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_ui(){

}

function draw_text_shadowed(x,y,string){
	draw_set_color(c_black);
	draw_text(x+2,y+2,string);
	draw_set_color(c_white);
	draw_text(x,y,string);
}

function draw_text_shadowed_ext(x,y,string,sep,w){
	draw_set_color(c_black);
	draw_text_ext(x+2,y+2,string,sep,w);
	draw_set_color(c_white);
	draw_text_ext(x,y,string,sep,w);
}

function draw_rectangle_shadowed(x1,y1,x2,y2,outline){
	draw_set_color(c_black);
	draw_rectangle(x1+2,y1+2,x2+2,y2+2,outline);
	draw_set_color(c_white);
	draw_rectangle(x1,y1,x2,y2,outline);
}