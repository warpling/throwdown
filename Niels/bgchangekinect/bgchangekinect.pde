/* 
Based on examples from: 
- http://www.miguelespada.es/?p=579
- http://github.com/Sensebloom/OSCeleton-examples/tree/master/processing/Stickmanetic


Possibly a different way to draw skeleton:
http://learning.codasign.com/index.php?title=Trigger_Audio_When_a_Skeleton_is_Tracked
*/

import SimpleOpenNI.*;

int currentUser;

float headPosY;
float lHandPosY;

SimpleOpenNI  kinect;
PoseRule ruleOne;

DrawSkeleton dskel;
color bgColor = color(0,0,255);

void setup() 
{
  size(640, 480);
  
  kinect = new SimpleOpenNI(this);
  dskel = new DrawSkeleton();
  
  if(kinect.enableDepth() == false)
  {
     println("Can't open the depthMap, maybe the camera is not connected!"); 
     exit();
     return;
  }
 kinect.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
 
 //Add a rule
 ruleOne = new PoseRule(kinect, SimpleOpenNI.SKEL_LEFT_HAND, PoseRule.ABOVE, SimpleOpenNI.SKEL_HEAD);
 
}
boolean isRightHandOverHead()
{  
  kinect.update();

  if(dskel.isUser())
  {
    float confHandOverHead = ruleOne.check(currentUser);
    //Check rules
    if(confHandOverHead > .50)  //If more confidence that .5
    {
      return true; 
    }else
    {
      return false;
    }
  }

  
  //Extra argument include pos of image. Scale is set to 5, should be 5 times as small as full screen
  dskel.doDrawNI(bgColor, kinect, int(width/2-80), int(height-120), 5); 
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
