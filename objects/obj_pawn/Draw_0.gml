/// @description A piece of code.
// Written by Jacob.


if(!dead){
	draw_self();
	draw_sprite_part(spr_hpbarfill,0,0,0,44*(hp/maxhp),8,x-21,y-sprite_height-9);
	draw_sprite(spr_hpborder,0,x-22,y-sprite_height-10);
}else{
	draw_sprite(spr_grave,graveid,x,y);
}

//draw_text(0,0,failsafe_timer);
//draw_text(x,y-20,status.oiled);

status.drawStatus(self);