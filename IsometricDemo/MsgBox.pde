class MsgBox{
String message;

MsgBox(String msg){
message=msg;
}

void spawn(float x, float y){
fill(255);
rect(x,y,message.length()*10,15);
fill(0);
text(message,x+5,y+13);

}
}