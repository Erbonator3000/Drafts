class Tree{

  float x;
  float y;
  PImage treeImg= loadImage("tree.png");
  boolean alive=true;
  
Tree(Float X, float Y){
  x=X;
  y=y;
}
void kill(){
  alive=false;
}

void draw(){
  if(alive)
  image(treeImg, x, y, treeImg.width*2, treeImg.height*2);
}

}