
// Coursera- Creative Programming
// @author : Manan Vyas
// Email: mananvvyas@gmail.com <mvyas@usc.edu>

// Simulate gravitational forces and collisions between bodies of different size and shapes


//Setup method to initialze everything 
void setup() 
{
	size(800,500);
	smooth();
	frameRate(30);  //30fps
	background(0);  // black background
	maxMass = height/2;   // Set by trial error , this value gave better perceptual results (IMO)
	visualWeight = 0;
	colorMode(HSB);
}


// Initialize global variables
int limit = 20; //max number of satellites 
int current = 0;
boolean rebound = true;
float acceleration = 0.00004;
int initialMass = 3;
float friction = 0.8;
float gravity = 0.0;
int maxMass;
boolean collisions = true;
float visualWeight;
float maxVisualWeight = 500.0;
boolean backgroundOn = true;
int mouseIx, mouseIy, mouseFx, mouseFy;


// Satellite data structures
Satellite[] S = new Satellite[limit];

 
void draw() 
{
    if (backgroundOn==true) 
    {
      noStroke();
      fill(0,132);
      rect(0,0,width,height);
    }
    for (int i=0;i<current;i++) 
    {
		for (int j=0;j<current; j++) 
		{
			if (i!=j) 
			{
			  float angle = atan2(S[j].yPos-S[i].yPos,S[j].xPos-S[i].xPos);
			  float radius = dist(S[i].xPos,S[i].yPos,S[j].xPos,S[j].yPos);
			  if (radius-2 > (S[i].mass+S[j].mass)/2) 
			  {
					float xForce = cos(angle)*acceleration*((S[j].trueMass*S[i].trueMass)/radius);
					float yForce = sin(angle)*acceleration*((S[j].trueMass*S[i].trueMass)/radius);
					S[i].xSpeed += xForce/S[i].trueMass;
					S[i].ySpeed += yForce/S[i].trueMass;
			  } 
			  else 
			  {
					PVector collision = new PVector(S[i].xPos+(cos(angle)*(S[i].mass/2)),S[i].yPos+(sin(angle)*(S[i].mass/2)));
					stroke(255,S[i].mass,255);
					strokeWeight(8);
					point(collision.x,collision.y);
					if (collisions == true) 
					{
					   S[i].collision(S[j],angle);
					}
			  }
			}
		}
    }
     
    for (int j=0;j<=maxMass;j++) 
    {
		for (int i=0;i<current;i++) 
		{
			if (S[i].mass==j) 
			{
			  S[i].update();
			}
		}
    }

    if (mousePressed==true) 
    {
      strokeWeight(2);
      if (mouseButton == RIGHT) 
      {
			if (current<limit-1 && visualWeight + initialMass <= maxVisualWeight) 
			{
				  Satellite potentialSatellite = new Satellite(initialMass,mouseX,mouseY,0,0);
				  if (spaceTaken(potentialSatellite) == false) 
				  {
					stroke(255);
				  } 
				  else 
				  {
					stroke(255,255,255);
				  }
			} 
			else   
			{
				stroke(255,255,255);
			}
			line(mouseIx,mouseIy,mouseX,mouseY);
      } 
      else if (mouseButton == LEFT) 
      {
         float angle = atan2(mouseY-mouseIy,mouseX-mouseIx);
         float radius = dist(mouseIx,mouseIy,mouseX,mouseY);
         float weightedRadius = constrain(radius,initialMass,maxMass);
         float xCentre = mouseIx + cos(angle)*(constrain(radius,1,maxMass)/2);
         float yCentre = mouseIy + sin(angle)*(constrain(radius,1,maxMass)/2);
         strokeWeight(weightedRadius);
         if (current<limit-1 && visualWeight + weightedRadius <= maxVisualWeight) 
         {
            Satellite potentialSatellite = new Satellite((int)weightedRadius,xCentre,yCentre,0,0);
            if (spaceTaken(potentialSatellite) == false) 
            {
              stroke(255);
            } 
            else 
            {
              stroke(255,255,255);
            }
        } 
        else 
        {
          stroke(255,255,255);
        }
        point(xCentre,yCentre);
      }
  } 
}

// Satellite class
class Satellite 
{
	int mass;
	float xPos, yPos, xSpeed, ySpeed, trueMass, prevXspeed, prevYspeed, addXspeed, addYspeed;
	
	Satellite(int m, float x, float y, float sx, float sy) 
	{
		mass = m;
		xPos = x;
		yPos = y;
		xSpeed = sx;
		ySpeed = sy;
		trueMass = (4/3)*PI*pow(mass,3);
		prevXspeed = xSpeed;
		prevYspeed = ySpeed;
		addXspeed = 0;
		addYspeed = 0;
	}

	// update method   
	void update() 
	{
		xSpeed += addXspeed;
		ySpeed += addYspeed;
		ySpeed += gravity;
		addXspeed = 0;
		addYspeed = 0;
		if (rebound==true) 
		{
			if (xPos+xSpeed-(mass/2)<=0 || xPos+xSpeed+(mass/2)>=width)
			{
			  xSpeed *= -1*friction;
			  ySpeed *= friction;
			}
			if (yPos+ySpeed-(mass/2)<=0 || yPos+ySpeed+(mass/2)>=height)
			{
				if (gravity != 0 && ySpeed < 3*abs(gravity)) 
				{
					ySpeed = 0;
					xSpeed *= friction;        
				} 
				else 
				{
					ySpeed *= -1*friction;
					xSpeed *= friction;
				}
			}
		}
	 
		xPos += xSpeed;
		yPos += ySpeed;
		 
		if (rebound==false)
		{
			if (xPos>width) 
			{
			  xPos -= width;
			} 
			else if (xPos<0) 
			{
			  xPos += width;
			}
			if (yPos>height) 
			{
			  yPos -= height;
			} 
			else if (yPos<0) 
			{
			  yPos += height;
			}
		}
		
		for (int i=0;i<=mass;i++) 
		{
		  strokeWeight(mass-i);
		  stroke(map(mass,initialMass,maxMass,20,255),155,map(i+1,0,mass,60,255));
		  point(xPos,yPos);
		}
		prevXspeed = xSpeed - addXspeed;
		prevYspeed = ySpeed - addYspeed;
	}
	//*end of update method
   
	// method for collisions 
	void collision(Satellite j, float a) 
	{
 
		Satellite J = j;
		float angle = a;
		 
		float angleJ = atan2(yPos-J.yPos,xPos-J.xPos);
		float inSpeedMagnitudeJ = dist(0,0,J.prevXspeed,J.prevYspeed);
		float inSpeedAngleJ = atan2(J.prevYspeed,J.prevXspeed);
		 
		if (rebound==true) 
		{
			if (J.xPos-(J.mass/2)<=0 || J.xPos+(J.mass/2)>=width)
			{
				if (inSpeedAngleJ < PI) 
				{
					inSpeedAngleJ = PI-inSpeedAngleJ;
				} 
				else 
				{
					inSpeedAngleJ = PI+TWO_PI-inSpeedAngleJ;
				}
			}
			if (J.yPos-(J.mass/2)<=0 || J.yPos+(J.mass/2)>=height)
			{
				if (inSpeedAngleJ > HALF_PI && inSpeedAngleJ < PI+HALF_PI) 
				{
					inSpeedAngleJ = TWO_PI-inSpeedAngleJ;
				}
				else 
				{
					inSpeedAngleJ = TWO_PI-inSpeedAngleJ;
				}  
			}
		}
		 
		float colliderAngleJ = inSpeedAngleJ - angleJ;
		float inSpeedMagnitude = dist(0,0,prevXspeed,prevYspeed);
		float inSpeedAngle = atan2(prevYspeed,prevXspeed);
		float colliderAngle = inSpeedAngle - angle;
		float velI = cos(colliderAngle)*inSpeedMagnitude;
		float velJ = cos(colliderAngleJ)*inSpeedMagnitudeJ*-1;  
		float colliderSpeedX = (velI*(trueMass-J.trueMass)+2*J.trueMass*velJ)/(trueMass+J.trueMass);
		 
		float colliderSpeedY = sin(colliderAngle)*inSpeedMagnitude;
		float outSpeedAngle = atan2(colliderSpeedY,colliderSpeedX)+angle;
		float outSpeedMagnitude = dist(0,0,colliderSpeedX,colliderSpeedY);
	 
		addXspeed += cos(outSpeedAngle)*outSpeedMagnitude - prevXspeed;
		addYspeed += sin(outSpeedAngle)*outSpeedMagnitude - prevYspeed;
         
	}
  //*end of collison method 
}
//*end of class Satellite

//Find if Space is taken or not on the sketch 
boolean spaceTaken(Satellite a) 
{
  boolean result = false;
  for (int j=0;j<current; j++) 
  {
      float radius = dist(a.xPos,a.yPos,S[j].xPos,S[j].yPos);
      if (radius-2 <= (a.mass+S[j].mass)/2) 
      {
      result = true;
      j = current;
    }
  }
  return result;
}

boolean mouseIsIn() 
{ 
  if (mouseX>=0 && mouseX<=width && mouseY>=0 && mouseY<=height) 
  {
    return true;
  } 
  else 
  {
    return false;
  } 
}

 
// Record current co-ordinates of mouse 
void mousePressed() 
{
    mouseIx = mouseX;
    mouseIy = mouseY;
}

// Generates a circular body depending upon how far the mouse is dragged 
void mouseReleased() 
{
  if (current<limit-1) 
  {
		mouseFx = mouseX;
		mouseFy = mouseY;
		float angle = atan2(mouseFy-mouseIy,mouseFx-mouseIx);
		float radius = dist(mouseIx,mouseIy,mouseFx,mouseFy);
		float weightedRadius = constrain(radius,initialMass,maxMass);
		if (mouseButton == LEFT && visualWeight + weightedRadius <= maxVisualWeight) 
		{
		  float xCentre = mouseIx + cos(angle)*(weightedRadius/2);
		  float yCentre = mouseIy + sin(angle)*(weightedRadius/2);
		  if (xCentre+(constrain(radius,1,maxMass)/2)>width) 
		  {
			  xCentre -= xCentre+(weightedRadius/2)-width;
		  } 
		  else if (xCentre-(weightedRadius/2)<0) 
		  {
			  xCentre -= xCentre-(weightedRadius/2);
		  }
		  if (yCentre+(constrain(radius,1,maxMass)/2)>height) 
		  {
			  yCentre -= yCentre+(weightedRadius/2)-height;
		  } 
		  else if (yCentre-(weightedRadius/2)<0) 
		  {
			  yCentre -= yCentre-(weightedRadius/2);
		  }
		  Satellite potentialSatellite = new Satellite((int)weightedRadius,xCentre,yCentre,0,0);
		  if (spaceTaken(potentialSatellite) == false) 
		  {
			  S[current] = potentialSatellite;
			  visualWeight += S[current].mass;
			  current++;
		  }
		} 
		else if (mouseButton == RIGHT  && mouseIsIn() && visualWeight + initialMass <= maxVisualWeight) 
		{
		  float xMouse = cos(angle)*radius*0.1;
		  float yMouse = sin(angle)*radius*0.1;
		  Satellite potentialSatellite = new Satellite(initialMass,mouseX,mouseY,xMouse,yMouse);
		  if (spaceTaken(potentialSatellite) == false) 
		  {
			  S[current] = potentialSatellite;
			  visualWeight += S[current].mass;
			  current++;
		  }
		}
    }
}



