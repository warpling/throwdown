import controlP5.*;

final int WINDOW_WIDTH  = 1440;
final int WINDOW_HEIGHT = 900;

ControlP5 controlP5;
int myColorBackground = color(0,0,0);

void setup() {
size(WINDOW_WIDTH, WINDOW_HEIGHT);
controlP5 = new ControlP5(this);
controlP5.addSlider("Pitch",0,100,50,50,50,10,100);
controlP5.addSlider("LFO",0,100,50,150,50,10,100);
controlP5.addSlider("Duty Cycle",0,100,50,250,50,10,100);
controlP5.addKnob("Volume",0,11,5,330,70,40);
}

void draw() {
background(myColorBackground);
}
