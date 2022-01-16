if(point_in_rectangle(mouse_x,mouse_y,x-150,y-32,x+150,x+32)){
	sizer = lerp(sizer,1,0.1);
}
else{
	sizer = lerp(sizer,0,0.1);
}

image_xscale = 1+sizer;
image_yscale = 1+sizer;