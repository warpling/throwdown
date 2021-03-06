
// Draws dynamic waveform for a sample at a given vertical position.
void DrawWaveForm(AudioSample sample, int position, int beat) {
  // Take the length of sample in millis, divide by the length of loop in millis, multiple percentage by window width
  float percentWidthOfSample = sample.length() / (LENGTH_OF_LOOP * 1000.0);
  int barLength = (int) (WINDOW_WIDTH * percentWidthOfSample);
//  print("barLength = " + barLength + " (" + sample.length() + " / " + LENGTH_OF_LOOP + ") \n");
    
  if(beat != -1){
    
    // Draw the entire waveform comprised of lots of vertical lines
    stroke(255);
    for (int i = 0; i < min(barLength, 1000);  i++)
    {
       line(i + LEFT_MARGIN + (beat * COLUMN_WIDTH),
         position - (sample.left.get(i) * 25),
         i-1 + LEFT_MARGIN + (beat * COLUMN_WIDTH),
         position - ((sample.left.get(i+1)) * 10));
    }
  }
}

// Draws the frame corresponding to the loop time
void DrawWaveFrame(AudioSample sample,int position, int beat){
    
  // Computes bar length
  float barLength = WINDOW_WIDTH * (sample.length() / 1000.0) / LENGTH_OF_LOOP;
  
  if(beat != -1){
    stroke(12,12,158);
    strokeWeight(5);
    fill(12,12,158);
    rect(beat * COLUMN_WIDTH, position - 40, barLength, 80, 40);
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
