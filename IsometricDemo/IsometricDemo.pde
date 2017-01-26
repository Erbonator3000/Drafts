
PImage background;
PImage character;

Room[] rooms;
Room currentRoom;

float x;
float y;

float speedX=0;
float speedY=0;

float speed=1;

void setup(){
  size(600,480);
  
}

void draw(){
  image(currentRoom.roomImg,0,0);
  image(character, x-character.width/2,y-character.height);

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