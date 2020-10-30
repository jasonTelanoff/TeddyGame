class Start extends Scene {
  PImage background;
  ArrayList<Entity> entities = new ArrayList<Entity>();
  ArrayList<Button> buttons = new ArrayList<Button>();
  Space[][] spaces;
  Title title;

  Start() {
    int ghosts = 10, cyclops = 6, hearts = 3, speeds = 3, points = 3, glows = 2, views = 2;
    background = loadImage("assets/startBackground.png");
    
    if(!backgroundSound.isPlaying()) backgroundSound.loop();
    
    title = new Title();

    spaces = new Space[height/50][width/50];


    for (int y = 0; y < spaces.length; y++)
      for (int x = 0; x < spaces[y].length; x++)
        spaces[y][x] = new Space(x * 50, y * 50, random(6) < 1);

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

    buttons.add(new StartButton());
    buttons.add(new TutorialButton());
    buttons.add(new InfoButton());
  }

  void show() {
    background(background);

    for (int y = 0; y < spaces.length; y++)
      for (int x = 0; x < spaces[y].length; x++)
        spaces[y][x].show();

    for (Entity e : entities)
      e.show();

    title.show();

    tint(255, 200);

    for (Button b : buttons)
      b.show();

    noTint();
  }

  void update() {
    title.update();
    
    for (Entity e : entities)
      e.update();
  }

  void onPressed() {
    for (Button b : buttons)
      if (b.mouseOn())
        b.onPressed();
  }

  class StartButton extends Button {
    {
      text = "Start Game";
      x = 450;
      y = 250;
      wid = 500;
      hei = 70;
      image = loadImage("assets/startButton.png");
      textCol = color(255, 200);
    }

    void onPressed() {
      backgroundSound.stop();
      scene = new Game();
    }
  }

  class TutorialButton extends Button {
    {
      text = "How to Play";
      x = 450;
      y = 340;
      wid = 400;
      hei = 60;
      image = loadImage("assets/startButton.png");
      textCol = color(255, 200);
    }

    void onPressed() {
      backgroundSound.stop();
      scene = new Tutorial();
    }
  }

  class InfoButton extends Button {
    {
      text = "Information";
      x = 450;
      y = 420;
      wid = 400;
      hei = 60;
      image = loadImage("assets/startButton.png");
      textCol = color(255, 200);
    }

    void onPressed() {
      scene = new Information();
    }
  }

  /*
  --------------------------
   ENEMY
   --------------------------
   */
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
      int x = (int) random(width - 50)/50;
      int y = (int) random(height - 100)/50;

      if (!spaces[y][x].collision)
        pos = new PVector(x*50 + (50 - wid)/2, y*50 + (50 - hei)/2);
      else
        spawn();
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
      pos = playerMovement(vel, speed, this, spaces);

      facingRight = vel.x > 0;
    }
  }

  /*
  --------------------------
   POWER UP
   --------------------------
   */
  class PowerUp extends Entity {
    float extraHeight, extraValue = 0;

    void spawn() {
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
}
