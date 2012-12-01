import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioSample sTemp;

//Make an arraylist that will contain new audio samples
ArrayList<AudioSample> beatList;

int currentRecordingNum;
String currentRecording;
boolean isRecording = false;

//Record audio
AudioInput in;
AudioRecorder recorder;
AudioRecording recording;


void setup()
{
 size(512, 200, P3D);
 minim = new Minim(this);
 //minim.debugOn();  //Debug minim
 in = minim.getLineIn();
 
 beatList = new ArrayList<AudioSample>();
}


void draw()
{
  background(0);
  stroke(255);
  // draw the waveform
  if(isRecording)
  {
    stroke(0,255,0);
  }
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
  }
}

void stop()
{
 //Todo: Get rid of samples from session.
 sTemp.close(); 
 minim.stop();
 super.stop();
}

void keyPressed()
{
  if(key == ENTER)
  {   
    for(int i=0; i < beatList.size(); i++)
    {
       beatList.get(i).trigger();
    }
    if(beatList.size()<1)
    {
       println("Nothing to play here..."); 
    }
  }
  if(key == 'r')
  {
    //start new recording
    if(isRecording == false)
    {
      //Setup linein
      println("Starting new record...");
      
      
      //Get filenum and name
      currentRecordingNum = beatList.size()+ 1;
      currentRecording = "s"+ currentRecordingNum +".wav";
      println("Number of record: " + currentRecordingNum + " filename: " +currentRecording);
    
      //setup recorder
      recorder = minim.createRecorder(in, currentRecording, true);
      recorder.beginRecord();
      System.out.println("Recording...");
      isRecording = true; 
    }else
    {
      //Now end and save recorded file into Audiosample and load 
       recorder.endRecord();
       recorder.save();
       
       System.out.println("Done saving.");
       sTemp = minim.loadSample(currentRecording, 1024);
       beatList.add(sTemp);
       
       System.out.println("Length of newly recorded audio is " + beatList.get(currentRecordingNum-1).length());
       isRecording = false; 
    }
  }
}
