/* @Manan Vyas 
 * Create a 3D model of a flag imported from its JPED in 2d
 * And then simulate the interaction of the flag with wind and normal forces
 */
 
int numa = 40;
int numb = 21;
int elementWidth = 10;
PVector[][] X = new PVector[numa][numb];
PVector[][] V = new PVector[numa][numb];
PVector[][] F = new PVector[numa][numb];
float k = 0.1;
float c = 0.01;
float gravity = 0.01;
float wind = 0.01;
PVector[] constraint = new PVector[numb];
boolean flagBool = false;
PImage flag;

void setup()
{
  size(520,400,P3D);
  flag = loadImage("india.jpg");
  reset();
  setupConstraint();
}

void draw()
{
  background(0);
  physics();
  lights();
  drawSheet();
}

void keyPressed()
{
  /*
  if (key==' ')
  {
    if (flagBool == false)
    {
      flag = loadImage("usa.jpg");
      flagBool = true;
    }
    else
    {
      flag = loadImage("uk.jpg");
      flagBool = false;
    }
  }
  */
  
  if (key == 'g' || key == 'G') gravity+=0.025 ;
  if (key == 'w' || key == 'W') wind+=0.025 ;
  
  if (key == 'u' || key == 'U') 
  {
    flag = loadImage("usa.jpg");
  }
  
  if (key == 'e' || key == 'E') 
  {
    flag = loadImage("uk.jpg");
  }
  
}
