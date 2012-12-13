// Initializes an array for test purposes
// This is very ugly, but I couldnt find another way to convert an int to its corresponding char
// (it converts to its ASCII code)

void initCharArrays(){
    numArray = new char[numTracks];
    if (numTracks -1 >= 0) numArray[0] = '0';
    if (numTracks -1 >= 1) numArray[1] = '1';
    if (numTracks -1 >= 2) numArray[2] = '2';
    if (numTracks -1 >= 3) numArray[3] = '3';
    if (numTracks -1 >= 4) numArray[4] = '4';
    if (numTracks -1 >= 5) numArray[5] = '5';
    if (numTracks -1 >= 6) numArray[6] = '6';
    if (numTracks -1 >= 7) numArray[7] = '7';
}


// Keys pressed : playback
void keyPressed() 
{
  if ( key == 't' ) tempoOn = !tempoOn;
  if ( key == 'q' ) exit();
  
  // Pause
  if ( key == 'p' ){
    for (int i=0; i < numTracks; i++){
      PlayArray[i] = -1;
      SamplesArray[i].stop();
    }
  }
  
  // Plays the corresponding track on the beat.
  for (int i=0; i < numTracks; i++)
  {
     if ( key == numArray[i] ) {PlayArray[i] = beatPosition;}
  }
}


void keyReleased()
{  
  if ( key == ' ' ) {
     // if the recorder is recording, stop and save, and go on to the next track
      if ( Recorders[recordingTrack].isRecording() ) 
      {
        Recorders[recordingTrack].endRecord();
        Recorders[recordingTrack].save();
        SamplesArray[recordingTrack] = minim.loadSample("SoundFiles/Sample" + recordingTrack + ".wav", 1024);
        
        // Play it at the beat after
        // PlayArray[recordingTrack] = beatPosition;
        
        recordingTrack++;
        recordingTrack = recordingTrack % numTracks;
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
