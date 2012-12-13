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

final int NOT_PLAYING = -1;

// --------------- Variables for audio management --------------- //

// Minim declaration 
Minim minim;

// Audiorecorders declaration
AudioInput Microphone;
AudioRecorder[] Recorders;

// Audiosamples Arrays declaration
// -- One array for the samples
AudioSample[] SamplesArray;
// -- One array for the beat the sample is playing at
int[] PlayArray;

// Array containing the char sequences "0,1,2.." for keyboard control purposes
char[] numArray;

// Tempo variables declaration
AudioSample Tick, Tock;
boolean tempoOn;
int bpm=127, beatPosition=0;

// Number of tracks and beats
int numTracks = 8;
int numBeats = 16;

// id of the next track to record
// (layer position)
int recordingTrack = 0;

// Timer declaration
TimeThread timer;

// Scrub bar position (as a beat)
float scrubPosition = 0;

// -------------------------------------------------------- //

void setup()
{
  
  setupInterface();
  
  // Arrays initialization
  SamplesArray = new AudioSample[numTracks];
  PlayArray    = new int[numTracks];
  
  // -- Set all the playing arrays to -1 = not playing
  for (int i=0; i < numTracks; i++)
    PlayArray[i] = NOT_PLAYING;
  
  // Minim and Timer initialization
  minim = new Minim(this);
  timer = new TimeThread(bpm);
  timer.start();
  
  //Initializes the arrays with the "0,1,2,3..." and "a,z,e,r..." sequences
  initCharArrays();
  
  // Setup recorders
  Microphone = minim.getLineIn();
  Recorders = new AudioRecorder[numTracks];
  
  // Sets up each recorder with an audio file to save to
  for (int i=0; i < numTracks; i++) {
      Recorders[i] = minim.createRecorder(Microphone, "data/SoundFiles/Sample" + numArray[i] + ".wav", false);
    }
    
  // Load metronome samples
  Tick = minim.loadSample( "SoundFiles/tick.mp3", 1024);
  Tock = minim.loadSample( "SoundFiles/tock.mp3", 1024);
  
  //Load default samples - Needed to have waveforms at startup
//  if (numTracks -1 >= 0) SamplesArray[0] = minim.loadSample( "SoundFiles/TechHouse 1 - Lead.mp3", 1024);
//  if (numTracks -1 >= 1) SamplesArray[1] = minim.loadSample( "SoundFiles/TechHouse 1 - Drums.mp3", 1024);
//  if (numTracks -1 >= 2) SamplesArray[2] = minim.loadSample( "SoundFiles/TechHouse 1 - Bass.mp3", 1024);
//  if (numTracks -1 >= 3) SamplesArray[3] = minim.loadSample( "SoundFiles/TechHouse 1 - Perc.mp3", 1024);
//  if (numTracks -1 >= 4) SamplesArray[4] = minim.loadSample( "SoundFiles/TechHouse 2 - Lead.mp3", 1024);
//  if (numTracks -1 >= 5) SamplesArray[5] = minim.loadSample( "SoundFiles/TechHouse 2 - Drums.mp3", 1024);
//  if (numTracks -1 >= 6) SamplesArray[6] = minim.loadSample( "SoundFiles/TechHouse 2 - Bass.mp3", 1024);
//  if (numTracks -1 >= 7) SamplesArray[7] = minim.loadSample( "SoundFiles/TechHouse 2 - FX.mp3", 1024);
}

void draw()
{  
  drawBackground();
  
  // Writes beat number and bar number
  // TODO: Fix to display the "tick/tock"
  text((beatPosition % 4) + 1, 490, 25);
  text((beatPosition / 4),     450, 25);
  
  // Writes recorders state
  for (int i=0; i < numTracks; i++) {
      if ( Recorders[i].isRecording() )
        text("REC", 25, CONTROLS_HEIGHT +  (SAMPLE_HEIGHT / 2) + SAMPLE_HEIGHT*i);
      else
        text("...", 25, CONTROLS_HEIGHT + (SAMPLE_HEIGHT / 2) + SAMPLE_HEIGHT*i);
  }

  // Generate waveforms
  for (int i=0; i < numTracks; i++) {
    // The recording track is of a different color
    if(i == recordingTrack)
      stroke(131, 18, 18);
    else
      stroke(strokeColor);
    
    if(PlayArray[i] != NOT_PLAYING && SamplesArray[i] != null) {
      DrawWaveFrame(SamplesArray[i], CONTROLS_HEIGHT + (SAMPLE_HEIGHT/2) + (SAMPLE_HEIGHT * i), PlayArray[i]);
      DrawWaveForm(SamplesArray[i], CONTROLS_HEIGHT + (SAMPLE_HEIGHT/2) + (SAMPLE_HEIGHT * i),  PlayArray[i]);
    } 
  }
  
  // Scrub bar
  // TODO: Smooth
  stroke(180, 35, 31);
  strokeWeight(5);
  scrubPosition = (beatPosition % 16.0) / 16 * WINDOW_WIDTH;
  line(scrubPosition, CONTROLS_HEIGHT, scrubPosition, WINDOW_HEIGHT);      
}


// play() gets called repeatedly by the timer if it is running
void play() {
  
  // If the tempo ticker is on
  if(tempoOn){  
    // Play a tock ever 3 beats, followed by a tick
    if ((beatPosition % 4) == 3)
      Tick.trigger();
    else
      Tock.trigger();
  }
  
  
  // Samples stack : plays the samples on their beat
  for (int i=0; i < numTracks; i++)
    {
      if(PlayArray[i] == beatPosition) {
        if(SamplesArray[i] != null) {
                // Make sure that the sample is stopped
          SamplesArray[i].stop();
          // Start playing it
          SamplesArray[i].trigger();
        }
        // else, we're still recording it so the audio file doesn't exist yet
      }
    }
   
  beatPosition = ++beatPosition % numBeats;
}
