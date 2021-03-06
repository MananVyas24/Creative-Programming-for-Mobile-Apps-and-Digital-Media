/*
 * This doesn't use any trigonometry (no sin, cos or tan stuff, and no PI), but has a very similar affect.
 * It uses a value I've called 'time' to keep things moving round. Have a play with it. 
 */
 
 
float time = 0; /* This is going to function as a clock. We'll update it with a value every time a frame gets drawn*/
 
void setup() 
{
    size(512,512);/* setup the size */
    frameRate(25);/* This sets the current frameRate */
}
 
void draw() 
{	
    /* this does the drawing once per frame */
    background(255); /* clear the screen with white */
    translate(width*0.5,height*0.5); /* translate all the drawing to the middle of the screen */
    noFill(); /*stop the computer filling in shapes*/
    time=time+0.01; /* update the value in the variable 'time'. This means that we add 1 to 'time' every frame */
    for (int i = 0;i < 20; i++) 
    { 
        /* this for loop organises the drawing. It will do the drawing 20 times (between 0 and 19)  */
        rotate(time); /* rotate the coordinate system a bit */
        rect(i,i,i*5,i*5); 
        /* this is the actual drawing.
            This says 'Draw a line, starting from i,i (x and y location), and being of size i*5 in both width and depth
            because it's in a for loop, it gets 'called' (used) 20 times, with a different value for 'i' each time 
        */

  }
}
