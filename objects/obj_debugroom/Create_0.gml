/// @description A piece of code.
// Written by Jacob.

gui = new GUI();

text = new GUI_Text(gui,room_width/2,5,"Welcome to the debug room of independent doom.\n(Do not overstay your welcome)");
text.setAll(font_express,c_red,fa_middle,fa_top);
text.setShadow(#1439a8);

scroll = new GUI_Scrollable(gui,90,100,false);
text = new GUI_Text(scroll,0,-20,"Try scrolling.");
haha = new GUI_Text(scroll,2000,-20,"Good job.");
text.setFont(font_squarecakes); haha.setFont(font_squarecakes);

for(var xx = 0; xx < 3; xx++){
	var thing = new GUI_Button(scroll,xx*96,0,spr_debugroom_icon1);
	thing.setSprites(spr_debugroom_icon1,spr_debugroom_icon2,spr_debugroom_icon3);
	thing.func = function(){
		audio_play_sound(sou_laugh,0,false);
	}
	var thingtext = new GUI_Text(thing,48/2,44,"Test\nButton\n" + string(xx) + ".");
	thingtext.halign = fa_center;
	
}

infotext = new GUI_Text(gui,room_width-48,room_height,"Press any key to go to menu.");
infotext.setAligns(fa_right,fa_bottom);

audio_play_sound(mus_secretdebugsong,10,true);