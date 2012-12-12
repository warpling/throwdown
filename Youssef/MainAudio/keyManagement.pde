// Initializes 2 arrays for test purposes
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
    
    alphArray = new char[numTracks];
    if (numTracks -1 >= 0) alphArray[0] = 'a';
    if (numTracks -1 >= 1) alphArray[1] = 'z';
    if (numTracks -1 >= 2) alphArray[2] = 'e';
    if (numTracks -1 >= 3) alphArray[3] = 'r';
    if (numTracks -1 >= 4) alphArray[4] = 'q';
    if (numTracks -1 >= 5) alphArray[5] = 's';
    if (numTracks -1 >= 6) alphArray[6] = 'd';
    if (numTracks -1 >= 7) alphArray[7] = 'f';
}


// Keys pressed : playback
void keyPressed() 
{
  if ( key == 't' ) tempo = !tempo;
  if ( key == 'l' ) autoplay = !autoplay;
  if ( key == 'q' ) exit();
  
  // Switches the corresponding boolean in PlayArray.
  for (int i=0; i < numTracks; i++)
  {
     if ( key == numArray[i] ) {PlayArray[i] = true;}
  }
}


void keyReleased()
{
  // Loops on the keys in alphArray
  for (int i=0; i < numTracks; i++)
  {
     if ( key == alphArray[i] )
     {
       // if the recorder is recording, stop and save
        if ( Recorders[i].isRecording() ) 
        {
          Recorders[i].endRecord();
          Recorders[i].save();
          SamplesArray[i] = minim.loadSample("SoundFiles/Sample" + i + ".wav", 1024);
        }
        // If not, start recording
        else 
        {                Recorders[i].beginRecord();
        }
     }
  }
  
if ( key == ' ' ) {
     // if the recorder is recording, stop and save, and go on to the next track
      if ( Recorders[recordingTrack].isRecording() ) 
      {
        Recorders[recordingTrack].endRecord();
        Recorders[recordingTrack].save();
        SamplesArray[recordingTrack] = minim.loadSample("SoundFiles/Sample" + recordingTrack + ".wav", 1024);
        
        recordingTrack++;
        recordingTrack = recordingTrack % numTracks;
      }
      // If not, start recording
      else 
      {
        Recorders[recordingTrack].beginRecord();
      }
 }
  
  
}
