rot++;
momentum -= grav;
yoffset += momentum;

if(yoffset <= 0){
	instance_destroy();
}

depth = -y;