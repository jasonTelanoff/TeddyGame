class Tutorial extends GameScene {
  Tutorial tut;
  int page;
  float viewDist = 150;
  PImage background;
  Slide slide;
  Button backButton;

  {
    tut = this;
    page = 0;
    p = new Player(this, 5, 5);

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

  void onReleased() {
    p.joystick.reset();
  }

  class Slide {
    NextButton nextButton;
    int thing = 0;

    void show() {
    }
    void update() {
    }
    void onPressed() {
      if (nextButton.mouseOn())
        nextButton.onPressed();
      else
        p.joystick.pos = new PVector(mouseX, mouseY);
    }
  }

  class Slide1 extends Slide {
    {
      nextButton = new NextButton1(this);
    }

    void show() {
      background(0);
      image(background, 0, 0, 900 * sF, 550 * sF);

      pushMatrix();
      translate(0, 50 * sF);
      if (thing > 0)
        for (Barrier b : barriers)
          b.show();
      
      for (int i = entities.size() - 1; i >= 0; i--)
        entities.get(i).show();

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
        textSize(40 * sF);
        textAlign(CENTER, TOP);
        text("10.0", 400 * sF, 5 * sF);
      }

      fill(255);
      textAlign(LEFT, TOP);
      textSize(20 * sF);
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

      nextButton.show();
    }

    void update() {
      p.update();

      for (int i = entities.size() - 1; i >= 0; i--)
        entities.get(i).update();
    }
  }

  /* ------------
   TWO
   ------------ */
  class Slide2 extends Slide {
    {
      nextButton = new NextButton2(this);
    }

    void show() {
      background(0);
      image(background, 0, 0, width, height);

      pushMatrix();
      translate(0, 50 * sF);

      for (int i = entities.size() - 1; i >= 0; i--)
        entities.get(i).update();

      popMatrix();


      fill(255);
      textAlign(CENTER, BOTTOM);
      textSize(20 * sF);
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

      nextButton.show();
    }

    void update() {
      for (int i = entities.size() - 1; i >= 0; i--)
        entities.get(i).update();
    }
  }

  class NextButton extends Button {
    Slide slide;

    {
      x = 800;
      y = 525;
      hei = 30;
      wid = 140;
      text = "Continue";
      image = loadImage("assets/startButton.png");
      textCol = color(255);
    }
  }

  class NextButton1 extends NextButton {
    NextButton1(Slide slide) {
      this.slide = slide;
    }

    void onPressed() {
      switch(slide.thing) {
      case 2:
        entities.add(new Heart(tut));
        slide.thing++;
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
        slide.thing++;
      }
    }
  }

  class NextButton2 extends NextButton {
    NextButton2(Slide slide) {
      this.slide = slide;
    }

    void onPressed() {
      switch(slide.thing) {
      case 0:
        entities.add(new Heart(tut));
        break;
      case 1:
        entities.set(0, new SpeedBoost(tut));
        break;
      case 2:
        entities.set(0, new Point(tut));
        break;
      case 3:
        entities.set(0, new Glowstone(tut));
        break;
      case 4:
        entities.set(0, new DoubleView(tut));
        break;
      case 5:
        entities.clear();
        break;
      case 6:
        entities.add(new Ghost(tut));
        break;
      case 7:
        entities.set(0, new Cyclops(tut));
        break;
      case 8:
        scene = new Start();
        break;
      }
      slide.thing++;
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
