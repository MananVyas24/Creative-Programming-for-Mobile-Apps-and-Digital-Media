// SUBS
// Manan Vyas

void reset()
{
	for (int i=0; i<numa; i++)
	{
		for (int j=0; j<numb; j++)
		{
			X[i][j] = new PVector(elementWidth * (i)+width/8, elementWidth * (j)+height/8, random(-0.1,0.1));
			V[i][j] = new PVector();
		}
	}
}
void physics()
{
	for (int i=0; i<numa; i++)
	{
		for (int j=0; j<numb; j++)
		{
			F[i][j] = new PVector(0.0,gravity,0.0);
		}
	}
	for (int i=0; i<numa; i++)
	{
		for (int j=0; j<numb; j++)
		{
			normalForce(i,j);
			windForce(i,j);
		}
	}
	// collision call once we have wind and the normal forces setup
	collide();
	for (int i=0; i<numa; i++)
	{
		for (int j=0; j<numb; j++)
		{
			V[i][j].add(F[i][j]);
			X[i][j].add(V[i][j]);
		}
	}
	useConstraint();
}

// render
void drawSheet()
{
  noStroke();
  for (int j=0; j<numb-1; j++)
  {
    beginShape(TRIANGLE_STRIP);
    texture(flag);
    float xtweek = 1.02;
    float ytweek = 1.05;
    for (int i=0; i<numa; i++)
	{
      vertex(X[i][j].x, X[i][j].y, X[i][j].z,
             elementWidth*i*xtweek, elementWidth*j*ytweek);
      vertex(X[i][j+1].x, X[i][j+1].y, X[i][j+1].z,
             elementWidth*i*xtweek, elementWidth*(j+1)*ytweek);      
    }
    endShape();
  }
}

void setupConstraint()
{
  for (int j=0; j<numb; j++)
  {
    constraint[j] = new PVector(X[0][j].x,
                                X[0][j].y,
                                X[0][j].z);
  }
}

void useConstraint()
{
  for (int j=0; j<numb; j++)
  {
    X[0][j] = new PVector(constraint[j].x,
                          constraint[j].y,
                          constraint[j].z);
    V[0][j] = new PVector();
  }
}
