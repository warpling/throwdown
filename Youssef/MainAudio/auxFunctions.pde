
// Draws dynamic waveform for a sample at a given vertical position.
void DrawWaveForm(AudioSample sample,int position){
  int barLength = sample.length()/LENGTH_OF_LOOP - 20;
  int startPos = 100;
  
  for (int i = 0; i < barLength;  i++)
  {
    line(i + startPos, position - sample.left.get(i)*25, i-1 + startPos, position - sample.left.get(i+1)*10);
  }
}

// Draws the frame corresponding to the loop time
void DrawWaveFrame(AudioSample sample,int position){

  int margin = WINDOW_WIDTH / NUMBER_OF_MARKERS;
  int barLength = sample.length() / LENGTH_OF_LOOP;
  
  strokeWeight(5);
  rect(margin , position - 40, barLength, 80, 40);
  strokeWeight(1);
}


public void stop() {
  // always close audio I/O classes
  Microphone.close();
  Tick.close();
  Tock.close();
  
  for (int i=0; i < numTracks; i++) {
    SamplesArray[i].close();
  }
  
  // also shutdown the timer thread when the applet is stopped
  if (timer!=null) timer.isActive=false;
  
  // always stop your Minim object
  minim.stop();
  super.stop();
}
