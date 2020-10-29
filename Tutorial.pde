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
        if ((y != 0 || x != 0) && (y != 5 || x != 3))
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
    int thing = 0;

    void show() {
    }
    void update() {
    }
    void onPressed() {
    }
  }

  class Slide1 extends Slide {
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

      if (thing > 1) {
        noStroke();
        fill(255, 30, 30);
        rect(470, 10, p.health * 3, 30);

        stroke(50);
        strokeWeight(5);
        noFill();
        rect(470, 10, 300, 30);
      }
      if (thing > 4) {
        noStroke();
        fill(90, 170, 255);
        rect(30, 10, p.power * 3, 30);

        stroke(50);
        noFill();
        rect(30, 10, 300, 30);
      }
      if (thing > 6) {
        noStroke();
        fill(255);
        textSize(40);
        textAlign(CENTER, TOP);
        text("10.0", 400, 5);
      }

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
      case 2:
        text("This red bar shows your health.\nIt drops when you're hit by enemies and\nregenerates with time and through picking up hearts.", 350, 60);
        break;
      case 3:
        text("Pick up the heart to heal.", entities.get(0).pos.x, entities.get(0).pos.y + 20);
        break;
      case 4:
        text("They only heal so much,\nso you'll need to pick up more\nto heal completely.", entities.get(0).pos.x, entities.get(0).pos.y - 60);
        break;
      case 5:
        text("The blue bar shows you how charged your attack is.\nClick space to use it.", 50, 60);
        break;
      case 6:
        text("It will stun nearby enemies and cause them to glow.", 50, 60);
        break;
      case 7:
        text("This timer will show you how many seconds you have left.\nIt can be increased by collecting power ups.", 190, 60);
        break;
      }
    }

    void update() {
      p.update();

      for (int i = entities.size() - 1; i >= 0; i--)
        entities.get(i).update();
    }

    void onPressed() {
      switch(thing) {
      case 2:
        entities.add(new Heart());
        thing++;
        break;
      case 3:
        break;
      case 4:
        break;
      case 5: 
        break;
      case 7:
        //next scene
        break;
      default:
        thing++;
      }
    }

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

        if (thing == 4) {
          thing++; 
          entities.remove(this);
        }
        if (thing == 3) thing++;
      }
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
      health = 84;
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
      if (slide instanceof Slide1 && slide.thing == 5) slide.thing++;
    }
  }
}
