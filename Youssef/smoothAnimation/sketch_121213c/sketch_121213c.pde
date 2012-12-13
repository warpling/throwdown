color rectColor;
int time;

void setup(){
    size(640, 360);
}

void draw(){

  background(127);
  rectColor = color(0,123,42);
  
  time = millis();
  time = time % 1000;
  
  int pos = int(map(time,0,1000,0,640));
  rect(pos,50,20,30,10);
}
