
final static int screenX = 480;
final static int screenY = 480;

Position camPosition;
float direction = PI/16; //first just turnig with z-axis
float fov = PI/4;

Position[] points = new Position[1];

float mouseBeginX;
float mouseBeginY;

void setup(){
  camPosition = new Position(0, 0, 0);
  points[0] = new Position(1, 0, 0);
  size(480, 480);
  noSmooth();
}



void draw(){
  
  if(mousePressed){
  direction+=(mouseX-mouseBeginX)*fov/screenX;
  }
  
  while(direction>=2*PI) direction-=2*PI;
  while(direction<0) direction+=2*PI;
  background(0, 0, 0);
  for(int i = 0; i<points.length; i++){
    Position drawPos = pointOnCanvas(toCamCoords(points[i]));
    stroke(255);
    point(drawPos.x+screenX/2, drawPos.y+screenY/2);
  }

}

void mousePressed(){
  mouseBeginX=mouseX;
  mouseBeginY=mouseY;
}

Position toCamCoords(Position pos){
  Position rPos = pos.relativeTo(camPosition);
  //calculating rotation
  rPos.x = pos.x*cos(direction)-pos.y*sin(direction);
  rPos.y = pos.x*sin(direction)+pos.y*cos(direction);
  
  return rPos;
}

Position pointOnCanvas(Position pos){ //z coordinate to describe the point size or something(total distance)[not yet implemented]... or just zero
  return new Position(atan(pos.y/pos.x)*screenX/fov, atan(pos.z/pos.x)*screenX/fov, 0);
}