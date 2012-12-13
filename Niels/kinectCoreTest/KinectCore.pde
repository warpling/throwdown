/* 
Based on examples from: 
- http://www.miguelespada.es/?p=579
- http://github.com/Sensebloom/OSCeleton-examples/tree/master/processing/Stickmanetic


Possibly a different way to draw skeleton:
http://learning.codasign.com/index.php?title=Trigger_Audio_When_a_Skeleton_is_Tracked
*/



int currentUser;
float confidenceThreshold = .5;

SimpleOpenNI  kinect;
PoseRule ruleOne;
PoseRule ruleTwo;
PoseRule ruleThree;
PoseRule ruleFour;

DrawSkeleton dskel;

class KinectCore
{

  public KinectCore() 
  {
    
    dskel = new DrawSkeleton();
    
    if(kinect.enableDepth() == false)
    {
       println("Can't open the depthMap, maybe the camera is not connected!"); 
       exit();
       return;
    }
   kinect.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
   
   //Add rules
   ruleOne = new PoseRule(kinect, SimpleOpenNI.SKEL_LEFT_HAND, PoseRule.ABOVE, SimpleOpenNI.SKEL_HEAD);
   ruleTwo = new PoseRule(kinect, SimpleOpenNI.SKEL_RIGHT_HAND, PoseRule.ABOVE, SimpleOpenNI.SKEL_HEAD);
   ruleThree = new PoseRule(kinect, SimpleOpenNI.SKEL_LEFT_HAND, PoseRule.BELOW, SimpleOpenNI.SKEL_HEAD);
   ruleFour = new PoseRule(kinect, SimpleOpenNI.SKEL_RIGHT_HAND, PoseRule.BELOW, SimpleOpenNI.SKEL_HEAD);
  }
  
  boolean isRightHandOverHead()
  { 
   //println("RIGHT HAND ENTER IN CORE CLASS"); 
    
    dskel.doDrawNI(kinect);
    
    if(dskel.isUser())
    {
      float conf1 = ruleTwo.check(currentUser);
      float conf2 = ruleThree.check(currentUser);
      
      //println("CONFIDENCE FROM CORE : " + conf1  + ", " + conf2);
      
       
      //Check rules
      if(conf1 > confidenceThreshold && conf2 > confidenceThreshold){
        //println("RIGHT OVER HEAD IN CORE CLASS");
        return true;
      }
    }
    return false;
  }
  
  boolean isLeftHandOverHead()
  {  
    dskel.doDrawNI(kinect);
  
    if(dskel.isUser())
    {
      float conf1 = ruleOne.check(currentUser);
      float conf2 = ruleFour.check(currentUser);
      
      //Check rules
      if(conf1 > confidenceThreshold && conf2 > confidenceThreshold ){return true;}
    }
    return false;
  }
  
  boolean isHandsOverHead()
  {
    
    dskel.doDrawNI(kinect);
    
    if(dskel.isUser())
    {
      float conf1 = ruleOne.check(currentUser);
      float conf2 = ruleTwo.check(currentUser);
      
      //Check rules
      if(conf1 > confidenceThreshold && conf2 > confidenceThreshold ){return true;}
    }
    return false;
  }
  

}
