// Normal forces in the flags surfaces due to wind's action forces and the corresponding 'friction'
// Manan Vyas

void normalForce(int i, int j)
{
  int a = i+1;
  int b = j;
  force2(i,j,a,b,1);
  a = i-1;
  b = j;
  force2(i,j,a,b,1);
  a = i;
  b = j+1;
  force2(i,j,a,b,1);
  a = i;
  b = j-1;
  force2(i,j,a,b,1);
  a = i+1;
  b = j+1;
  force2(i,j,a,b,pow(2,0.5));
  a = i-1;
  b = j+1;
  force2(i,j,a,b,pow(2,0.5));
  a = i+1;
  b = j-1;
  force2(i,j,a,b,pow(2,0.5));
  a = i-1;
  b = j-1;
  force2(i,j,a,b,pow(2,0.5));
  boolean jump = true;
  if (jump == true)
  {
    int jumper = 2;
    a = i+jumper;
    b = j;
    force2(i,j,a,b,jumper);
    a = i-jumper;
    b = j;
    force2(i,j,a,b,jumper);
    a = i;
    b = j+jumper;
    force2(i,j,a,b,jumper);
    a = i;
    b = j-jumper;
    force2(i,j,a,b,jumper);
    a = i+jumper;
    b = j+jumper;
    force2(i,j,a,b,jumper*pow(2,0.5));
    a = i-jumper;
    b = j+jumper;
    force2(i,j,a,b,jumper*pow(2,0.5));
    a = i+jumper;
    b = j-jumper;
    force2(i,j,a,b,jumper*pow(2,0.5));
    a = i-jumper;
    b = j-jumper;
    force2(i,j,a,b,jumper*pow(2,0.5));
  }
}

void force2(int i,int j,int a,int b,float distMult)
{
  float eW2 = elementWidth * distMult;
  if ((a>=0)&&(b>=0)&&(a<numa)&&(b<numb))
  {
    PVector dx = PVector.sub(X[a][b], X[i][j]);
    float bufferWidth = 0.01 * elementWidth;
    float delta = 0;
    if ((dx.mag() < eW2 - bufferWidth/2)||
			(dx.mag() > eW2 + bufferWidth/2))
	{
      delta = abs(dx.mag() - eW2)
                   - bufferWidth/2;
    }
    int sighn = 0;
    if (dx.mag() < eW2 - bufferWidth/2)
	{
      sighn = -1;
    }
	else if (dx.mag() > eW2 + bufferWidth/2)
	{
      sighn = +1;
    }
    dx.normalize();
    float v1 = dx.dot(V[i][j]);
    float v2 = dx.dot(V[a][b]);
    float dv = v2 - v1;
    float fmag = k * delta * sighn + c * dv;
    PVector df = PVector.mult(dx,fmag);
    F[i][j].add(df);
    F[a][b].sub(df);
  }
}
