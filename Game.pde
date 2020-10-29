class Game extends Scene {
  Player p;
  ArrayList<Entity> entities = new ArrayList<Entity>();
  ArrayList<Button> buttons = new ArrayList<Button>();
  Space[][] spaces;
  int framesAlive = 0, framesLeft = 600;
  float viewDist = 150;
  PImage background;
  boolean paused = false;

  Game(int ghosts, int cyclops, int hearts, int speeds, int points, int glows, int views) {
    p = new Player();
    background = loadImage("assets/background.png");

    spaces = new Space[height/50 - 1][width/50];

    for (int y = 0; y < spaces.length; y++)
      for (int x = 0; x < spaces[y].length; x++)
        if (y != 0 || x != 0)
          spaces[y][x] = new Space(x * 50, y * 50, random(6) < 1);
        else
          spaces[y][x] = new Space(x * 50, y * 50, false);

    for (int i = 0; i < ghosts; i++)
      entities.add(new Ghost());

    for (int i = 0; i < hearts; i++)
      entities.add(new Heart());

    for (int i = 0; i < speeds; i++)
      entities.add(new SpeedBoost());

    for (int i = 0; i < points; i++)
      entities.add(new Point());

    for (int i = 0; i < cyclops; i++)
      entities.add(new Cyclops());

    for (int i = 0; i < glows; i++)
      entities.add(new Glowstone());

    for (int i = 0; i < views; i++)
      entities.add(new DoubleView());

    buttons.add(new Restart());
    buttons.add(new Pause());
  }

  void show() {
    background(background);

    pushMatrix();
    translate(0, 50);
    for (int y = 0; y < spaces.length; y++)
      for (int x = 0; x < spaces[y].length; x++)
        spaces[y][x].show();

    for (Entity e : entities)
      e.show();

    p.show();

    popMatrix();

    overlay();

    for (Entity e : entities)
      e.showGlow();

    noStroke();
    fill(90, 170, 255);
    rect(30, 10, p.power * 3, 30);

    fill(255, 30, 30);
    rect(470, 10, p.health * 3, 30);

    stroke(50);
    strokeWeight(5);
    noFill();
    rect(30, 10, 300, 30);
    rect(470, 10, 300, 30);

    noStroke();
    fill(255);
    textSize(40);
    textAlign(CENTER, TOP);
    text(((float) framesLeft/60 + "0000").substring(0, 4), 400, 5);

    for (Button b : buttons)
      b.show();
  }

  void update() {
    if (!paused) {
      p.speed = 5;

      for (Entity e : entities)
        e.update();
      p.update();

      framesAlive++;

      framesLeft--;
    }

    if (p.health <= 0 || framesLeft == 0) {
      println("You survived for " + ((float) framesAlive/60) + " seconds");
      scene = new Lose();
    }
  }
  
  void onPressed() {
    for (Button b : buttons)
      if (b.mouseOn())
        b.onPressed();
  }

  /*
  --------------------------
   PLAYER
   --------------------------
   */
  class Player extends Entity {
    int attackRad, framesToHeal, totalHeal, framesView;
    float health, power, speed;
    boolean attacking, facingRight;
    PImage imageLeft;

    Player() {
      pos = new PVector(5, 5);
      wid = 40;
      hei = 40;
      health = 100;
      power = 50;
      speed = 5;
      totalHeal = 60;
      framesToHeal = 0;
      framesView = 0;
      image = loadImage("assets/playerRight.png");
      imageLeft  = loadImage("assets/playerLeft.png");
    }

    void show() {
      if (facingRight)
        image(image, pos.x, pos.y, wid, hei);
      else image(imageLeft, pos.x, pos.y, wid, hei);

      if (attacking) {
        stroke(90, 170, 255, 100);
        noFill();
        strokeWeight(10);
        circle(pos.x + wid/2, pos.y + hei/2, attackRad);
      }
    }

    void update() {
      if (attacking) {
        if (power > 0) {
          attackRad+= 15;
          power-= 5;
          for (Entity e : entities)
            if (e instanceof Enemy)
              if (distE(this, e) < attackRad)
                ((Enemy) e).hit(attackRad);
        } else attacking = false;
      } else 
      power+=0.2;

      if (framesView > 0) {
        viewDist = 200;
        framesView--;
      } else
        viewDist = 150;

      if (framesToHeal > 0)
        framesToHeal--;
      else {
        framesToHeal = totalHeal;
        health+= 1.5;
      }

      power = constrain(power, 0, 100);
      health = constrain(health, 0, 100);

      PVector vel = new PVector(0, 0);
      if (w) vel.y-= speed;
      if (a) {
        vel.x-= speed;
        facingRight = false;
      }
      if (s) vel.y+= speed;
      if (d) {
        vel.x+= speed;
        facingRight = true;
      }
      if (sp && power == 100) attack();

      pos = playerMovement(vel, speed, this, spaces);
    }

    void attack() {
      attackRad = 0;
      attacking = true;
      framesToHeal = totalHeal;
    }
  }

  /*
  --------------------------
   ENEMY
   --------------------------
   */
  class Enemy extends Entity {
    PVector target;
    float damage, speed, vision;
    int damDelay, frFromLast = 0, size, framesOff = 60, totalFramesOff, framesSiceTarget = 0;
    boolean dieOnDam, facingRight;
    PImage imageLeft;

    void show() {
      if (facingRight)
        image(image, pos.x, pos.y, wid, hei);
      else
        image(imageLeft, pos.x, pos.y, wid, hei);
    }

    void update() {
      if (glowing > 0)
        glowing--;

      if (framesOff > 0)
        framesOff--;
      else {
        if (distE(this, p) < vision)
          move();
        else
          defMove();

        pos.x = constrain(pos.x, 0, width - wid);
        pos.y = constrain(pos.y, 0, height - hei - 50);

        if (distE(this, p) < size) collided();

        if (frFromLast < damDelay)
          frFromLast++;
      }
    }

    void spawn() {    
      int x = (int) random(width - 50)/50;
      int y = (int) random(height - 100)/50;

      if (!spaces[y][x].collision) {
        pos = new PVector(x*50 + (50 - wid)/2, y*50 + (50 - hei)/2);
        if (p.attacking && distE(this, p) < 300)
          spawn();
      } else
        spawn();
    }

    void collided() {
      if (dieOnDam)
        entities.remove(this);
      else if (frFromLast == damDelay) {
        p.health-= damage;
        p.framesToHeal = p.totalHeal;
        frFromLast = 0;
      }
    }

    void hit(int rad) {
      framesOff = (int) map(rad, 0, 300, totalFramesOff, totalFramesOff/10);
      glowing = 30;
    }

    void defMove() {
    }

    void move() {
    }
  }

  class Ghost extends Enemy {
    PVector vel, TEDDYISDUMB;
    float oVal;

    Ghost() {
      vel = new PVector(0, 0);
      TEDDYISDUMB = new PVector(0, 0);
      pos = new PVector(random(width), random(height));
      damage = 6.3;
      damDelay = 60;
      wid = 35;
      hei = 35;
      dieOnDam = false;
      size = 20;
      speed = 2.7;
      vision = 200;
      totalFramesOff = 70;
      oVal = random(TWO_PI);
      image = loadImage("assets/ghostRight.png");
      imageLeft = loadImage("assets/ghostLeft.png");
    }

    void show() {
      if (framesOff > 0) tint(255, 255);
      else tint(255, 100*sin(oVal) + 80);

      if (facingRight)
        image(image, pos.x, pos.y, wid, hei);
      else
        image(imageLeft, pos.x, pos.y, wid, hei);

      noTint();

      oVal+= 0.01;
      if (oVal > TWO_PI)
        oVal-= TWO_PI;
    }

    void defMove() {
      if (target == null || framesSiceTarget == 0 || dist(pos.x, pos.y, target.x, target.y) < 100) {
        framesSiceTarget = 180;
        target = new PVector(random(width), random(height));
      } else framesSiceTarget--;
      PVector acc = PVector.sub(target, PVector.add(pos, new PVector(wid/2, hei/2))).setMag(5);
      TEDDYISDUMB.add(PVector.random2D());
      TEDDYISDUMB.setMag(speed);
      acc.add(TEDDYISDUMB);

      vel.add(acc);
      vel.setMag(constrain(vel.mag(), 0, speed));
      pos.add(vel);

      facingRight = vel.x > 0;
    }

    void move() {
      target = null;
      PVector acc = PVector.sub(PVector.add(p.pos, new PVector(p.wid/2, p.hei/2)), 
        PVector.add(pos, new PVector(wid/2, hei/2))).setMag(5);
      TEDDYISDUMB.add(PVector.random2D());
      TEDDYISDUMB.setMag(speed);
      acc.add(TEDDYISDUMB);

      vel.add(acc);
      vel.setMag(constrain(vel.mag(), 0, speed));
      pos.add(vel);

      facingRight = vel.x > 0;
    }
  }

  class Cyclops extends Enemy {
    PVector vel;

    Cyclops() {
      vel = new PVector(0, 0);
      pos = new PVector(random(width), random(height));
      damage = 47;
      damDelay = 180;
      wid = 50;
      hei = 50;
      dieOnDam = false;
      size = 35;
      speed = 1.8;
      vision = 140;
      totalFramesOff = 30;
      image = loadImage("assets/cyclopsRight.png");
      imageLeft = loadImage("assets/cyclopsLeft.png");
    }

    void defMove() {
      if (target == null || framesSiceTarget == 0 || dist(pos.x, pos.y, target.x, target.y) < 100) {
        framesSiceTarget = 180;
        target = new PVector(random(width), random(height));
      } else framesSiceTarget--;
      vel = PVector.sub(target, pos);
      vel.setMag(constrain(vel.mag(), 0, speed/3));
      pos = playerMovement(vel, speed, this, spaces);

      facingRight = vel.x > 0;
    }

    void move() {
      target = null;
      vel = PVector.sub(p.pos, pos);
      vel.setMag(speed);
      pos = playerMovement(vel, speed, this, spaces);

      facingRight = vel.x > 0;
    }
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
   POWER UP
   --------------------------
   */
  class PowerUp extends Entity {
    PVector vel;
    int pickUpRange = 20, animateRange;
    float extraHeight, extraValue = 0, speed;
    boolean animating;

    void spawn() {
      vel = new PVector(0, 0);

      int x = (int) random(width - 50)/50;
      int y = (int) random(height - 100)/50;

      if (!spaces[y][x].collision)
        pos = new PVector(x*50 + (50 - wid)/2, y*50 + (50 - hei)/2);
      else
        spawn();
    }

    void show() {
      pushMatrix();
      translate(0, -extraHeight - 3);
      image(image, pos.x, pos.y, wid, hei);
      popMatrix();
    }

    void update() {
      if (glowing > 0)
        glowing--;

      if (animating && distE(this, p) < pickUpRange) {
        animating = false;
        onPickUp();
      } else if (distE(this, p) < animateRange) {
        animating = true;
        animate();
      }

      extraValue+= 0.06;
      extraHeight = 5 * sin(extraValue);
    }

    void onPickUp() {
    }

    void animate() {
      PVector acc = PVector.sub(PVector.add(p.pos, new PVector(p.wid/2, p.hei/2)), 
        PVector.add(pos, new PVector(wid/2, hei/2))).setMag(5);

      vel.add(acc);
      vel.setMag(constrain(vel.mag(), 0, speed));
      pos.add(vel);
    }
  }

  class Heart extends PowerUp {
    Heart() {
      wid = 35;
      hei = 35;
      animateRange = 65;
      speed = 3;
      image = loadImage("assets/heart.png");
      spawn();
    }

    void onPickUp() {
      p.health+= 8.8;
      p.health = constrain(p.health, 0, 100);
      spawn();
    }
  }

  class SpeedBoost extends PowerUp {
    float wid2, hei2;
    int framesLeft;

    SpeedBoost() {
      wid = 30;
      hei = 30;
      pickUpRange = 100;
      animateRange = 100;
      speed = 12;
      image = loadImage("assets/speedBoost.png");
      framesLeft = 60;
      spawn();
      wid2 = 30;
      hei2 = 30;
    }

    void onPickUp() {
      if (framesLeft > 0) {
        framesLeft--;
        wid2-= 0.5;
        hei2-= 0.5;
        wid = (int) wid2;
        hei = (int) hei2;
        p.speed = 6;
      } else {
        wid2 = 30;
        hei2 = 30;
        wid = (int) wid2;
        hei = (int) hei2;
        framesLeft = 60;
        spawn();
      }
    }
  }

  class Point extends PowerUp {
    int frames;

    Point() {
      wid = 20;
      hei = 20;
      animateRange = 64;
      speed = 8;
      image = loadImage("assets/point.png");
      frames = 180;
      spawn();
    }

    void onPickUp() {
      framesLeft+= frames;
      if (frames > 90)
        frames-= 5;
      //if(framesLeft > 600) framesLeft = 600;
      spawn();
    }
  }

  class Glowstone extends PowerUp {
    int frames;

    Glowstone() {
      wid = 25;
      hei = 25;
      animateRange = 70;
      speed = 10;
      image = loadImage("assets/glowstone.png");
      spawn();
      frames = 120;
    }

    void onPickUp() {
      for (Entity e : entities)
        e.glowing = frames;
      spawn();
    }
  }

  class DoubleView extends PowerUp {
    int frames;

    DoubleView() {
      wid = 25;
      hei = 25;
      animateRange = 80;
      speed = 3;
      image = loadImage("assets/view.png");
      spawn();
      frames = 120;
    }

    void onPickUp() {
      p.framesView = frames;
      spawn();
    }
  }

  // Absorbtion

  /*
  --------------------------
   BUTTON
   --------------------------
   */
  class Button {
    int x;
    PImage image;

    void show() {
      if (mouseOn()) image(image, x - 5, 5, 40, 40);
      else image(image, x, 10, 30, 30);
    }
    boolean mouseOn() {
      return mouseX > x - 10 && mouseX < x + 40 && mouseY > 0 && mouseY < 50;
    }
    void onPressed() {
    }
  }

  class Restart extends Button {
    {
      x = 800;
      image = loadImage("assets/restart.png");
    }

    void onPressed() {
      scene = new Game(4, 3, 2, 2, 2, 1, 1);
    }
  }

  class Pause extends Button {
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
