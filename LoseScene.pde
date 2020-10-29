class Lose extends Scene {
  Button[] buttons;

  {
    buttons = new Button[] {
      new RestartButton()
    };
  }

  void show() {
    tint(255, 200);

    textAlign(CENTER, CENTER);
    textSize(50);
    fill(255);
    text("Game Over :(", 450, 50);
    
    for (Button b : buttons)
      b.show();
  }

  void update() {
    if (rs)
      scene = new Game(4, 3, 2, 2, 2, 1, 1);
  }
  
  void onPressed() {
    for (Button b : buttons)
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
    
    void onPressed() {}
  }

  class RestartButton extends Button {
    {
      x = width / 2;
      y = 150;
      wid = 500;
      hei = 70;
      text = "Try Again?";
      image = loadImage("assets/startButton.png");
      textCol = color(255, 200);
    }

    void onPressed() {
      scene = new Game(4, 3, 2, 2, 2, 1, 1);
    }
  }
}
