class Plane extends Graphic{
  
  float gridSize = 1;
  int planeSize = 20; //how many squares
  Wire[] wires;
  
  //just a flat plane with z-axis normal
Plane(float x, float y, float z){
  
  //old way with long wires
  /*wires=new Wire[int(planeSize+1)*2];
  for (int i=0; i<wires.length/2; i++){
    wires[i]=new Wire(x-planeSize/2,y-planeSize/2+gridSize*i,z,x+planeSize/2,-+planeSize/2+gridSize*i,z);
  }
  for (int i=0; i<wires.length/2; i++){
    wires[i+wires.length/2]=new Wire(x-planeSize/2+gridSize*i,y-planeSize/2,z,x-planeSize/2+gridSize*i,y+planeSize/2,z);
  }*/
  
  //new method
  wires = new Wire[int(2*(pow(planeSize,2)+planeSize))];
  //wires = new Wire[planeSize+1][planeSize+1];
  for(int i=0; i<planeSize; i++){
    for(int j=0; j<planeSize+1; j++){ //longer
     wires[j*planeSize+i] = new Wire(x-planeSize*gridSize/2+i*gridSize, y-planeSize*gridSize/2+j*gridSize, z, x-planeSize*gridSize/2+i*gridSize+gridSize, y-planeSize*gridSize/2+j*gridSize, z);
     wires[wires.length/2+(j*planeSize+i)] = new Wire(x-planeSize*gridSize/2+j*gridSize, y-planeSize*gridSize/2+i*gridSize, z, x-planeSize*gridSize/2+j*gridSize, y-planeSize*gridSize/2+i*gridSize+gridSize, z);
    }
  }
  
  
}

Wire[] getWires(){
  return wires;
}


}