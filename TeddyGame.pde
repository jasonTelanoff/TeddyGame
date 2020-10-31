import processing.sound.*;

Scene scene;
boolean w = false, a = false, s = false, d = false, sp = false, rs;
int kbc;
boolean bkbc;

SoundFile backgroundSound, backgroundGameMusic, tutorialMusic;

void setup() {
  surface.setTitle("Teddy's Game");
  size(900, 550);
  frameRate(30);
  noSmooth();

  background(0);

  //new Thread() { 
  //  public void run() {
  //    backgroundGameMusic = new SoundFile(TeddyGame.this, "inGame.mp3");
  //    tutorialMusic = new SoundFile(TeddyGame.this, "tutorial.mp3");
  //    backgroundSound = new SoundFile(TeddyGame.this, "startBackground.mp3");
  //  }
  //}
  //.start();

  scene = new Loading();
  scene.show();
}

void draw() {
  if (!(scene instanceof Loading))
    surface.setTitle("Teddy's Game | FPS: " + frameRate);
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
    kbc = 0;
    break;
  case 65:
    a = true;

    if (kbc == 9) {
      kbc = 0;

      bkbc = !bkbc;
      frameRate(bkbc ? 120 : 60);
    }
    break;
  case 83:
    s = true;
    kbc = 0;
    break;
  case 68:
    d = true;
    kbc = 0;
    break;
  case 32:
    sp = true;
    kbc = 0;
    break;
  case 82:
    rs = true;
    kbc = 0;
    break;
  case 66:  //B
    if (kbc == 8)
      kbc++;

    break;
  case 37:  //left
    if (kbc == 4 || kbc == 6)
      kbc++;

    break;
  case 38:  //up
    if (kbc == 0 || kbc == 1)
      kbc++;

    break;
  case 39:  //right
    if (kbc == 5 || kbc == 7)
      kbc++;

    break;
  case 40:  //down
    if (kbc == 2 || kbc == 3)
      kbc++;

    break;
  default:
    println(keyCode);
    kbc = 0;
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
  }
}
