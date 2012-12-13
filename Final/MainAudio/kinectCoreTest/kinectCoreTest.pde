import SimpleOpenNI.*;

KinectCore core;

void setup()
{
  kinect = new SimpleOpenNI(this);
  core = new KinectCore();
}


void draw()
{
  kinect.update();
  
  if(core.isHandsOverHead())
  {
    println("YEAAAHH!!!"); 
  }
  else if (core.isLeftHandOverHead())
  {
    println("LEFT HAND OVER HEAD");
  }else if (core.isRightHandOverHead())
  {
    println("RIGHT OVER HEAD from MAIN APP");
  }
}




// user-tracking callbacks!
void onNewUser(int userId) 
{
  println("start pose detection");
  kinect.startPoseDetection("Psi", userId);
}

void onEndCalibration(int userId, boolean successful) {
  if (successful) 
  {
    println(" User calibrated !!!");
    kinect.startTrackingSkeleton(userId);
    currentUser = userId;
  }
  else {
  println(" Failed to calibrate user !!!");
    kinect.startPoseDetection("Psi", userId);
  }
}
void onStartPose(String pose, int userId) 
{
  println("Started pose for user");
  kinect.stopPoseDetection(userId);
  kinect.requestCalibrationSkeleton(userId, true);
}
