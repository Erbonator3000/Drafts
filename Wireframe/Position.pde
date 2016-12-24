class Position{
float x;
float y;
float z;
  
Position(float X,float Y,float Z){
  x=X;
  y=Y;
  z=Z;
}

Position copy(){
  return new Position(x, y, z);
}

void move(float dx, float dy, float dz){
  x+=dx;
  y+=dy;
  z+=dz;
}

void move(Position pos){
  x+=pos.x;
  y+=pos.y;
  z+=pos.z;
}

Position moved(float dx, float dy, float dz){
  return new Position(x+dx, y+dy, z+dz);
}

void moveTo(float dx, float dy, float dz){
  x=dx;
  y=dy;
  z=dz;
}

Position relativeTo(Position pos){
  return new Position(x-pos.x, y-pos.y, z-pos.z);
}

float dot(Position pos){ //vector dot product
  return x*pos.x+y*pos.y+x*pos.z;
}

float length(){
return sqrt(pow(x,2)+pow(y,2)+pow(z,2));
}

}