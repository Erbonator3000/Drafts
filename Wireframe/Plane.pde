class Plane{
  
  float gridSize = 1;
  float planeSize = 10;
  Wire[] wires;
  
  //just a flat plane with z-axis normal
Plane(float x, float y, float z){
  wires=new Wire[int(planeSize+1)*2];
  for (int i=0; i<wires.length/2; i++){
    wires[i]=new Wire(x-planeSize/2,y-planeSize/2+gridSize*i,z,x+planeSize/2,-+planeSize/2+gridSize*i,z);
  }
  for (int i=0; i<wires.length/2; i++){
    wires[i+wires.length/2]=new Wire(x-planeSize/2+gridSize*i,y-planeSize/2,z,x-planeSize/2+gridSize*i,y+planeSize/2,z);
  }
}



}