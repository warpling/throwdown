class TimeThread extends Thread {

  long previousTime;
  boolean isActive=true;
  double interval;

  TimeThread(double bpm) {
    // interval currently hard coded to quarter beats
    interval = 1000.0 / (bpm / 60.0); 
    previousTime=System.nanoTime();
  }

  void run() {
    try {
      while(isActive) {
        
        // calculate time difference since last beat & wait if necessary
        double timePassed = (System.nanoTime()-previousTime) * 1.0e-6;
        
        while(timePassed < interval) {
          timePassed = (System.nanoTime()-previousTime) * 1.0e-6;
        }
        
        // insert your midi event sending code here
        play();
        
        // calculate real time until next beat
        long delay   = (long)(interval - (System.nanoTime()-previousTime) * 1.0e-6);
        previousTime = System.nanoTime();
        
        if (delay > 0)
          Thread.sleep(delay);
       
      }
    } 
    catch(InterruptedException e) {
      println("force quit...");
    }
  }
}
