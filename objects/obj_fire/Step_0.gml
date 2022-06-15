var scaleto = 1;

if(firetime <= 0){
	scaleto = 0.6;
}
if(dead){
	scaleto = 0;
}
scale = lerp(scale,scaleto,0.02);
// TO-DO: Fire sprite for tiny fire
if(scale < 0.05){
	instance_destroy(self);
}

image_yscale = scale+sin(current_time/200)*0.2
image_xscale = scale;
depth = -y;