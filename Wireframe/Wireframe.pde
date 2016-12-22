
final static int screenX = 480;
final static int screenY = 480;

Position camPosition;

float rotationX = 0;
float rotationY = 0;
float rotationZ = 0;

float fov = 3*PI/8;
float speed = 0.1;

Position[] points = new Position[1];

Wire[] wires = new Wire[4];



Cube cube;
Plane plane;

void setup(){
  camPosition = new Position(0, 0, 0);
  points[0] = new Position(1, 0, 0);
  size(480, 480);
  noSmooth();
  
  cube = new Cube(new Position(6,0,0),2);
  plane = new Plane(0,0,-3);
  
/*  wires[1] = new Wire(5,1,-1,5,-1,-1); //old cube
  wires[2] = new Wire(5,1,1,5,1,-1);
  wires[3] = new Wire(5,-1,1,5,-1,-1);
  wires[4] = new Wire(7,1,1,7,1,-1);
  wires[5] = new Wire(7,1,-1,7,-1,-1);
  wires[6] = new Wire(7,1,1,7,-1,1);
  wires[7] = new Wire(7,-1,1,7,-1,-1);
  wires[8] = new Wire(5,1,1,7,1,1);
  wires[9] = new Wire(5,1,-1,7,1,-1);
  wires[10] = new Wire(5,-1,-1,7,-1,-1);
  wires[11] = new Wire(5,-1,1,7,-1,1*/
}



void draw(){
  
  if(mousePressed){
    rotationX+=(pmouseX-mouseX)*4*fov/screenX;
    
  }
  
  if(keyPressed){
    switch(key){
    case  'w': camPosition.move(speed*cos(rotationZ)*cos(rotationY), speed*sin(rotationZ)*cos(rotationX),speed*sin(-rotationY)*cos(rotationX)); break;//print(rotationZ);
    case  's': camPosition.move(-speed*cos(rotationZ)*cos(rotationY), -speed*sin(rotationZ)*cos(rotationX),-speed*sin(-rotationY)*cos(rotationX)); break;
    case  'a': camPosition.move(-speed*sin(rotationZ), speed*cos(rotationZ),0); break;
    case  'd': camPosition.move(speed*sin(rotationZ), -speed*cos(rotationZ),0);break;
    case  'u':rotationX+=speed; break;
    case  'o':rotationX-=speed; break;
    case  'i':rotationY+=speed; break;
    case  'k':rotationY-=speed; break;
    case  'j':rotationZ+=speed; break;
    case  'l':rotationZ-=speed; break;
    case  'q': camPosition.moveTo(0,0,0);rotationZ=0;rotationX=0;rotationY=0;
    }
    print(" x:"+camPosition.x+ " y: "+ camPosition.y+ " z: "+camPosition.z + "\n");
  }
  
  while(rotationX>=2*PI) rotationX-=2*PI;
  while(rotationX<0) rotationX+=2*PI;

  while(rotationY>=2*PI) rotationY-=2*PI;
  while(rotationY<0) rotationY+=2*PI;  
  
  while(rotationZ>=2*PI) rotationZ-=2*PI;
  while(rotationZ<0) rotationZ+=2*PI;  
  
  
  background(0, 0, 0);
  stroke(255);
  
  for(int i = 0; i<points.length; i++){
    Position drawPos = pointOnCanvas(toCamCoords(points[i]));
      point(drawPos.x, drawPos.y);
  }
  
  for(int i = 0; i<cube.wires.length; i++){
    Position drawPosStart = pointOnCanvas(toCamCoords(cube.wires[i].start));  
    Position drawPosEnd = pointOnCanvas(toCamCoords(cube.wires[i].end));
    if(i!=0)
    line(drawPosStart.x, drawPosStart.y, drawPosEnd.x, drawPosEnd.y);
  }
  /*for(int i = 0; i<plane.wires.length; i++){
    Position drawPosStart = pointOnCanvas(toCamCoords(plane.wires[i].start));  
    Position drawPosEnd = pointOnCanvas(toCamCoords(plane.wires[i].end));
    line(drawPosStart.x, drawPosStart.y, drawPosEnd.x, drawPosEnd.y);
  }*/
  
}

void mousePressed(){

}

Position toCamCoords(Position pos){
  Position rPos = pos.relativeTo(camPosition);
  //calculating rotation
  float rx=rPos.x;
  float ry=rPos.y;
  float rz=rPos.z;
  
  //rotation x-axiz
  
 // rPos.x = rx+rx*cos(rotationZ)-ry*sin(rotationZ)+rx*cos(rotationY)+rz*sin(rotationY);
  rPos.y = ry*cos(-rotationX)-rz*sin(-rotationX);
  rPos.z = ry*sin(-rotationX)+rz*cos(-rotationX);//+rz*cos(rotationY)-rx*sin(rotationY);
  //rotation y-axis
  ry=rPos.y;
  rz=rPos.z;
  rPos.x=rx*cos(-rotationY)+rz*sin(-rotationY);
  rPos.z=rz*cos(-rotationY)-rx*sin(-rotationY);
  //rotation z-axis
  rx=rPos.x;
  ry=rPos.y;
  rPos.x=rx*cos(-rotationZ)-ry*sin(-rotationZ);
  rPos.y=rx*sin(-rotationZ)+ry*cos(-rotationZ);
  return rPos;
}

Position pointOnCanvas(Position pos){//z coordinate to describe the point size or something(total distance)[not yet implemented]... or just zero
    return new Position(screenX/2-arctan(pos.x, pos.y)*screenX/fov, screenY/2-arctan(pos.x, pos.z)*screenX/fov, 0);
}

float arctan(float x, float y){ //helper to get rid of ghostlines of objects behind you
  if(x>0)  
    return atan(y/x);
  else if(y>0)
    return PI/2-atan(x/y);
  else if(y<0)
    return -PI/2-atan(x/y);  
  else if(x<0)
    return PI+atan(y/x);
  else 
    return 0; 
}