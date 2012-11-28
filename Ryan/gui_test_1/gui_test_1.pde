import controlP5.*;

// Window
final int WINDOW_WIDTH    = 1440;
final int WINDOW_HEIGHT   = 900;

// Layout
final int NUMBER_SAMPLES  = 8;
final int SAMPLE_HEIGHT   = 80;
final int V_GUIDE_DIST    = 50;

// Controls
final int CONTROLS_HEIGHT = 100;
final int BUTTON_WIDTH    = 150;
final int BUTTON_HEIGHT   = 70;
final int BUTTON_Y_POS    = (CONTROLS_HEIGHT - BUTTON_HEIGHT) / 2;

// final color BUTTON_COLOR    = color(245, 178, 51);

ControlP5 controlP5;
int backgroundColor = color(42,44,59);

void setup() {
  
  PFont pfont = createFont("Arial", 60, true);
  ControlFont arial60 = new ControlFont(pfont, 60);
  ControlFont arial10 = new ControlFont(pfont, 10);

  
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
  controlP5 = new ControlP5(this);
  
  background(backgroundColor);

  // Draw the horizonal guides
  noStroke();
  fill(46, 48, 64);
  
  int roomLeftForSamples = WINDOW_HEIGHT - CONTROLS_HEIGHT;
  
  for(int ctr = 0; ctr < roomLeftForSamples / SAMPLE_HEIGHT; ctr++) {
    int yPos = WINDOW_HEIGHT - (2 * ctr * SAMPLE_HEIGHT);
    rect(0, yPos, WINDOW_WIDTH, SAMPLE_HEIGHT);
  }
  
  
  // Draw the vertical guides
  stroke(52, 54, 60);
  for(int ctr = 0; ctr < WINDOW_WIDTH; ctr += V_GUIDE_DIST) {
    line(ctr, 0, ctr, WINDOW_HEIGHT);
  }
  
  
  // Draw the controls bar
  noStroke();
  // This makes the shaddow under the interface
//  fill(50);
//  rect(0, 0, WINDOW_WIDTH, CONTROLS_HEIGHT + 1);
//  filter( BLUR, 4 );
  // This makes the actual grey bar
  fill(223);
  rect(0, 0, WINDOW_WIDTH, CONTROLS_HEIGHT);
  
  
  // Add the + button
  controlP5.addButton("plus")
           .setValue(0)
           .setPosition((WINDOW_WIDTH/8) - (BUTTON_WIDTH/2), BUTTON_Y_POS)
           .setSize(BUTTON_WIDTH, BUTTON_HEIGHT)
           .setCaptionLabel("+")
           .getCaptionLabel()
           .setFont(arial60)
           .align(ControlP5.CENTER, ControlP5.CENTER);
           
  // Add the — button
  controlP5.addButton("minus")
           .setValue(0)
           .setPosition((3*WINDOW_WIDTH/8) - (BUTTON_WIDTH/2), BUTTON_Y_POS)
           .setSize(BUTTON_WIDTH, BUTTON_HEIGHT)
           .setCaptionLabel("–")
           .getCaptionLabel()
           .setFont(arial60)
           .align(ControlP5.CENTER, ControlP5.CENTER);
           
           
  // Add the volume knob
  controlP5.addKnob("Volume")
           .setValue(100)
           .setPosition(WINDOW_WIDTH - 80, BUTTON_Y_POS)
           .setSize(60, 60)
           .getCaptionLabel()
           .setFont(arial10);
  //controlP5.addSlider("Pitch",0,100,50,50,50,10,100);
  //controlP5.addSlider("LFO",0,100,50,150,50,10,100);
  //controlP5.addSlider("Duty Cycle",0,100,50,250,50,10,100);
  //controlP5.addKnob("Volume",0,11,5,330,70,40);
}

void draw() {

}

// called when plus button is pressed
public void plus(int theValue) {
}

// called when minus button is pressed
public void minus(int theValue) {
}
