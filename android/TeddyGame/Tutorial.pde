class Tutorial extends GameScene {
  int page;
  float viewDist = 150;
  ArrayList<Barrier> barriers = new ArrayList<Barrier>();
  Player p;
  PImage background;
  Slide slide;
  Button backButton;

  {
    page = 0;
    p = new Player(Tutorial.this, 5, 5);

    for (int y = 0; y < 10; y++)
      for (int x = 0; x < 18; x++)
        if (y != 0 || x != 0)
          if (random(6) < 1)
            barriers.add(new Barrier(x * 50, y * 50));

    background = loadImage("assets/background.png");

    slide = new Slide1();

    backButton = new BackButton();
  }

  void show() {
    slide.show();

    backButton.show();
  }

  void update() {
    slide.update();
  }

  void onPressed() {
    if (backButton.mouseOn())
      backButton.onPressed();
    else
      slide.onPressed();
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
      background(0);
      image(background, 0, 0, 900 * sF, 550 * sF);

      pushMatrix();
      translate(0, 50 * sF);
      if (thing > 0)
        for (Barrier b : barriers)
          b.show();

      for (Entity e : entities)
        e.show();

      p.show();

      popMatrix();

      if (thing > 1) {
        noStroke();
        fill(255, 30, 30);
        rect(470 * sF, 10 * sF, (p.health * 3) * sF, 30 * sF);

        stroke(50);
        strokeWeight(5);
        noFill();
        rect(470 * sF, 10 * sF, 300 * sF, 30 * sF);
      }
      if (thing > 4) {
        noStroke();
        fill(90, 170, 255);
        rect(30 * sF, 10 * sF, (p.power * 3) * sF, 30 * sF);

        stroke(50);
        noFill();
        rect(30 * sF, 10 * sF, 300 * sF, 30 * sF);
      }
      if (thing > 6) {
        noStroke();
        fill(255);
        textSize(40);
        textAlign(CENTER, TOP);
        text("10.0", 400 * sF, 5 * sF);
      }

      fill(255);
      textAlign(LEFT, TOP);
      textSize(20);
      switch(thing) {
      case 0:
        text("This is your player,\nmove around with w-a-s-d.\nClick to continue.", 60 * sF, 50 * sF);
        break;
      case 1:
        text("You'll notice these things,\nthese are barriers.\nThey randomly generate every game.", 300 * sF, 200 * sF);
        break;
      case 2:
        text("This red bar shows your health.\nIt drops when you're hit by enemies and\nregenerates with time and through picking up hearts.", 350 * sF, 60 * sF);
        break;
      case 3:
        text("Pick up the heart to heal.", entities.get(0).pos.x * sF, (entities.get(0).pos.y + 20) * sF);
        break;
      case 4:
        text("They only heal so much,\nso you'll need to pick up more\nto heal completely.", entities.get(0).pos.x * sF, (entities.get(0).pos.y - 60) * sF);
        break;
      case 5:
        text("The blue bar shows you how charged your attack is.\nClick space to use it.", 50 * sF, 60 * sF);
        break;
      case 6:
        text("It will stun nearby enemies and cause them to glow.", 50 * sF, 60 * sF);
        break;
      case 7:
        text("This timer will show you how many seconds you have left.\nIt can be increased by collecting power ups.", 190 * sF, 60 * sF);
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
        entities.clear();
        slide = new Slide2();
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

        int x = (int) random(700)/50;
        int y = (int) random(100, 450)/50;

        for (Barrier b : barriers)
          if (b.x == x && b.y == y) {
            spawn();
            return;
          }
        pos = new PVector(x*50 + (50 - wid)/2, y*50 + (50 - hei)/2);
      }

      void show() {
        pushMatrix();
        translate(0, -extraHeight - 3);
        image(image, pos.x * sF, pos.y * sF, wid * sF, hei * sF);
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

  /* ------------
   TWO
   ------------ */
  class Slide2 extends Slide {
    void show() {
      background(0);
      image(background, 0, 0, width, height);

      pushMatrix();
      translate(0, 50 * sF);

      for (Entity e : entities)
        e.show();

      popMatrix();


      fill(255);
      textAlign(CENTER, BOTTOM);
      textSize(20);
      switch(thing) {
      case 0:
        text("Let's learn about all the power ups found throughout the game.", 450 * sF, 250 * sF);
        break;
      case 1:
        text("This is a Heart. As you've seen, it heals you.", 450 * sF, 200 * sF);
        break;
      case 2:
        text("This is a Speed Boost. It will follow you once it's picked up\ngranting you faster speed until it runs out.", 450 * sF, 200 * sF);
        break;
      case 3:
        text("This is a Time Increaser. It will grant you extra time up to 2 seconds,\nbut its boost will decrease as the game continues.", 450 * sF, 200 * sF);
        break;
      case 4:
        text("This is a Glowstone, and yes, we did take that from Minecraft.\nOnce picked up, it will cause all power ups and enemies\nto glow, allowing you to see them through the dark.", 450 * sF, 200 * sF);
        break;
      case 5:
        text("This is a View Doubler. You only have a limited view in game,\nand this will double it.", 450 * sF, 200 * sF);
        break;
      case 6:
        text("There are also several enemies out to get you\nin the game.", 450 * sF, 250 * sF);
        break;
      case 7:
        text("Ghosts change between being invisable and visible.\nThey do low damage, but over time it can cause a lot of damage.\nThey have a fast movement speed and, being ghosts, can go through the barriers.\nThey also have a large vision.", 450 * sF, 200 * sF);
        break;
      case 8:
        text("Cyclops are larger and clunkier.\nThey aren't the smartest and will be seen running into walls.\nThis may be funny, but their damage output is nothign to laugh at.\nThey have a medium movement speed and a small vision.", 450 * sF, 200 * sF);
        break;
      }
    }

    void update() {
      for (int i = entities.size() - 1; i >= 0; i--)
        entities.get(i).update();
    }

    void onPressed() {
      switch(thing) {
      case 0:
        entities.add(new Heart(Tutorial.this));
        break;
      case 1:
        entities.set(0, new SpeedBoost(Tutorial.this));
        break;
      case 2:
        entities.set(0, new Point(Tutorial.this));
        break;
      case 3:
        entities.set(0, new Glowstone(Tutorial.this));
        break;
      case 4:
        entities.set(0, new DoubleView(Tutorial.this));
        break;
      case 5:
        entities.clear();
        break;
      case 6:
        entities.add(new Ghost(Tutorial.this));
        break;
      case 7:
        entities.set(0, new Cyclops(Tutorial.this));
        break;
      case 8:
        scene = new Start();
        break;
      }
      thing++;
    }
  }
  class BackButton extends Button {
    {
      x = 100;
      y = 525;
      hei = 30;
      wid = 140;
      text = "Main Menu";
      image = loadImage("assets/startButton.png");
      textCol = color(255);
    }

    void onPressed() {
      scene = new Start();
    }
  }
}
