class Information extends Scene {
  PImage background;
  boolean credits, shown = false, animating, yt;
  ArrayList<Entity> entities = new ArrayList<Entity>();
  Button backButton;
  float ang;
  int clicks, frames, maxEntities = 30;
  String name1 = "Teddy Telanoff", name2 = "Jason Telanoff", yt1 = "Treidex Semextetry", yt2 = "BlahFromAbove";

  {
    background = loadImage("assets/startBackground.png");
    backButton = new BackButton();
  }

  void show() {
    background(background);

    for (Entity e : entities)
      e.show();

    textAlign(CENTER, CENTER);
    fill(255);
    noStroke();
    textSize(30);
    if (!credits)
      text("This is a game. The goal of the game is to\nsurvive as long as possible. Ghosts will try to\ntake your sole, and Cyclops will bash your body.\n" + 
        "Only the bravest and strongest gamers will\nsurvive long enough to question what\nlife decisions led them to the point in their life\nwhere they're playing a game with no end\nfor minutes on end.", 450, 275);
    else {
      text("Credits:\nThe original idea : " + (yt?yt1:name1) + "\nProject Manager : " + (yt?yt2:name2) + "\nLead developer :               \nArtwork : " + (yt?yt2:name2), 450, 275);
      pushMatrix();
      translate((yt?620:610), 320);
      if (animating)
        rotate(ang);
      text((yt?yt2:name2), 0, 0);
      popMatrix();
    }
    
    fill(255);
    textSize(20);
    textAlign(RIGHT, BOTTOM);
    text("Click anywhere to continue", 890, 540);

    backButton.show();
  }

  void update() {
    for (Entity e : entities)
      e.update();

    if (animating)
      if (frames > 0) {
        frames--;
        ang+= 0.105;
      } else {
        clicks = 0;
        animating = false;
      }
    if (shown)
      scene = new Start();
  }

  void onPressed() {
    if (backButton.mouseOn())
      backButton.onPressed();
    else if (credits) {
      if (!yt && mouseX > 500 && mouseX < 720 && mouseY > 300 && mouseY < 350) {
        if (animating) {
          if (clicks < 3)
            clicks++;
          else
            yt = true;
        } else {
          frames = 60;
          animating = true;
        }
      } else {
        if (keyPressed && !shown) {
          textAlign(RIGHT, BOTTOM);
          textSize(12);
          text("heh, nerd", 900, 550);
          shown = true;
        } else
          scene = new Start();
      }
    } else if (mouseX > 530 && mouseX < 640 && mouseY > 145 && mouseY < 185) {
      if (entities.size() < maxEntities)
        entities.add(new Ghost());
    } else if (mouseX > 385 && mouseX < 500 && mouseY > 190 && mouseY < 230) {
      if (entities.size() < maxEntities)
        entities.add(new Cyclops());
    } else credits = true;
  }

  class BackButton extends Button {
    {
      x = 45;
      y = 525;
      hei = 30;
      wid = 70;
      text = "Back";
      image = loadImage("assets/startButton.png");
      textCol = color(255);
    }

    void onPressed() {
      if (credits)
        credits = false;
      else
        scene = new Start();
    }
  }

  class Enemy extends Entity {
    PVector target;
    float speed;
    boolean facingRight;
    PImage imageLeft;

    void show() {
      if (facingRight)
        image(image, pos.x, pos.y, wid, hei);
      else
        image(imageLeft, pos.x, pos.y, wid, hei);
    }

    void update() {
      defMove();

      pos.x = constrain(pos.x, 0, width - wid);
      pos.y = constrain(pos.y, 0, height - hei - 50);
    }

    void spawn() {    
      pos = new PVector(random(width - 50), random(height - 50));
    }

    void defMove() {
    }
  }

  class Ghost extends Enemy {
    PVector vel, TEDDYISDUMB;
    float oVal;

    {
      vel = new PVector(0, 0);
      TEDDYISDUMB = new PVector(0, 0);
      pos = new PVector(random(width), random(height));
      wid = 35;
      hei = 35;
      speed = 2.7;
      oVal = random(TWO_PI);
      image = loadImage("assets/ghostRight.png");
      imageLeft = loadImage("assets/ghostLeft.png");
    }

    void show() {
      tint(255, 100*sin(oVal) + 80);

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
      if (target == null || dist(pos.x, pos.y, target.x, target.y) < 100) target = new PVector(random(width), random(height));
      PVector acc = PVector.sub(target, PVector.add(pos, new PVector(wid/2, hei/2))).setMag(5);
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
    {
      vel = new PVector(0, 0);
      pos = new PVector(random(width), random(height));
      wid = 50;
      hei = 50;
      speed = 1.8;
      image = loadImage("assets/cyclopsRight.png");
      imageLeft = loadImage("assets/cyclopsLeft.png");
    }

    void defMove() {
      if (target == null || dist(pos.x, pos.y, target.x, target.y) < 100) target = new PVector(random(width), random(height));
      vel = PVector.sub(target, pos);
      vel.setMag(constrain(vel.mag(), 0, speed/3));
      pos.add(vel);

      facingRight = vel.x > 0;
    }
  }
}
