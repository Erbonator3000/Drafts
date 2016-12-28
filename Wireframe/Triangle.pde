class triangle extends Graphic{

Wire[] wires = new Wire[3];

triangle(Position position1, Position position2, Position position3){
  wires[0] = new Wire(position1, position2);
  wires[1] = new Wire(position2, position3);
  wires[2] = new Wire(position3, position1);
  
}

Wire[] getWires(){
  return wires;
}

}