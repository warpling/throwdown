/**
  * Program that :
  * - Record sounds
  * - Stores them
  * - Plays them back
  * - Plays a tempo
  */
  
// Minim and ddf library
import ddf.minim.*;
import controlP5.*;

// --------------- Variables for audio management --------------- //

// Minim declaration 
Minim minim;

// Audiorecorders declaration
AudioInput Microphone;
AudioRecorder[] Recorders;


// Audiosamples Arrays declaration
// -- One array for the samples
// -- One array for the 'play or not' boolean
AudioSample[] SamplesArray;
boolean[] PlayArray;

// Arrays containing the char sequences "0,1,2.." and "a,b,c.." for control purposes
char[] numArray, alphArray;

// Tempo variables declaration
AudioSample Tick, Tock;
boolean tempo;
int bpm=127, beatPosition=0;

// Number of tracks
int numTracks = 8;

// id of the next track to record
int recordingTrack = 0;

// Timer declaration
TimeThread timer;

// Autoplay = play all tracks every k beats
boolean autoplay = false;
int autoplayBeatNum = 16;

// -------------------------------------------------------- //

void setup()
{
  
  setupInterface();

  print(SAMPLE_HEIGHT);
  // Window and font Initialization
  //size(512, 100 * numTracks, P3D);
  //textFont(createFont("Arial", 16));
  
  // Arrays initialization
  SamplesArray = new AudioSample[numTracks];
  PlayArray    = new boolean[numTracks];
  // -- Set all the playing booleans to false
  for (int i=0; i < numTracks; i++)      PlayArray[i] = false;
  
  // Minim and Timer initialization
  minim = new Minim(this);
  timer = new TimeThread(bpm);
  timer.start();
  
  //Initializes the arrays with the "0,1,2,3..." and "a,z,e,r..." sequences
  initCharArrays();
  
  // Setup recorders
  Microphone = minim.getLineIn();
  Recorders = new AudioRecorder[numTracks];
  
  for (int i=0; i < numTracks; i++) {
      Recorders[i] = minim.createRecorder(Microphone, "data/SoundFiles/Sample" + numArray[i] + ".wav", false);
    }
    
  //Load metronome samples
  Tick = minim.loadSample( "SoundFiles/tick.mp3", 1024);
  Tock = minim.loadSample( "SoundFiles/tock.mp3", 1024);
  
  //Load default samples - Needed to have waveforms at startup
  if (numTracks -1 >= 0) SamplesArray[0] = minim.loadSample( "SoundFiles/TechHouse 1 - Lead.mp3", 1024);
  if (numTracks -1 >= 1) SamplesArray[1] = minim.loadSample( "SoundFiles/TechHouse 1 - Drums.mp3", 1024);
  if (numTracks -1 >= 2) SamplesArray[2] = minim.loadSample( "SoundFiles/TechHouse 1 - Bass.mp3", 1024);
  if (numTracks -1 >= 3) SamplesArray[3] = minim.loadSample( "SoundFiles/TechHouse 1 - Perc.mp3", 1024);
  if (numTracks -1 >= 4) SamplesArray[4] = minim.loadSample( "SoundFiles/TechHouse 2 - Lead.mp3", 1024);
  if (numTracks -1 >= 5) SamplesArray[5] = minim.loadSample( "SoundFiles/TechHouse 2 - Drums.mp3", 1024);
  if (numTracks -1 >= 6) SamplesArray[6] = minim.loadSample( "SoundFiles/TechHouse 2 - Bass.mp3", 1024);
  if (numTracks -1 >= 7) SamplesArray[7] = minim.loadSample( "SoundFiles/TechHouse 2 - FX.mp3", 1024);
}

void draw()
{
  drawBackground();

  
  // Writes beat number and bar number
  text((beatPosition % 4) + 1, 490, 25);
  text((beatPosition / 4),     450, 25);
  
  // Writes recorders state
  for (int i=0; i < numTracks; i++) {
      if ( Recorders[i].isRecording() )       text("REC", 25, CONTROLS_HEIGHT +  (SAMPLE_HEIGHT / 2) + SAMPLE_HEIGHT*i);
      else                                    text("...", 25, CONTROLS_HEIGHT + (SAMPLE_HEIGHT / 2) + SAMPLE_HEIGHT*i);
  }

  //Generate waveforms
  for (int i=0; i < numTracks; i++){
    // The recording track is of a different color
    if(i == recordingTrack)  stroke(131, 18, 18); else stroke(strokeColor);

    DrawWaveFrame(SamplesArray[i], CONTROLS_HEIGHT + (SAMPLE_HEIGHT/2) + (SAMPLE_HEIGHT * i));
    DrawWaveForm(SamplesArray[i], CONTROLS_HEIGHT + (SAMPLE_HEIGHT/2) + (SAMPLE_HEIGHT * i));
    
  }
}



void play() {
  // Tempo tick manager
  if(tempo){  
    if ( (beatPosition % 4) == 3 ) Tick.trigger();
    else Tock.trigger();
  }
  
  // If autoplay is active, periodically loop every autoplayBeatNum beats.
  if(autoplay) {
    if( beatPosition % autoplayBeatNum == 3 ) {
      for (int i=0; i < numTracks; i++)      PlayArray[i] = true;
    }
  }
  
  
  // Samples stack
  for (int i=0; i < numTracks; i++)
    {
      if(PlayArray[i]) {
        SamplesArray[i].stop();
        SamplesArray[i].trigger();
        PlayArray[i] = false;
      }
    }
   
  beatPosition++;
}
