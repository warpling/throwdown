/**
  * Program that :
  * - Record sounds
  * - Stores them
  * - Plays them back
  * - Plays a tempo
  */
  
import ddf.minim.*;

Minim minim;
AudioSample Lead, Drums, Bass, Perc;
boolean playLead, playDrums, playBass, playPerc;

AudioSample Tick, Tock;

boolean tempo;

PFont font;

int time;


void setup()
{
  //Initialization
  size(512, 400, P3D);
  frameRate(60);
  
  font = loadFont("CenturySchL-Bold-48.vlw");
  textFont(font);
  
  minim = new Minim(this);
  
  //Load metronome samples
  Tick = minim.loadSample( "SoundFiles/tick.mp3", 1024);
  Tock = minim.loadSample( "SoundFiles/tock.mp3", 1024);
  
  //Load other samples  
  Lead = minim.loadSample( "SoundFiles/TechHouse 1 - Lead.mp3", 1024);
  Drums = minim.loadSample( "SoundFiles/TechHouse 1 - Drums.mp3", 1024);
  Bass = minim.loadSample( "SoundFiles/TechHouse 1 - Bass.mp3", 1024);
  Perc = minim.loadSample( "SoundFiles/TechHouse 1 - Perc.mp3", 1024);
}

void draw()
{
  background(0);
  stroke(255);

  fill(0, 102, 153);  
  text(time, 400, 50);
//  fill(50, 152, 203);  
//  text(mouseY, 400, 100);

  // Time manager
  time++;
  time = time % 480;
  
  // Tempo manager
  if(tempo)
  {
  if ( (time % 120) == 0 ) Tick.trigger();
  else if ( (time % 30) == 0 ) Tock.trigger();
  }
  
  // Samples stack
  if ( (time % 30) == 0 )
  {
    if (playLead) {
          Lead.stop();
          Lead.trigger();
          playLead = false;
    } 
    
    if (playDrums) {
          Drums.stop();
          Drums.trigger();
          playDrums = false;
    }
    
    if (playBass) {
          Bass.stop();
          Bass.trigger();
          playBass = false;
    }

    if (playPerc) {
          Perc.stop();
          Perc.trigger();
          playPerc = false;
    }
  }
  
  
  
  //Generate waveforms
  for (int i = 0; i < Drums.bufferSize() - 1;  i++)
  {
    line(i, 50 - Drums.left.get(i)*50, i+1, 50 - Drums.left.get(i+1)*10);
  }
  
    for (int i = 0; i < Lead.bufferSize() - 1;  i++)
  {
    line(i, 150 - Lead.left.get(i)*50, i+1, 150 - Lead.left.get(i+1)*10);
  }
  
      for (int i = 0; i < Bass.bufferSize() - 1;  i++)
  {
    line(i, 250 - Bass.left.get(i)*50, i+1, 250 - Bass.left.get(i+1)*10);
  }
  
      for (int i = 0; i < Perc.bufferSize() - 1;  i++)
  {
    line(i, 350 - Perc.left.get(i)*50, i+1, 350 - Perc.left.get(i+1)*10);
  }
}

void keyPressed() 
{
  if ( key == 'd' ) playDrums = true;
  if ( key == 'l' ) playLead = true;
  if ( key == 'b' ) playBass = true;
  if ( key == 'p' ) playPerc = true;
  if ( key == 't' ) tempo = !tempo;
}
