Scene scene;
boolean w = false, a = false, s = false, d = false, sp = false;

void setup() {
  size(900, 550);
  frameRate(60);

  scene = new Start(10, 6, 3, 3, 3, 2, 2);
}

void draw() {
  surface.setTitle("Teddy's Game Ripped Off by Json | FPS: " + frameRate);

  scene.update();
  scene.show();
}

void mousePressed() {
  if (scene instanceof Game) {
    for (Game.Button b : ((Game) scene).buttons)
      if (b.mouseOn())
        b.onPressed();
  } else if (scene instanceof Start) {
    for (Start.Button b : ((Start) scene).buttons)
      if (b.mouseOn())
        b.onPressed();
  } else if (scene instanceof Tutorial) {
    ((Tutorial) scene).slide.onPressed();
  }
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
  default:
    println(keyCode);
  }
}
