class Tutorial extends Scene {
  int page;
  float viewDist = 150;
  Space[][] spaces;
  ArrayList<Slide> slides = new ArrayList<Slide>();
  Player p;
  PImage background;
  Slide slide;

  {
    page = 0;
    p = new Player();

    spaces = new Space[height/50 - 1][width/50];

    for (int y = 0; y < spaces.length; y++)
      for (int x = 0; x < spaces[y].length; x++)
        if (y != 0 || x != 0)
          spaces[y][x] = new Space(x * 50, y * 50, random(10) < 1);
        else
          spaces[y][x] = new Space(x * 50, y * 50, false);

    background = loadImage("assets/background.png");
    slides.add(new Slide1());

    slide = slides.get(0);
  }

  void show() {
    slide.show();
  }

  void update() {
    slide.update();
  }

  class Slide {
    ArrayList<Entity> entities = new ArrayList<Entity>();

    void show() {
    }
    void update() {
    }
    void onPressed() {
    }
  }

  class Slide1 extends Slide {
    int thing = 0;

    void show() {
      background(background);

      pushMatrix();
      translate(0, 50);
      if (thing > 0)
        for (int y = 0; y < spaces.length; y++)
          for (int x = 0; x < spaces[y].length; x++)
            spaces[y][x].show();

      for (Entity e : entities)
        e.show();

      p.show();

      popMatrix();

      fill(255);
      textAlign(LEFT, TOP);
      textSize(20);
      switch(thing) {
      case 0:
        text("This is your player,\nmove around with w-a-s-d.", 60, 50);
        break;
      case 1:
        text("You'll notice these blue things,\nthese are barriers.\nThey randomly generate every game.", 300, 200);
        break;
      }
    }

    void update() {
      p.update();
    }

    void onPressed() {
      switch(thing) {
      }
      thing++;
    }
  }

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
          //for (Entity e : entities)
          //if (e instanceof Enemy)
          //if (distE(this, e) < attackRad)
          //((Enemy) e).hit(attackRad);
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
}
