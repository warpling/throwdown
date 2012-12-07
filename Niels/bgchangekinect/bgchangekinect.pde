/* 
Based on examples from: 
- http://www.miguelespada.es/?p=579
- http://github.com/Sensebloom/OSCeleton-examples/tree/master/processing/Stickmanetic
*/

import oscP5.*;
import netP5.*;
import SimpleOpenNI.*;

float headPosY;
float lHandPosY;

OscP5 oscP5;
SimpleOpenNI  cam1;
SimpleOpenNI  cam2;

DrawSkeleton dskel;
color bgColor = color(0,0,255);

void setup() 
{
  size(800, 600);
  oscP5 = new OscP5(this, "127.0.0.1", 7110);
  dskel = new DrawSkeleton();
   
  cam1 = new SimpleOpenNI(0,this);
  //cam2 = new SimpleOpenNI(1,this);
  
  
  if(cam1.enableDepth() == false /*|| cam2.enableDepth() == false*/)
  {
     println("Can't open the depthMap, maybe the camera is not connected!"); 
     exit();
     return;
  }
  cam1.enableScene();
  
   
}
void draw(){  

  //If you hand is above your head change BG color, otherwise change it back to how it was.
  //println("Is there a user?" + dskel.isUser());
  
  if(dskel.isUser())
  {
    if(headPosY > lHandPosY)
    {
       bgColor = color(255, 0, 0);
       background(bgColor);
    }else
    {
      bgColor = color(0,0,255);
      background(bgColor);  
    }
    dskel.doDraw(bgColor); //Pass in current bg color for redraw
  }else
  {
    background(bgColor);
    textSize(34);
    text("Please stand in front of the Camera", 10, 30); 
    fill(205, 202, 103);
  }
  
  //Draw cam footage
  cam1.update();
  //SimpleOpenNI.updateAll();
  
  
  image(cam1.sceneImage(),int(width/2-80),int(height-120), 160, 120);
}

void oscEvent(OscMessage msg) 
{
  dskel.passOSC(msg);
  
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
   
