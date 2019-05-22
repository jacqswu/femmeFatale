class Fem{
  
  // Manual collage placement
  // 0 is open; 1 is closed
  int[][] posArray = {
    {140,143}, {166,411}, {171,652}, {157,920}, //1
    {368,114}, {343,333}, {331,548}, {329,881}, //2
    {596,100}, {550,403}, {550,657}, {519,955}, //3
    {763,150}, {800,425}, {800,670}, {737,917}, //4
    {994,152}, {973,438},            {917,933}, //5
    {1164,93}, {1185,400}, {1058,650}, {1133,940}, //6
    {1390,108}, {1400,378}, {1300,700}, {1400,915}, //7
    {1599,151}, {1557,496}, {1591,811}, //8
  };
  
  int numImg = 30;
  PImage[] fem = new PImage[2];
  float scaleX = 275; // in pixels
  float scaleY = 275;
  
  float size = 50;
  PVector pos;
  float fxPos, fyPos;
  
  float dist; // between gaze orientation and image
  
  Fem(){
    
  }
  
  void load(int _index){
    for(int i=0; i<2; i++){
     fem[i] = loadImage(_index + "_" + i + ".png");

     if(fem[i].width < fem[i].height){
       scaleY = (scaleX/fem[i].width)*fem[i].height;
     } else if(fem[i].height < fem[i].width){
       scaleX = (scaleY/fem[i].height)*fem[i].width;
     }
     fem[i].resize(int(scaleX), int(scaleY));
     fxPos = posArray[_index][0];
     fyPos = posArray[_index][1];
    }
  }
  
  void display(int _index){
    imageMode(CENTER);
    image(fem[_index], fxPos, fyPos);
  }
  
  float checkDist(float _xPos){
    dist = abs(_xPos - fxPos);
    return dist;
  }
}
