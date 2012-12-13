//The pose rule class should allow rules to be added and return smoothed result
class PoseRule 
{
  int fromJoint;
  int toJoint;
  PVector fromJointVector;
  PVector toJointVector;
  SimpleOpenNI context;
  
  boolean gestureDetected = false; //Should say true when smoothed result indicates gesture 
  int timeSinceLastEvent = 0;
  
  int smoothListIndex = 0;
  boolean[] smoothGestures = new boolean[5]; //Smoothing array, should prevent jerkiness. Not implemented yet.
  float poseConfidence = 0.0;
  
  int jointRelation; // one of:
  static final int ABOVE = 1;
  static final int BELOW = 2;
  static final int LEFT_OF = 3;
  static final int RIGHT_OF = 4;
  

  PoseRule(SimpleOpenNI tempContext, int tempFromJoint, 
  int tempJointRelation, int tempToJoint)
  {
    println("Added a new rule: " + tempFromJoint + " " + tempJointRelation + " " + tempToJoint);
    
    context = tempContext;
    fromJoint = tempFromJoint;
    toJoint = tempToJoint;
    jointRelation = tempJointRelation;
    
    fromJointVector = new PVector();
    toJointVector = new PVector();
  }
  
  float check(int userID /*, int prevTime, int currTime*/)
  {
    context.getJointPositionSkeleton(userID, fromJoint, fromJointVector);
    context.getJointPositionSkeleton(userID, toJoint, toJointVector);
    
    //Every second check whether the relationship mateches the rule, add result to array.
    if( millis() - timeSinceLastEvent >= 50)
    {
      switch(jointRelation)
      {
        //println("Doing check now");
        
        //All possible rules and their checks
        case ABOVE:
          smoothGestures[smoothListIndex] = (fromJointVector.y > toJointVector.y);
        break;
        case BELOW:
          smoothGestures[smoothListIndex] = (fromJointVector.y < toJointVector.y);
        break;
        case LEFT_OF:
           smoothGestures[smoothListIndex] = (fromJointVector.x < toJointVector.x);
        break;
        case RIGHT_OF:
          smoothGestures[smoothListIndex] = (fromJointVector.x > toJointVector.x);
        break;
      }
      smoothListIndex+=1;
      if(smoothListIndex == smoothGestures.length) { smoothListIndex = 0;} //Reset index
      timeSinceLastEvent = millis();
      
      int numTrues = 0;
      
      //println("Gesture Array contents : " + smoothGestures[0] + " " + smoothGestures[1] + " " + smoothGestures[2] + " " + smoothGestures[3] + " " + smoothGestures[4]);
      
      //Give a confidence level for the gesture
      for (int i = 0; i < smoothGestures.length; i++) 
      {
        if(smoothGestures[i])
        { 
          numTrues +=1; 
        }
      }
      poseConfidence = numTrues/float(smoothGestures.length);
      //println("Confidence " + poseConfidence);
    }
    return poseConfidence;
  }
}
