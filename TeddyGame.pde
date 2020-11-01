//import processing.sound.*;

Scene scene;
boolean w = false, a = false, s = false, d = false, sp = false, rs;
int kbc;
boolean bkbc;
float vol = 100;

boolean debug = true;

HashMap<String, Clip> clips = new HashMap();

ArrayList<Overlay> overlays = new ArrayList();
ArrayList<Overlay> overlaysToDelete = new ArrayList();

void setup() {
  surface.setTitle("Teddy's Game");
  size(900, 550);
  frameRate(30);
  noSmooth();

  background(0);

  new Thread() {
    public void run() {
      clips.put("inGame", loadSound("inGame.wav"));
      clips.put("startBackground", loadSound("startBackground.wav"));
      clips.put("tutorial", loadSound("tutorial.wav"));

      clips.put("cyclops_attack", loadSound("cyclops_attack.wav"));
      clips.put("ghost_attack", loadSound("ghost_attack.wav"));

      clips.put("glow", loadSound("glow.wav"));
      clips.put("speed", loadSound("speed.wav"));
      clips.put("time", loadSound("time.wav"));
      clips.put("view", loadSound("view.wav"));
      clips.put("health", loadSound("health.wav"));
    }
  }
  .start();

  scene = new Loading();
  scene.show();
}

void draw() {
  if (!(scene instanceof Loading))
    surface.setTitle("Teddy's Game | FPS: " + frameRate);
  boolean updateScene = true;
  for (Overlay o : overlays)
    updateScene &= o.update();
  if (updateScene)
    scene.update();
  scene.show();
  
  for (int i = overlaysToDelete.size() - 1; i >= 0; i--) {
    overlays.remove(overlaysToDelete.get(i));
    overlaysToDelete.remove(i);
  }

  for (Overlay o : overlays)
    o.show();
}

void mousePressed() {
  boolean updateScene = true;
  for (Overlay o : overlays)
    updateScene &= o.onPressed();
  if (updateScene)
    scene.onPressed();
}

void mouseReleased() {
  boolean updateScene = true;
  for (Overlay o : overlays)
    updateScene &= o.onRelease();
  if (updateScene)
    scene.onRelease();
}

void mouseDragged() {
  boolean updateScene = true;
  for (Overlay o : overlays)
    updateScene &= o.onDragged();
  if (updateScene)
    scene.onDragged();
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
