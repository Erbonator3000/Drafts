
PImage treeImg;
PImage lumbImg;
int screenWidth=600;
int screenHeight=480;

float x=screenWidth/2;
float y=screenHeight/2;
float speedX=0;
float speedY=0;
float speed=1;

Tree[] trees = new Tree[1];

void setup(){

  size(600,480);
  treeImg = loadImage("tree.png");
  lumbImg = loadImage("lumberjack.png");
 trees[0]=new Tree(100.0, 100.0);

  
}


void draw(){
  x+=speedX;
  y+=speedY;
  background(30, 200, 60);
  trees[0].draw();
  image(lumbImg, x, y);

}

void cut(){
  for (int i=0; i<trees.length; i++){
    if (trees[i].x-5<x&&trees[i].x>x-5&&trees[i].y<y+5&&trees[i].y>y-5) trees[i].kill();
  }

}

void keyPressed(){
  switch(key){
  case 'w': speedY=-speed; break;
  case 's': speedY=speed; break;
  case 'a': speedX=-speed; break;
  case 'd': speedX=speed; break;
  case 'c': cut(); break;
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