//The MIT License (MIT) - See Licence.txt for details


void setup()
{
	  size(640, 480);
	  background(255);  
}

void mouseDragged()
{
	line(pmouseX, pmouseY, mouseX, mouseY);
}
