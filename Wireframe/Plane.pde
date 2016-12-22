class Plane{
  
  float gridSize = 1;
  float planeSize = 10;
  Wire[] wires;
  
  //just a flat plane with z-axis normal
Plane(float x, float y, float z){
  wires=new Wire[int(planeSize*gridSize)*2+2];
  for (int i=0; i<wires.length/2; i++){
    wires[i]=new Wire(x-planeSize/2,y-planeSize+gridSize*i,z,x+planeSize,y-planeSize+gridSize*i,z);
  }
  for (int i=wires.length/2; i<wires.length; i++){
    wires[i]=new Wire(x-planeSize/2+gridSize*i,y-planeSize,z,x-planeSize+gridSize*i,y+planeSize,z);
  }
}



}