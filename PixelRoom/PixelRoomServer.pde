import processing.net.*;
/*
Server server;

int port=5000;

int screenX = 480;
int screenY = 480;

Pixel myPixel;

float speedX=0;
float speedY=0;

float speed=1;

Pixel[] clients = new Pixel[10];

void setup(){
  
  server= new Server(this, port);
  
  size(480, 480);
  myPixel= new Pixel(0xFFFFFF);
  myPixel.X=screenX/2;
  myPixel.Y=screenY/2;
}


void draw(){
  background(0,0,0);
  

  myPixel.X+=speedX;
  myPixel.Y+=speedY;

  if(myPixel.X>screenX) myPixel.X=screenX-1;
  if(myPixel.Y>screenY) myPixel.Y=screenY-1;
  if(myPixel.X<1) myPixel.X=1;
  if(myPixel.Y<1) myPixel.Y=1;
  
  stroke(myPixel.pixelColor);
  point(myPixel.X, myPixel.Y);
  

    
  

  
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
}*/