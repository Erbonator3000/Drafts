
final static int screenX = 480;
final static int screenY = 480;

Position camPosition;
float direction = PI/16; //first just turnig with z-axis
float fov = 3*PI/8;
float speed = 0.1;

Position[] points = new Position[1];

Wire[] wires = new Wire[12];

float mouseBeginX;
float mouseBeginY;
float startDirection;

void setup(){
  camPosition = new Position(0, 0, 0);
  points[0] = new Position(1, 0, 0);
  size(480, 480);
  noSmooth();
  
  wires[0] = new Wire(5,1,1,5,-1,1);
  wires[1] = new Wire(5,1,-1,5,-1,-1);
  wires[2] = new Wire(5,1,1,5,1,-1);
  wires[3] = new Wire(5,-1,1,5,-1,-1);
  wires[4] = new Wire(7,1,1,7,1,-1);
  wires[5] = new Wire(7,1,-1,7,-1,-1);
  wires[6] = new Wire(7,1,1,7,-1,1);
  wires[7] = new Wire(7,-1,1,7,-1,-1);
  wires[8] = new Wire(5,1,1,7,1,1);
  wires[9] = new Wire(5,1,-1,7,1,-1);
  wires[10] = new Wire(5,-1,-1,7,-1,-1);
  wires[11] = new Wire(5,-1,1,7,-1,1);
}



void draw(){
  
  if(mousePressed){
    direction=startDirection+(mouseX-mouseBeginX)*fov/screenX;
  }
  
  if(keyPressed){
    switch(key){
    case  'w': camPosition.move(speed*cos(direction), speed*sin(direction),0); break;//print(direction);
    case  's': camPosition.move(-speed*cos(direction), -speed*sin(direction),0); break;
    case  'a': camPosition.move(speed*cos(direction+PI/2), speed*sin(direction+PI/2),0);print(camPosition.y); break;
    case  'd': camPosition.move(speed*cos(direction-PI/2), speed*sin(direction-PI/2),0); break;
    case  'q': camPosition.moveTo(0,0,0);direction=0;
    }
  }
  while(direction>=2*PI) direction-=2*PI;
  while(direction<0) direction+=2*PI;
  background(0, 0, 0);
  stroke(255);
  
  for(int i = 0; i<points.length; i++){
    Position drawPos = pointOnCanvas(toCamCoords(points[i]));
    point(drawPos.x, drawPos.y);
  }
  
  for(int i = 0; i<wires.length; i++){
    Position drawPosStart = pointOnCanvas(toCamCoords(wires[i].start));  
    Position drawPosEnd = pointOnCanvas(toCamCoords(wires[i].end));
    line(drawPosStart.x, drawPosStart.y, drawPosEnd.x, drawPosEnd.y);
  }
}

void mousePressed(){
  mouseBeginX=mouseX;
  mouseBeginY=mouseY;
  startDirection=direction;
}

Position toCamCoords(Position pos){
  Position rPos = pos.relativeTo(camPosition);
  //calculating rotation
  rPos.x = rPos.x*cos(direction)-rPos.y*sin(direction);
  rPos.y = rPos.x*sin(direction)+rPos.y*cos(direction);

  return rPos;
}

Position pointOnCanvas(Position pos){ //z coordinate to describe the point size or something(total distance)[not yet implemented]... or just zero
  return new Position(screenX/2+atan(pos.y/pos.x)*screenX/fov, screenY/2-atan(pos.z/pos.x)*screenX/fov, 0);
}