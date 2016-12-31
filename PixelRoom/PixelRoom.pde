
int screenX = 480;
int screenY = 480;


float X;
float Y;

float speedX=0;
float speedY=0;

float speed=1;



void setup(){
  size(480, 480);
  X=screenX/2;
  Y=screenY/2;
}


void draw(){
  background(0,0,0);
  

  X+=speedX;
  Y+=speedY;

  if(X>screenX) X=screenX-1;
  if(Y>screenY) Y=screenY-1;
  if(X<1) X=1;
  if(Y<1) Y=1;
  
  stroke(255, 255, 255);
  point(X,Y);
}


void keyPressed(){
    switch(key){
    case 'w': speedY=-speed; break;
    case 's': speedY=speed; break;
    case 'a': speedX=-speed; break;
    case 'd': speedX=speed; break;
  }

}
void keyReleased(){
    switch(key){
    case 'w': speedY=0; break;
    case 's': speedY=0; break;
    case 'a': speedX=0; break;
    case 'd': speedX=0; break;
  }
}