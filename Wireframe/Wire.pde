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