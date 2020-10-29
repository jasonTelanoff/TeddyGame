import processing.sound.*;

Scene scene;
boolean w = false, a = false, s = false, d = false, sp = false, rs;

SoundFile backgroundSound;

void setup() {
  size(900, 550);
  frameRate(60);
  noSmooth();
  
  background(0);

  new Thread() { public void run() {
    backgroundSound = new SoundFile(TeddyGame.this, "startBackground.mp3");
  }}.start();

  scene = new Loading();
  scene.show();
}

void draw() {
  surface.setTitle("Teddy's Game Ripped Off by Json | FPS: " + frameRate);

  scene.update();
  scene.show();
}

void mousePressed() {
  scene.onPressed();
}

void keyPressed() {
  switch(keyCode) {
  case 87:
    w = true;
    break;
  case 65:
    a = true;
    break;
  case 83:
    s = true;
    break;
  case 68:
    d = true;
    break;
  case 32:
    sp = true;
    break;
  case 82:
    rs = true;
    break;
  default:
    println(keyCode);
  }
}

void keyReleased() {
  switch(keyCode) {
  case 87:
    w = false;
    break;
  case 65:
    a = false;
    break;
  case 83:
    s = false;
    break;
  case 68:
    d = false;
    break;
  case 32:
    sp = false;
    break;
  case 82:
    rs = false;
    break;
  default:
    println(keyCode);
  }
}
