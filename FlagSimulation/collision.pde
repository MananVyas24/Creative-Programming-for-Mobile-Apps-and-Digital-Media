/*
 * Code to handle wind flag collisions
 * Author: Manan Vyas
 */

int[][] slate = new int[numa*numb][2];
int nodeCount = 0;

void collisionSetup()
{
  for (int i=0; i<numa; i++)
  {
    for (int j=0; j<numb; j++)
	{
      slate[nodeCount][0] = i;
      slate[nodeCount][1] = j;
      nodeCount++;
    }
  }
}

boolean hasBeen = false;

void collide()
{
	float bumpRad = elementWidth * 1.5;
	if (hasBeen == false)
	{
		collisionSetup();
		hasBeen = true;
	}
	  
	  for (int i=1; i<nodeCount; i++)
	  {
		for (int j=0; j<i; j++)
		{
			if (testAdjacency(i,j))
			 {
				PVector dx = PVector.sub(X[slate[j][0]][slate[j][1]],
										 X[slate[i][0]][slate[i][1]]);
				if (abs(dx.x)<bumpRad)
				{
					 if (abs(dx.y)<bumpRad)
					{
						if (abs(dx.z)<bumpRad)
						{
							if (dx.mag()<bumpRad)
							{
								float delta = (bumpRad - dx.mag()) * k;
								dx.normalize();
								F[slate[j][0]][slate[j][1]].add(PVector.mult(dx,delta));
								F[slate[i][0]][slate[i][1]].sub(PVector.mult(dx,delta));
							}
						}
					}
				}
			}
		}
	}
}

boolean testAdjacency(int i,int j)
{
	  int a = slate[i][0];
	  int b = slate[i][1];
	  int c = slate[j][0];
	  int d = slate[j][1];
	  boolean val = false;
	  if (((abs(a-c)<2)&&(abs(b-d)<2))==false)
	  {
			val = true;
	  }
	  return val;
}
