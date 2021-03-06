
final static int screenX = 600;
final static int screenY = 480;

Position camPosition;

float rotationX = 0;
float rotationY = 0;
float rotationZ = 0;

float fov = 3*PI/8;
float speed = 0.1;

float speedX=0;
float speedY=0;
float speedZ=0;

Position[] points = new Position[1];

Wire[] wires = new Wire[4];
Graphic[] graphs;

Cube cube;
Plane plane;
TriangleMesh mesh;

WireMesh ball;
float[] ballPoint={0.3, 0.2, 0, 0.2, 0.3, 0, -0.2, 0.3, 0, -0.3, 0.2, 0, -0.2, 0.1, 0, -0.1, 0.1, 0, -0.1, -0.1, 0, -0.2, -0.1, 0,
                   -0.3, -0.2, 0, -0.2, -0.3, 0, 0.2, -0.3, 0, 0.3, -0.2, 0, 0.3, 0.2, 0,
                   0.3, 0.2, 0.1, 0.2, 0.3, 0.1, -0.2, 0.3, 0.1, -0.3, 0.2, 0.1,
                   -0.3, -0.2, 0.1, -0.2, -0.3, 0.1, 0.2, -0.3, 0.1, 0.3, -0.2, 0.1, 0.3, 0.2, 0.1};
                   



void setup(){
  camPosition = new Position(0, 0, 0);
  points[0] = new Position(1,0, 0);
  size(600, 480);
  noSmooth();

  cube = new Cube(new Position(6,0,0),2);
  plane = new Plane(0,0,-1);
  ball = new WireMesh(ballPoint);
  
 // mesh = new TriangleMesh();
 // ball.move(new Position(1,0,1));
  
  
  graphs = new Graphic[3];
  graphs[0]=cube;
  graphs[1]=plane;
  graphs[2]=ball;
  
  

}



void draw(){
  
  //if(mousePressed){
    rotationZ+=(pmouseX-mouseX)*4*fov/screenX*4;
    rotationY-=(pmouseY-mouseY)*4*fov/screenY;
  //}
  
  if(keyPressed){
    switch(key){  

      //walking
   /* case  'w': camPosition.move(speed*cos(rotationZ), speed*sin(rotationZ),0); break;
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
   */   //camera rotation
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
  camMove(speedX, speedY, speedZ);
  
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

void keyPressed(){
  switch(key){
  case 'w': speedX=speed; break;
  case 's': speedX=-speed; break;
  case 'a': speedY=speed; break;
  case 'd': speedY=-speed; break;
  }
}
void keyReleased(){
  switch(key){
  case 'w': speedX=0; break;
  case 's': speedX=0; break;
  case 'a': speedY=0; break;
  case 'd': speedY=0; break;
  }
}


void camMove(float speedx, float speedy, float speedz){
  camPosition.move(speedx*cos(rotationZ), speedx*sin(rotationZ),0);//speedx*sin(-rotationY)*cos(rotationX));
  camPosition.move(-speedy*sin(rotationZ), speedy*cos(rotationZ),0);//speedy*cos(rotationY)*sin(rotationX));
  camPosition.move(speedz*sin(rotationY)*cos(rotationZ),speedz*sin(-rotationX)*cos(rotationZ), speedz*cos(rotationX)*cos(rotationY));

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