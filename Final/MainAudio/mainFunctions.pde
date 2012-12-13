
void toggleTempo() {
  tempoOn = !tempoOn;
}

void quit() {
  exit();
}

void toggleRecord() {
  // only record if the stack isn't full, otherwise ignore the key press
  if(recordingTrack >= 0) {
  
    // if the recorder is recording, stop and save, and go on to the next track
    if (Recorders[recordingTrack].isRecording() ) 
    {
      Recorders[recordingTrack].endRecord();
      Recorders[recordingTrack].save();
      SamplesArray[recordingTrack] = minim.loadSample("SoundFiles/Sample" + recordingTrack + ".wav", 1024);
      
      // Play it at the beat after
      // PlayArray[recordingTrack] = beatPosition;
      
      recordingTrack = (recordingTrack - 1) % NUMBER_OF_SAMPLES;
    }
    // If nothing is recording, start recording
    else 
    {
      Recorders[recordingTrack].beginRecord();
      // Use the current beat as the starting point for when we save it
      PlayArray[recordingTrack] = beatPosition;
    }
  }
}

void delete() {
  // Don't try to delete if the stack is empty
  if(recordingTrack < NUMBER_OF_SAMPLES - 1) {
    SamplesArray[++recordingTrack] = null;
    PlayArray[recordingTrack] = -1;
  }
}

