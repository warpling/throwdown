//import processing.opengl.*; //just for testing
import processing.pdf.*;
import ddf.minim.*;

Minim minim;
AudioPlayer groove;

int parts = 80;
int partNum = 0;
boolean test;

void setup()
{ 
  //size(1200, 900, OPENGL); 
  //size(841, 1200, PDF, "test_out.pdf");
  size(1200, 600);  
  frameRate(400); 
  minim = new Minim(this); 
  // try changing the buffer size to see how it changes the effect
  groove = minim.loadFile("groove.wav", 12000); 
  groove.play(); 
  
  background(0);
}

void draw()
{ 
  pushMatrix(); 
  strokeWeight(0.05); 
  //stroke(255); 
  stroke(random(0,255), random(0,255), random(0,255) );
  
  for ( int i = 0; i < groove.bufferSize() - 1; i++ ) 
  { 
    //println(groove.bufferSize());
    
    float x1 = map(i, 0, groove.bufferSize(), 0, width) /parts; 
    float x2 = map(i+1, 0, groove.bufferSize(), 0, width) /parts;
   
    println("partNum: " + partNum + " x1: " + x1 + " x2: " + x2); 
    
    //line(x1, height/2 - groove.left.get(i)*50, x2, height/2 - groove.left.get(i+1)*50); //PDf example
    //line( x1, 50 + groove.left.get(i)*50, x2, 50 + groove.left.get(i+1)*50 );  //Example from lib
    
    
    //line(x1 + partNum*25, 50, x2+partNum*25, 50);
    
    //Note: The times 20 for x is to space the writing out. This should be done in a better way.
    line(x1+partNum*20, height/2 - groove.left.get(i)*50, x2+partNum*20, height/2 - groove.left.get(i+1)*50);
    
    
    
  }
  partNum = partNum+1;
  
  popMatrix(); 
  //println(frameRate); 
  
  test = groove.isPlaying(); 
  if (test == false) 
  { 
    println("done!"); 
    stop();
  }
}

void stop()
{ 
  // always close Minim audio classes when you finish with them 
  groove.close(); 
  // always stop Minim before exiting 
  minim.stop(); 
  super.stop();
}

