
float magnify = 300; // This is how big we want the rose to be.
float rotation = 0; // rotation : this is basically how far round the circle we are going to go
float radius = 0; // radius : this is basically how far from the origin we are.
int elements = 256;// This is the number of points and lines we will calculate at once. 1000 is alot actually. 

void setup() 
{
    //iPad portrait. Swap the numbers for landscape. 
    size(768,1024);
    rectMode(CENTER);
    colorMode(HSB);
}
 
void draw() 
{
    background(0);
    radius = map(mouseX, 0, width, 0, 10);
    rotation = map(mouseY, 0, height, 0, 10);
    float spacing = TWO_PI/elements; // this is how far apart each 'node' will be - study it. 
    translate(width*0.5,height*0.5);// we translate the whole sketch to the centre of the screen, so 0,0 is in the middle.
    noFill();
    strokeWeight(2);
    for (int i = 0; i < elements;i++) 
    {
        stroke(i*2,255,255);
        pushMatrix();
        rotate(spacing*i*rotation);
        translate(sin(spacing*i*radius)*magnify, 0);
        ellipse(0,0,20,20);
        popMatrix();
    }
}

