// Initializes an array for test purposes
// This is very ugly, but I couldnt find another way to convert an int to its corresponding char
// (it converts to its ASCII code)

void initCharArrays(){
    numArray = new char[NUMBER_OF_SAMPLES];
    if (NUMBER_OF_SAMPLES -1 >= 0) numArray[0] = '0';
    if (NUMBER_OF_SAMPLES -1 >= 1) numArray[1] = '1';
    if (NUMBER_OF_SAMPLES -1 >= 2) numArray[2] = '2';
    if (NUMBER_OF_SAMPLES -1 >= 3) numArray[3] = '3';
    if (NUMBER_OF_SAMPLES -1 >= 4) numArray[4] = '4';
    if (NUMBER_OF_SAMPLES -1 >= 5) numArray[5] = '5';
    if (NUMBER_OF_SAMPLES -1 >= 6) numArray[6] = '6';
    if (NUMBER_OF_SAMPLES -1 >= 7) numArray[7] = '7';
}


// Keys pressed : playback
void keyPressed() 
{
  if ( key == 't' ) tempoOn = !tempoOn;
  else if ( key == 'q' ) exit();
  
  // Pause
  else if ( key == 'p' ){
    for (int i=0; i < NUMBER_OF_SAMPLES; i++){
      PlayArray[i] = -1;
      SamplesArray[i].stop();
    }
  }
  
  else if ( key == ' ' ) {
    
    // if the stack is full, ignore the key press
    if(recordingTrack >= 0) {
      // if the recorder is recording, stop and save, and go on to the next track
      if (Recorders[recordingTrack].isRecording() ) 
      {
        Recorders[recordingTrack].endRecord();
        Recorders[recordingTrack].save();
        SamplesArray[recordingTrack] = minim.loadSample("SoundFiles/Sample" + recordingTrack + ".wav", 1024);
        
        // Play it at the beat after
        // PlayArray[recordingTrack] = beatPosition;
        
        recordingTrack--;
        recordingTrack = recordingTrack % NUMBER_OF_SAMPLES;
      }
      // If not, start recording
      else 
      {
        Recorders[recordingTrack].beginRecord();
        // Use the current beat as the starting point for when we save it
        PlayArray[recordingTrack] = beatPosition;
      }
    } 
  }
  
  // Plays the corresponding track on the beat.
//  for (int i=0; i < NUMBER_OF_SAMPLES; i++)
//  {
//     if ( key == numArray[i] ) {PlayArray[i] = beatPosition;}
//  }
}


void keyReleased()
{  
  
}
