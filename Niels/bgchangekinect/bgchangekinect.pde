// Based on example from: http://www.miguelespada.es/?p=579

import oscP5.*;
import netP5.*;

float headPosY;
float lHandPosY;

OscP5 oscP5;
void setup() 
{
   size(640, 480);
   oscP5 = new OscP5(this, "127.0.0.1", 7110);

}
void draw(){  
  //If you hand is above your head change BG color, otherwise change it back to how it was.
  if(headPosY > lHandPosY)
  {
     background(255, 0, 0); 
  }else
  {
    background(0,0,255); 
  }
}

void oscEvent(OscMessage msg) {
  /*
  if (msg.checkAddrPattern("/joint")){
    String bodyPart = msg.get(0).stringValue();
    //int userId = msg.get(1).intValue();
    if(bodyPart.equals("l_hand")){
      //float x = msg.get(2).floatValue();
      float y = msg.get(3).floatValue();
      //float z = msg.get(4).floatValue();
      backColor = int(map(y, 0, 1, 0, 255));
    }
   }
   */
  if (msg.checkAddrPattern("/joint"))
  {
    String bodyPart = msg.get(0).stringValue();
    if(bodyPart.equals("l_hand"))
    {
        lHandPosY = msg.get(3).floatValue();    //Get y value of your hand
    }
    if ( bodyPart.equals("head"))
    {
      headPosY = msg.get(3).floatValue();       //Get y value of your head
    }
  }
   
   
}
