class Game extends GameScene {
  ArrayList<Button> buttons = new ArrayList<Button>();
  int framesAlive = 0, framesLeft = 1200, glowing = 0, framesView;
  float viewDist = 200;
  PImage background;
  boolean paused, dead;
  Lose lose;

  {
    if (random(1) < 0.05)
      launchPage("https:www.youtube.com/watch?v=dQw4w9WgXcQ");

    int ghosts = 4, cyclops = 3, hearts = 2, speeds = 2, points = 4, glows = 1, views = 1;
    lose = new Lose();
    p = new Player(this, 5, 5);
    background = loadImage("assets/background.png");

    for (int y = 0; y < 10; y++)
      for (int x = 0; x < 18; x++)
        if (y != 0 || x != 0)
          if (random(6) < 1)
            barriers.add(new Barrier(x * 50, y * 50));

    for (int i = 0; i < ghosts; i++)
      entities.add(new Ghost(this));

    for (int i = 0; i < hearts; i++)
      entities.add(new Heart(this));

    for (int i = 0; i < speeds; i++)
      entities.add(new SpeedBoost(this));

    for (int i = 0; i < points; i++)
      entities.add(new Point(this));

    for (int i = 0; i < cyclops; i++)
      entities.add(new Cyclops(this));

    for (int i = 0; i < glows; i++)
      entities.add(new Glowstone(this));

    for (int i = 0; i < views; i++)
      entities.add(new DoubleView(this));

    buttons.add(new Restart());
    buttons.add(new Pause());
  }

  void show() {
    background(0);
    image(background, 0, 0, 900 * sF, 550 * sF);

    pushMatrix();
    translate(0, 50 * sF);
    for (Barrier b : barriers)
      b.show();

    for (Entity e : entities)
      e.show();

    p.show();

    popMatrix();

    //if (!dead) overlay();

    if (glowing > 0)
      for (Entity e : entities)
        e.showGlow();

    noStroke();
    fill(90, 170, 255);
    rect(30 * sF, 10 * sF, (p.power * 3) * sF, 30 * sF);

    fill(255, 30, 30);
    rect(470 * sF, 10 * sF, (p.health * 3) * sF, 30 * sF);

    stroke(50);
    strokeWeight(5);
    noFill();
    rect(30 * sF, 10 * sF, 300 * sF, 30 * sF);
    rect(470 * sF, 10 * sF, 300 * sF, 30 * sF);

    noStroke();
    fill(255);
    textSize(40 * sF);
    textAlign(CENTER, TOP);
    text(((float) framesLeft/60 + "0000").substring(0, 4), 400 * sF, 5 * sF);

    for (Button b : buttons)
      b.show();

    if (dead)
      lose.show(framesAlive);
  }

  void update() {
    if (!paused && !dead) {
      p.speed = p.normSpeed;

      for (Entity e : entities)
        e.update();
      p.update();

      if (framesView > 0) {
        viewDist = 230;
        framesView--;
      } else
        viewDist = 200;

      framesAlive++;
      framesLeft--;

      if (glowing > 0) glowing--;
    }

    if (p.health <= 0 || framesLeft == 0) {
      dead = true;
    }
  }

  void onPressed() {
    for (Button b : buttons)
      if (b.mouseOn())
        b.onPressed();
    if (dead)
      lose.onPressed();
  }

  void overlay() {
    float _x = p.pos.x + p.wid/2;
    float _y = p.pos.y + p.hei/2 + 50;

    loadPixels();
    for (int y = (int) max(50, _y - viewDist); y < min(height, _y + viewDist); y++)
      for (int x = (int) max(0, _x - viewDist); x < min(width, _x + viewDist); x++)
        if (pixels[y*width + x] != color(255, 255, 0) &&
          dist(_x, _y, x, y) > viewDist)
          pixels[y*width + x] = color(0);
    updatePixels();

    rectMode(CORNERS);
    fill(0);
    noStroke();
    rect(0, 50, width, max(50, _y - viewDist));
    rect(0, min(height, _y + viewDist), width, height);
    rect(0, 50, max(0, _x - viewDist), height);
    rect(_x + viewDist, 50, width, height);
    rectMode(CORNER);
  }

  /*
  --------------------------
   BUTTON
   --------------------------
   */
  class GameButton extends Button {
    int x;
    PImage image;

    void show() {
      if (mouseOn()) image(image, (x - 5) * sF, 5 * sF, 40 * sF, 40 * sF);
      else image(image, x * sF, 10 * sF, 30 * sF, 30 * sF);
    }
    boolean mouseOn() {
      return (mouseX - leftPadding)/sF > x - 10 && (mouseX - leftPadding)/sF < x + 40 && mouseY/sF > 0 && mouseY/sF < 50;
    }
  }

  class Restart extends GameButton {
    {
      x = 800;
      image = loadImage("assets/restart.png");
    }

    void onPressed() {
      scene = new Game();
    }
  }

  class Pause extends GameButton {
    PImage pauImg, playImg;

    {
      x = 850;
      pauImg = loadImage("assets/pause.png");
      playImg = loadImage("assets/play.png");
      image = paused ? playImg : pauImg;
    }

    void onPressed() {
      paused = !paused;
      image = paused ? playImg : pauImg;
    }
  }
}
