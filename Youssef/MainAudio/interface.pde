// --------------- Variables for interface management --------------- //

// Window
final int WINDOW_WIDTH    = 1440;
final int WINDOW_HEIGHT   = 900;

// Beat Constants
final int NUMBER_OF_SAMPLES  = 8;
final int LENGTH_OF_LOOP     = 8; // in seconds
final int NUMBER_OF_MARKERS  = 16; // number of vertical line markers
//final int FPS                = 60; // Hopefully we can use a timing object instead

// Controls
final int CONTROLS_HEIGHT = 100;
final int BUTTON_WIDTH    = 150;
final int BUTTON_HEIGHT   = 70;
final int BUTTON_Y_POS    = (CONTROLS_HEIGHT - BUTTON_HEIGHT) / 2;

// Layout
final int SAMPLE_HEIGHT   = (WINDOW_HEIGHT - CONTROLS_HEIGHT) / NUMBER_OF_SAMPLES;

ControlP5 controlP5;
int backgroundColor = color(42,44,59);
int strokeColor = color(12,12,158);
// -------------------------------------------------------- //

void setupInterface() {
        
  size(WINDOW_WIDTH, WINDOW_HEIGHT, P3D);

  controlP5 = new ControlP5(this);
  
  PFont pfont = createFont("Arial", 60, true);
  ControlFont arial60 = new ControlFont(pfont, 60);
  ControlFont arial10 = new ControlFont(pfont, 10);

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
}

void drawBackground(){

  background(backgroundColor);
    
  // Draw the horizonal guides
  noStroke();
  fill(46, 48, 64);
  
  for(int ctr = 0; ctr < NUMBER_OF_SAMPLES; ctr++) {
    int yPos = WINDOW_HEIGHT - (2 * ctr * SAMPLE_HEIGHT);
    rect(0, yPos, WINDOW_WIDTH, SAMPLE_HEIGHT);
  }
  
  // Draw the vertical guides
  stroke(52, 54, 60);
  strokeWeight(1);
  
  int distBetweenMarkers = WINDOW_WIDTH / NUMBER_OF_MARKERS;
  
  for(int ctr = 0; ctr < WINDOW_WIDTH; ctr += distBetweenMarkers) {
    line(ctr, CONTROLS_HEIGHT, ctr, WINDOW_HEIGHT);
  }
    
  // Draw the controls bar
  noStroke();
  // This makes the shaddow under the i fill(50);
  //  rect(0, 0, WINDOW_WIDTH, CONTROLS_HEIGHT + 1);
  //  filter( BLUR, 4 );
  // This makes the actual grey bar
  fill(223);
  rect(0, 0, WINDOW_WIDTH, CONTROLS_HEIGHT);
}

// called when plus button is pressed
public void plus(int theValue) {
  recordingTrack++;
}

// called when minus button is pressed
public void minus(int theValue) {
  recordingTrack--;
}
