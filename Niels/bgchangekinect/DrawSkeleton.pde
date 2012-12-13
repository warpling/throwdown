SimpleOpenNI knct;
boolean isUser = false;
int trackedUser;

int skelOriginOffsetX;
int skelOriginOffsetY;
float skelScale;

class DrawSkeleton
{
  
  public DrawSkeleton()
  {
    //Do nothing
    //println("BOO! I am a skeleton");
  }
  
  boolean isUser()
  {
    return isUser; 
  }

  void doDrawNI(color bgCol, SimpleOpenNI knct, int orgOffX, int orgOffY, int skelScale)
  {
    skelOriginOffsetX = orgOffX;
    skelOriginOffsetY = orgOffY;
    skelScale = skelScale;
    
    //background(bgCol);
    knct = knct;
    IntVector userList = new IntVector();
    kinect.getUsers(userList);
   
    if (userList.size() > 0) 
    {
      trackedUser = userList.get(0);
      int userId = userList.get(0);
      if ( kinect.isTrackingSkeleton(userId)) 
      {
        isUser = true;  //Only when tracking skeleton set userstate to true
        stroke(0);
        strokeWeight(5);
        
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD,
        SimpleOpenNI.SKEL_NECK);                                  //Drawlimb draws line between joints
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK,
        SimpleOpenNI.SKEL_LEFT_SHOULDER);
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER,
        SimpleOpenNI.SKEL_LEFT_ELBOW);
        
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW,
        SimpleOpenNI.SKEL_LEFT_HAND);
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK,
        SimpleOpenNI.SKEL_RIGHT_SHOULDER);
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER,
        SimpleOpenNI.SKEL_RIGHT_ELBOW);
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW,
        SimpleOpenNI.SKEL_RIGHT_HAND);
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER,
        SimpleOpenNI.SKEL_TORSO);
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER,
        SimpleOpenNI.SKEL_TORSO);
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO,
        SimpleOpenNI.SKEL_LEFT_HIP);
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP,
        SimpleOpenNI.SKEL_LEFT_KNEE);
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE,
        SimpleOpenNI.SKEL_LEFT_FOOT);
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO,
        SimpleOpenNI.SKEL_RIGHT_HIP);
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP,
        SimpleOpenNI.SKEL_RIGHT_KNEE);
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE,
        SimpleOpenNI.SKEL_RIGHT_FOOT);
        kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP,
        SimpleOpenNI.SKEL_LEFT_HIP);
        noStroke();
        
        fill(255,0,0);
        drawJoint(userId, SimpleOpenNI.SKEL_HEAD);
        drawJoint(userId, SimpleOpenNI.SKEL_NECK);
        drawJoint(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
        drawJoint(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
        drawJoint(userId, SimpleOpenNI.SKEL_NECK);
        drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
        drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
        drawJoint(userId, SimpleOpenNI.SKEL_TORSO);
        drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);
        drawJoint(userId, SimpleOpenNI.SKEL_LEFT_KNEE);
        drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HIP);
        drawJoint(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
        drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
        drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);
        drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
        drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
        drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HAND);
      }
    }else if (userList.size() == 0)
    {
     //println("NO MORE USERS HERE");
     isUser = false; 
    }
  }

  void drawJoint(int userId, int jointID) //add offset x and y 
  {
    PVector joint = new PVector();
    float confidence = kinect.getJointPositionSkeleton(userId, jointID,
    joint);
    if(confidence < 0.5)
    {
      return;
    }
    PVector convertedJoint = new PVector();    
    kinect.convertRealWorldToProjective(joint, convertedJoint);
    ellipse(convertedJoint.x, convertedJoint.y, 5, 5);
  }

  PVector getJointPos(int jointID)
  {
    PVector joint = new PVector();
    float confidence = kinect.getJointPositionSkeleton(trackedUser, jointID,
    joint);
    return joint; 
  }
}//eoc
