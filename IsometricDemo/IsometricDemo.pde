
PImage background;
PImage character;

Room[] rooms= new Room[1];
Room currentRoom;

float x=300;
float y=240;

float speedX=0;
float speedY=0;

float speed=4;

MsgBox lock= new MsgBox("Locked!");



void setup(){
  size(600,480);
   background=loadImage("jardek750_48.jpeg");
   character = loadImage("characrter1v-01.png");
   
  rooms[0]=new Room(background,new float[]{104,251,291,392,509,270,295,158});
  
  currentRoom=rooms[0];
}

void draw(){

  float k=(270-392)/(509-291);
  x+=speedX;
  y+=speedY;
  if (x>500)x=500;
  if (x<110)x=110;
  if (y>380)y=380;
  if (y<160)y=170;
  if (y<0.5*x+40){
      if (speedX!=0) y=0.5*x+40;
      else x=(y-40)/0.5;}
  if (y>0.65*x+190){
    if (speedX!=0)y=0.65*x+190;
    else x=(y-190)/0.65;}
  if(y<-0.5*x+315){ 
    if(speedX!=0)y=-0.5*x+315;
    else x=(y-315)/(-0.5);}
  if(y>-0.5*x+540){ 
    if(speedX!=0)y=-0.5*x+540;
    else x=(y-540)/(-0.5);}
   
    //translate(0, height);
  //rotate(-HALF_PI);
  image(currentRoom.roomImg,0,0,600,480);  

  image(character, x-40,y-100,80,100);
  if(220<x&&x<260 && 170<y&&y<195)
  lock.spawn(200,70);
  
  //rect(x,y-80/2,40,80);
  print("x:", mouseX, "  y: ", mouseY, "\n");

}

void keyPressed(){
  switch(key){
    case 'w': speedY=-speed; break;
    case 's': speedY=speed; break;
    case 'a': speedX=-speed; break;
    case 'd': speedX=speed; break;
  }
}

void move(float x, float y){
}

void keyReleased(){
  switch(key){
    case 'w': speedY=0; break;
    case 's': speedY=0; break;
    case 'a': speedX=0; break;
    case 'd': speedX=0; break;
  }
}