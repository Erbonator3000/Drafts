class Triangle extends Graphic{

Wire[] wires = new Wire[3];

Triangle(Position position1, Position position2, Position position3){
  wires[0] = new Wire(position1, position2);
  wires[1] = new Wire(position2, position3);
  wires[2] = new Wire(position3, position1);
}

Wire[] getWires(){
  return wires;
}

}

class TriangleMesh extends Graphic{

Wire[] wires;
Triangle[] triangles;

TriangleMesh(Triangle[] trianglesl){
  triangles=trianglesl;
  
  //quik and dirty, draw all triangles separetly, even the overlapping wires
  wires = new Wire[3*triangles.length];
  for(int i=0; i<triangles.length; i++){
    wires[3*i] = triangles[i].wires[0];
    wires[3*i+1] = triangles[i].wires[1];
    wires[3*i+2] = triangles[i].wires[2];
  }
  
}

Wire[] getWires(){
return wires;
}

}