class Wire extends Graphic{
Position start;
Position end;

Wire(Position Start, Position End){
  start = Start;
  end = End;
}
Wire(float x1, float y1, float z1, float x2, float y2, float z2){
  start = new Position(x1, y1, z1);
  end = new Position(x2, y2, z2);
}

Wire[] getWires(){
return wires;
}
}

class WireMesh extends Graphic{

  Wire[] wires;
  
  //position based constructor coming soon...
  
WireMesh(float[] points){
  wires = new Wire[points.length/3-1];
  
  for (int i=0; i<wires.length; i++){
  wires[i] = new Wire(points[i*3], points[i*3+1], points[i*3+2], points[i*3+3], points[i*3+4], points[i*3+5]);
  }

}

Wire[] getWires(){
  return wires;
}

}