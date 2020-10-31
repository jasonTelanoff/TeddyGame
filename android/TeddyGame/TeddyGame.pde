import processing.sound.*;

Scene scene;
boolean w = false, a = false, s = false, d = false, sp = false, rs;
int kbc, leftPadding;
float sF;
boolean bkbc;

void setup() {
  orientation(LANDSCAPE);
  frameRate(60);
  noSmooth();
  fullScreen();
  
  sF = ((float) height)/((float) 555);
  leftPadding = (int) (width - sF*900)/2;

  background(0);

  //new Thread() { 
  //  public void run() {
  //    backgroundGameMusic = new SoundFile(TeddyGame.this, "inGame.mp3");
  //    tutorialMusic = new SoundFile(TeddyGame.this, "tutorial.mp3");
  //    backgroundSound = new SoundFile(TeddyGame.this, "startBackground.mp3");
  //  }
  //}
  //.start();

  scene = new Start();
}

void draw() {
  scene.update();

  pushMatrix();
  translate(leftPadding, 0);
  scene.show();
  popMatrix();
}

void mousePressed() {
  scene.onPressed();
}

void mouseReleased() {
  scene.onReleased();
}
