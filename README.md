Throwndown
================

Throwndown is a simple beatboxing application controlled by kinect gestures, with a simple user interface that provides basic feedback. With basic gestures, beats are recorded live from a microphone and added to a stack of looping beats that are played back. This allows users to quickly record ambient sound, instruments, or vocals to enhance live performances without needing to sit in front of a computer, or work with complicated settings. Throwdown is powered by a Processing based application using multiple libraries (Minim and SimpleopenNI), is controlled by a Kinect, and plays loops and records audio over a microphone and speakers. Although the prototype had to be simplified, the project came together very nicely and the end-result turned out very well.


UI Mockup
----------------
<img src="https://raw.github.com/warpling/throwdown/master/Throwdown%20Interface%20v2.png">

The Gestures
----------------
The current *gestures* are more like poses if anything. They comprise of...

* right hand above head : start recording track
* hands by side         : nothing, or stop recording track and add to stack
* left hand above head  : delete top track on strack
* both hands above head : toggle tempo beat


The Code
================

Like all good school projects, we tried to the best of our ability to keep the code clean, well managed, and basically not a disgusting pile of poorly named, stale, spaghetti kludge, but like all good school projects we had a deadline and other classes so somethings are not as nice as we'd like them to be.
Please keep in mind this project is a prototype and our main goal was making something that demonstrated both the actions of the beatbox and that it was possible to pursue further.

The final project is located under Final/MainAudio and is broken up into code two parts we refer to as the "*BeatCore*" and the "*Kinect Core*". The BeatCore manages the audio and is comprised of the **MainAudio.pde** and **timer.pde**. **PoseRule.pde**, **KinectCore.pde**, and **DrawSkeleton.pde** handle gesture input and recoginition from the kinect. **interface.pde** and **keyManagement.pde** handle the interface and keyboard input for inital testing. **auxFunctions.pde** partially handles waveform drawing.