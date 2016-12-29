
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
Graphic[] graphs;

Cube cube;
Plane plane;
TriangleMesh mesh;





void setup(){
  camPosition = new Position(0, 0, 0);
  points[0] = new Position(1,0, 0);
  size(480, 480);
  noSmooth();

  cube = new Cube(new Position(6,0,0),2);
  plane = new Plane(0,0,-1);
  
 // mesh = new TriangleMesh();
  
  
  
  graphs = new Graphic[2];
  graphs[0]=cube;
  graphs[1]=plane;
  
  

}



void draw(){
  
  if(mousePressed){
    rotationX+=(pmouseX-mouseX)*4*fov/screenX;
    
  }
  
  if(keyPressed){
    switch(key){
      //walking
    case  'w': camPosition.move(speed*cos(rotationZ), speed*sin(rotationZ),0); break;
    case  's': camPosition.move(-speed*cos(rotationZ), -speed*sin(rotationZ),0); break;
    case  'a': camPosition.move(-speed*sin(rotationZ), speed*cos(rotationZ),0); break;
    case  'd': camPosition.move(speed*sin(rotationZ), -speed*cos(rotationZ),0); break;  
      //free camera movement
    case  't': camPosition.move(speed*cos(rotationZ)*cos(rotationY), speed*sin(rotationZ)*cos(rotationX),speed*sin(-rotationY)*cos(rotationX)); break;//print(rotationZ);
    case  'g': camPosition.move(-speed*cos(rotationZ)*cos(rotationY), -speed*sin(rotationZ)*cos(rotationX),-speed*sin(-rotationY)*cos(rotationX)); break;
    case  'f': camPosition.move(-speed*sin(rotationZ)*cos(rotationY), speed*cos(rotationZ)*cos(rotationX),speed*cos(rotationY)*sin(rotationX)); break;
    case  'h': camPosition.move(speed*sin(rotationZ)*cos(rotationY), -speed*cos(rotationZ)*cos(rotationX),-speed*cos(rotationY)*sin(rotationX));break;
    case  'b': camPosition.move(speed*sin(rotationY)*cos(rotationZ),speed*sin(-rotationX)*cos(rotationZ), speed*cos(rotationX)*cos(rotationY)); break;
    case  'n': camPosition.move(-speed*sin(rotationY)*cos(rotationZ), -speed*sin(-rotationX)*cos(rotationZ), -speed*cos(rotationX)*cos(rotationY)); break;
      //camera rotation
    case  'u':rotationX+=speed; break;
    case  'o':rotationX-=speed; break;
    case  'i':rotationY+=speed; break;
    case  'k':rotationY-=speed; break;
    case  'j':rotationZ+=speed; break;
    case  'l':rotationZ-=speed; break;
    //world rotation?
    //reset
    case  'q': camPosition.moveTo(0,0,0);rotationZ=0;rotationX=0;rotationY=0;
    }
    print(" x:"+camPosition.x+ " y: "+ camPosition.y+ " z: "+camPosition.z + "\n");
  }
  
  while(rotationX>=2*PI) rotationX-=2*PI;
  while(rotationX<0) rotationX+=2*PI;
  
  //free rotation
  //while(rotationY>=2*PI) rotationY-=2*PI;
  //while(rotationY<0) rotationY+=2*PI;  
  
  if(rotationY>PI/2) rotationY=PI/2;
  else if(rotationY<-PI/2) rotationY=-PI/2;
  
  while(rotationZ>=2*PI) rotationZ-=2*PI;
  while(rotationZ<0) rotationZ+=2*PI;  
  
  
  background(0, 0, 0);
  stroke(255);
  
  for(int i=0; i<graphs.length;i++){
    wires=graphs[i].getWires();
    for(int j=0; j<wires.length;j++){
      Position camPosStart = toCamCoords(wires[j].start);
      Position camPosEnd = toCamCoords(wires[j].end);
      if(camPosStart.x>0 && camPosEnd.x>0){ //some filtering to get rid of some ghost lines and for efficiency
        Position drawPosStart = pointOnCanvas(camPosStart);  
        Position drawPosEnd = pointOnCanvas(camPosEnd);
        line(drawPosStart.x, drawPosStart.y, drawPosEnd.x, drawPosEnd.y);
      }
    }
  }
}


void camRotation(float rx, float ry, float rz){
Position direction = new Position(cos(rotationZ)*cos(rotationY), sin(rotationZ)*cos(rotationX),sin(-rotationY)*cos(rotationX)); //vector of camera x-axis
//rotating aroun x-axis
float Rz = acos(direction.x/direction.length());
float Ry = acos(direction.z/direction.length());




}




Position toCamCoords(Position pos){
  Position rPos = pos.relativeTo(camPosition);
  //calculating rotation
  float rx=rPos.x;
  float ry=rPos.y;
  float rz=rPos.z;
  
  //rotation z-axis
  rx=rPos.x;
  ry=rPos.y;
  rPos.x=rx*cos(-rotationZ)-ry*sin(-rotationZ);
  rPos.y=rx*sin(-rotationZ)+ry*cos(-rotationZ);
  
  //rotation y-axis
  rx=rPos.x;
  rz=rPos.z;
  rPos.x=rx*cos(-rotationY)+rz*sin(-rotationY);
  rPos.z=rz*cos(-rotationY)-rx*sin(-rotationY);
  
  //rotation x-axiz
  ry=rPos.y;
  rz=rPos.z;
  rPos.y = ry*cos(-rotationX)-rz*sin(-rotationX);
  rPos.z = ry*sin(-rotationX)+rz*cos(-rotationX);



  return rPos;
}

Position pointOnCanvas(Position pos){//z coordinate to describe the point size or something(total distance)[not yet implemented]... or just zero
    return new Position(screenX/2-arctan(pos.x, pos.y)*screenX/fov, screenY/2-arctan(pos.x, pos.z)*screenX/fov, 0);
}

float arctan(float x, float y){ //helper to get rid of ghostlines of objects behind you
  if(x>0)  
    return atan(y/x)/cos(atan(y/x));
  else if(y>0)
    return PI/2+asin(y/sqrt(pow(x,2)+pow(y,2)));
  else if(y<0)
    return -PI/2-atan(x/y); 
  else if(x<0 && y==0)
    return PI;
  else if(x<0)
    return PI+atan(y/x);
  else 
    return 0; 
}