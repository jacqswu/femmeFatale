// Jacqueline Wu
// October 2018

// Modified from a template for receiving face tracking osc messages by
// Kyle McDonald's FaceOSC https://github.com/kylemcdonald/ofxFaceTracker.
// This example includes a class to abstract the Face data.

import oscP5.*;
import processing.sound.*;

//------------------------------
OscP5 oscP5;
Face face = new Face(); // our FaceOSC tracked face dat

SoundFile speech1, speech2;

// Image variables
int numObj = 30;

Fem[] femmes;
int index = 1; // default eyes closed

// Position variables
float xPos, yPos;
float orientMin = -0.12; // face orientation y
float orientMax = 0.20;
float distance;
float eyeWidth = 250; // adjust according to screen

// Dev variables
int snapNum;
boolean showDist = false;

//------------------------------
void setup() {
  fullScreen();
  frameRate(30);

  oscP5 = new OscP5(this, 8338);
  xPos = width/2;
  
  // Load sound files
  speech1 = new SoundFile(this, "EmmaWatsonUnitedNationsFeminist.mp3");
  speech2 = new SoundFile(this, "ViolaDavisWomensMarch.mp3");
  
  // Load image files
  femmes = new Fem[numObj];
  for(int i=0; i<femmes.length; i++){
    femmes[i]= new Fem();
    femmes[i].load(i);
  }
  
  speech1.loop();
  speech2.loop();
}

//------------------------------
void draw() {  
  background(0);
  drawImages();
}

//------------------------------
void drawImages(){
  if(face.found > 0) {
    // Map face orientation to screen width
    xPos = map(face.poseOrientation.y, orientMin, orientMax, 0, width);
    speech1.amp(map(xPos, 0, width, 0.3, 1.0));
    speech2.amp(map(xPos, width, 0, 0.1, 0.6));
    
    for(int i=0; i<femmes.length; i++){
      distance = femmes[i].checkDist(xPos);

      // Binary: eyes open or closed
      if(distance > 0 && distance < eyeWidth){
        //index = fem.length - 1;
        index = 0;
      } else{
        index = 1;
      }
      femmes[i].display(index);
    }
    if(showDist){
      showDist();
    }
  } else{
    for(int i=0; i<femmes.length; i++){
      femmes[i].display(index);
    }
    speech1.amp(0.2);
    speech2.amp(0.2);
  }
}

//------------------------------
// OSC Callback
void oscEvent(OscMessage m) {
  face.parseOSC(m);
}

//------------------------------
// Facetracker dev tools
void showDist(){
  stroke(255);
  noFill();
  rectMode(CENTER);
  rect(xPos, height/2, eyeWidth, height);
  textAlign(CENTER);
  text(str(face.poseOrientation.y), xPos, height/3);
}

//------------------------------
void keyPressed(){
  if(key == ' '){
    println("---------------");
    println("SNAPSHOT " + snapNum);
    print(face.toString());
    snapNum++;
  }
  if(key == 'd' || key == 'D'){
      showDist = !showDist;
  }
}
