class Lose {
  Button[] buttons;

  {
    buttons = new Button[] {
      new RestartButton(),
      new ExitButton(),
    };
  }

  void show(float frames) {
    tint(255, 200);

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

  /*
  --------------------------
   BUTTON
   --------------------------
   */
  class Button {
    String text;
    int x, y, wid, hei;
    PImage image;
    color textCol;

    void show() {
      imageMode(CENTER);
      textAlign(CENTER, CENTER);

      if (mouseOn()) {
        image(image, x, y, wid + 10, hei + 5);
        fill(textCol);
        textSize((hei + 5)*0.7);
        text(text, x, y - hei/10);
      } else {
        image(image, x, y, wid, hei);
        fill(textCol);
        textSize(hei*0.7);
        text(text, x, y - hei/10);
      }

      imageMode(CORNER);
      rectMode(CORNER);
    }

    boolean mouseOn() {
      return mouseX > x - wid/2 && mouseX < x + wid/2 && mouseY > y - hei/2 && mouseY < y + hei/2;
    }

    void press() {
      if (mouseOn())
        onPressed();
    }

    void onPressed() {
    }
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
