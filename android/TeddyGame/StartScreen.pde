class Start extends GameScene {
  PImage background;
  ArrayList<Button> buttons = new ArrayList<Button>();
  Title title;

  Start() {
    int ghosts = 10, cyclops = 6, hearts = 3, speeds = 3, points = 3, glows = 2, views = 2;
    background = loadImage("assets/startBackground.png");

    if (!backgroundSound.isPlaying()) backgroundSound.loop();

    title = new Title();

    for (int y = 0; y < 10; y++)
      for (int x = 0; x < 18; x++)
        if (y != 0 || x != 0)
          if (random(6) < 1)
            barriers.add(new Barrier(x * 50, y * 50));
            
    p = new Player(this, -500, -500);

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

    buttons.add(new StartButton());
    buttons.add(new TutorialButton());
    buttons.add(new InfoButton());
  }

  void show() {
    background(0);
    image(background, 0, 0, 550 * sF, 900 * sF);

    for (Barrier b : barriers)
      b.show();

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
    title.onPressed();
	
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
}
