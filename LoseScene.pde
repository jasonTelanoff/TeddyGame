class Lose {
  Button[] buttons;

  {
    buttons = new Button[] {
      new RestartButton(),
      new ExitButton(),
    };
  }

  void show(float frames) {
    fill(100, 200);
    noStroke();
    rect(200, 130, 500, 300, 50);
    textAlign(CENTER, TOP);
    textSize(50);
    fill(255);
    // Add different messages
    text("Game Over", 450, 150);
    textSize(30);
    text("You survived for " + (frames/60 + "00000").substring(0, 5) + " seconds", 450, 210);

    for (Button b : buttons)
      b.show();
  }

  void update() {
    if (rs)
      scene = new Game(4, 3, 2, 2, 2, 1, 1);
  }

  void onPressed() {
    for (Button b : buttons)
      if (b.mouseOn())
        b.onPressed();
  }

  class RestartButton extends Button {
    {
      x = 450;
      y = 300;
      wid = 300;
      hei = 50;
      text = "Try Again";
      image = loadImage("assets/startButton.png");
      textCol = color(255, 200);
    }

    void onPressed() {
      scene = new Game(4, 3, 2, 2, 2, 1, 1);
    }
  }
  
  class ExitButton extends Button {
    {
      x = 450;
      y = 360;
      wid = 300;
      hei = 50;
      text = "Title Screen";
      image = loadImage("assets/startButton.png");
      textCol = color(255, 200);
    }

    void onPressed() {
      scene = new Start();
    }
  }
}
