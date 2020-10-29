class Tutorial extends Scene {
  int page;
  float viewDist = 150;
  Space[][] spaces;
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

    slide = new Slide1();
  }

  void show() {
    slide.show();
  }

  void update() {
    slide.update();
  }

  void onPressed() {
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
        text("This is your player,\nmove around with w-a-s-d.\nClick to continue.", 60, 50);
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

  /* ------------
   TWO
   ------------ */
  class Slide2 extends Slide {
    void show() {
      background(background);

      pushMatrix();
      translate(0, 50);

      for (Entity e : entities)
        e.show();

      popMatrix();


      fill(255);
      textAlign(CENTER, BOTTOM);
      textSize(20);
      switch(thing) {
      case 0:
        text("Let's learn about all the power ups found throughout the game.", 450, 250);
        break;
      case 1:
        text("This is a Heart. As you've seen, it heals you.", 450, 200);
        break;
      case 2:
        text("This is a Speed Boost. It will follow you once it's picked up\ngranting you faster speed until it runs out.", 450, 200);
        break;
      case 3:
        text("This is a Time Increaser. It will grant you extra time up to 2 seconds,\nbut its boost will decrease as the game continues.", 450, 200);
        break;
      case 4:
        text("This is a Glowstone, and yes, we did take that from Minecraft.\nOnce picked up, it will cause all power ups and enemies\nto glow, allowing you to see them through the dark.", 450, 200);
        break;
      case 5:
        text("This is a View Doubler. You only have a limited view in game,\nand this will double it.", 450, 200);
        break;
      case 6:
        text("There are also several enemies out to get you\nin the game.", 450, 250);
        break;
      case 7:
        text("Ghosts change between being invisable and visible.\nThey do low damage, but over time it can cause a lot of damage.\nThey have a fast movement speed and, being ghosts, can go through the barriers.\nThey also have a large vision.", 450, 200);
        break;
      case 8:
        text("Cyclopse are larger and clunkier.\nThey aren't the smartest and will be seen running into walls.\nThis may be funny, but their damage output is nothign to laugh at.\nThey have a medium movement speed and a small vision.", 450, 200);
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
        entities.add(new Heart());
        break;
      case 1:
        entities.set(0, new SpeedBoost());
        break;
      case 2:
        entities.set(0, new Point());
        break;
      case 3:
        entities.set(0, new Glowstone());
        break;
      case 4:
        entities.set(0, new DoubleView());
        break;
      case 5:
        entities.clear();
        break;
      case 6:
        entities.add(new Ghost());
        break;
      case 7:
        entities.set(0, new Cyclops());
        break;
      case 8:
        scene = new Start(10, 6, 3, 3, 3, 2, 2);
        break;
      }
      thing++;
    }

    class PowerUp extends Entity {
      PVector vel;
      float extraHeight, extraValue = 0;

      void spawn() {
        pos = new PVector(450 - wid/2, 210 - hei/2);
      }

      void show() {
        pushMatrix();
        translate(0, -extraHeight - 3);
        image(image, pos.x, pos.y, wid, hei);
        popMatrix();
      }

      void update() {
        extraValue+= 0.06;
        extraHeight = 5 * sin(extraValue);
      }
    }

    class Heart extends PowerUp {
      {
        wid = 35;
        hei = 35;
        image = loadImage("assets/heart.png");
        spawn();
      }
    }

    class SpeedBoost extends PowerUp {
      {
        wid = 30;
        hei = 30;
        image = loadImage("assets/speedBoost.png");
        spawn();
      }
    }

    class Point extends PowerUp {
      {
        wid = 20;
        hei = 20;
        image = loadImage("assets/point.png");
        spawn();
      }
    }

    class Glowstone extends PowerUp {
      {
        wid = 25;
        hei = 25;
        image = loadImage("assets/glowstone.png");
        spawn();
      }
    }

    class DoubleView extends PowerUp {
      {
        wid = 25;
        hei = 25;
        image = loadImage("assets/view.png");
        spawn();
      }
    }

    class Ghost extends PowerUp {
      float oVal;

      {
        wid = 35;
        hei = 35;
        pos = new PVector(450 - wid/2, 210 - hei/2);
        oVal = random(PI, TWO_PI);
        image = loadImage("assets/ghostLeft.png");
      }

      void show() {
        tint(255, 100*sin(oVal) + 100);
        pushMatrix();
        translate(0, -extraHeight - 3);
        image(image, pos.x, pos.y, wid, hei);
        popMatrix();

        noTint();

        oVal+= 0.01;
        if (oVal > TWO_PI)
          oVal-= TWO_PI;
      }

      void update() {
        extraValue+= 0.06;
        extraHeight = 5 * sin(extraValue);
      }
    }

    class Cyclops extends Entity {
      {
        wid = 50;
        hei = 50;
        pos = new PVector(450 - wid/2, 210 - hei/2);
        image = loadImage("assets/cyclopsLeft.png");
      }

      void show() {
        image(image, pos.x, pos.y, wid, hei);
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
