
// Draws dynamic waveform for a sample at a given vertical position.
void DrawWaveForm(AudioSample sample, int position, int beat) {
  // Take the length of sample in millis, divide by the length of loop in millis, multiple percentage by window width
  float percentWidthOfSample = sample.length() / (LENGTH_OF_LOOP * 1000.0);
  int barLength = (int) (WINDOW_WIDTH * percentWidthOfSample);
  print("barLength = " + barLength + " (" + sample.length() + " / " + LENGTH_OF_LOOP + ") \n");
  // Space between left side of window and left edge of sample
    
  if(beat != -1){
    
    // Draw the entire waveform comprised of lots of vertical lines
    for (int i = 0; i < barLength;  i++)
    {
      line(i + LEFT_MARGIN + (beat * LEFT_MARGIN),
           position - (sample.left.get(i) * 25),
           i-1 + LEFT_MARGIN + (beat * LEFT_MARGIN),
           position - ((sample.left.get(i+1)) * 10));
    }
  }
}

// Draws the frame corresponding to the loop time
void DrawWaveFrame(AudioSample sample,int position, int beat){

  int LEFT_MARGIN = WINDOW_WIDTH / NUMBER_OF_MARKERS;
  
  // Computes bar length
  float barLength = WINDOW_WIDTH * ((sample.length() / 1000.0)) / LENGTH_OF_LOOP;
  
  if(beat != -1){
    strokeWeight(5);
    rect(LEFT_MARGIN + beat * LEFT_MARGIN, position - 40, barLength, 80, 40);
    strokeWeight(1);
  }
}


public void stop() {
  // always close audio I/O classes
  Microphone.close();
  Tick.close();
  Tock.close();
  
  for (int i=0; i < NUMBER_OF_SAMPLES; i++) {
    SamplesArray[i].close();
  }
  
  // also shutdown the timer thread when the applet is stopped
  if (timer!=null) timer.isActive=false;
  
  // always stop your Minim object
  minim.stop();
  super.stop();
}
