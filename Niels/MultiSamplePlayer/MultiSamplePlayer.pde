import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioSample s1;
AudioSample s2;
AudioSample s3;

//Make an arraylist containing audio samples
ArrayList<AudioSample> beatList;


//Record audio
AudioRecorder recorder;
AudioInput in;
AudioRecording recording;


void setup()
{
 minim = new Minim(this);


 //Set recording
 in = minim.getLineIn();
 recorder = minim.createRecorder(in, "s3.wav", true);
 
 //Set stock samples and add to beatList
 s2 = minim.loadSample("snd2.wav", 1024);
 s1 = minim.loadSample("snd1.wav", 1024);
 beatList = new ArrayList<AudioSample>();
 beatList.add(s1);
 beatList.add(s2);
}


void draw()
{
  //Do nothing
}

void stop()
{
 s1.close();
 s2.close();
 s3.close(); 
 minim.stop();
 super.stop();
}

void keyPressed()
{
  if(key == ENTER)
  {
    beatList.get(0).trigger();
    beatList.get(1).trigger();
    
    //Check if there is a recorded sample
    if(beatList.size() >2)
     {
    beatList.get(2).trigger();
     } 
  }
  if(key == 'r')
  {  
   if(recorder.isRecording())
    {
       recorder.endRecord();
       //Now save recorded file into Audiosample and load        
       recorder.save();
       System.out.println("Done saving.");
       s3 = minim.loadSample("s3.wav", 1024);
       beatList.add(s3);
       
       System.out.println("Length of newly recorded audio is " + beatList.get(2).length());
       
    } else
    {
       recorder.beginRecord();
      System.out.println("Start recording"); 
    }
  }
  
  //Debug play newly recorded sample
  if(key == 'p')
  {
    beatList.get(2).trigger();
  }
  System.out.println(key);
}
