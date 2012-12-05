// Initializes 2 arrays for test purposes
void initCharArrays(){
    numArray = new char[4];
    numArray[0] = '0';
    numArray[1] = '1';
    numArray[2] = '2';
    numArray[3] = '3';
    
    alphArray = new char[4];
    alphArray[0] = 'a';
    alphArray[1] = 'z';
    alphArray[2] = 'e';
    alphArray[3] = 'r';
}


// Keys pressed : playback
void keyPressed() 
{
  if ( key == 't' ) tempo = !tempo;
  
  // Switches the corresponding boolean in PlayArray.
  for (int i=0; i < PlayArray.length; i++)
  {
     if ( key == numArray[i] ) {PlayArray[i] = true;}
  }
}


void keyReleased()
{
  // Loops on the keys in alphArray
  for (int i=0; i < PlayArray.length; i++)
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
        {
          Recorders[i].beginRecord();
        }
     }
  }
}
