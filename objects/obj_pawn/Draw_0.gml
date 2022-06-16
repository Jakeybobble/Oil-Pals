/// @description A piece of code.
// Written by Jacob.

if(!dead){
	if(animating){
		anim.yscale = image_yscale;
		anim.draw(sprite_index,image_index);
		if(anim.showbar){
			draw_sprite_part_ext(spr_hpbarfill,0,0,0,44*(hp/maxhp),8,anim.x-21,anim.y-sprite_height-9,anim.xscale,anim.yscale,c_white,anim.alpha);
			draw_sprite_ext(spr_hpborder,0,anim.x-22,anim.y-sprite_height-10,anim.xscale,anim.yscale,anim.rot,c_white,anim.alpha);
		}
	}else{
		draw_self();
		draw_sprite_part(spr_hpbarfill,0,0,0,44*(hp/maxhp),8,x-21,y-sprite_height-9);
		draw_sprite(spr_hpborder,0,x-22,y-sprite_height-10);
	}
}else{
	draw_sprite(spr_grave,graveid,x,y);
}

//draw_text(0,0,failsafe_timer);
//draw_text(x,y-20,status.oiled);

status.drawStatus(self);

//draw_text(x,y-10,isPlayer());