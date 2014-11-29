// Wind Forces ... follows the right hand rule
// Manan Vyas

void windForce(int i,int j)
{
  // NOTE: vector selected based on right hand rule
  int a = i+1;
  int b = j;
  int c = i;
  int d = j+1;
  wind2(i,j,a,b,c,d);
  a = i;
  b = j+1;
  c = i-1;
  d = j;
  wind2(i,j,a,b,c,d);
  a = i-1;
  b = j;
  c = i;
  d = j-1;
  wind2(i,j,a,b,c,d);
  a = i;
  b = j-1;
  c = i+1;
  d = j;
  wind2(i,j,a,b,c,d);
}

void wind2(int i,int j,int a,int b,int c,int d)
{
  PVector windV = new PVector(wind,0.0,0.0);
  if ((a>=0)&&(b>=0)&&(a<numa)&&(b<numb))
  {
    if ((c>=0)&&(d>=0)&&(c<numa)&&(d<numb))
	{
      PVector ab = PVector.sub(X[a][b], X[i][j]);
      PVector cd = PVector.sub(X[c][d], X[i][j]);
      PVector un = ab.cross(cd);
      un.normalize();
      float fmag = un.dot(windV);
      F[i][j].add(PVector.mult(un,fmag));
    }
  }
}
