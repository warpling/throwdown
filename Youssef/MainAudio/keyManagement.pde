// Initializes an array for test purposes
// This is very ugly, but I couldnt find another way to convert an int to its corresponding char
// (it converts to its ASCII code)

final char tempo_key  = 't';
final char quit_key   = 'q';
final char pause_key  = 'p';
final char record_key = ' ';
final char delete_key = 'd';

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

void keyPressed() 
{

  switch(key) {

    case tempo_key:
      tempoOn = !tempoOn;
      break;

    case quit_key:
      exit();
      break;

    case pause_key:
      for (int i=0; i < NUMBER_OF_SAMPLES; i++) {
        PlayArray[i] = -1;
        SamplesArray[i].stop();
      }
      break;

    case record_key:
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
      break;

    case delete_key:
      SamplesArray[++recordingTrack] = null;
      PlayArray[recordingTrack] = -1;
    break;
    
  }
}


void keyReleased(){}
