class Lose extends Scene {
  Button[] buttons;

  {
    buttons = new Button[] {
      new RestartButton()
    };
  }

  void show() {
    for (Button b : buttons)
      b.show();
  }

  void update() {
  }

  /*
  --------------------------
   BUTTON
   --------------------------
   */
  class Button {
    String text;
    int x, y, wid, hei;
    color col, textCol;

    void show() {
      rectMode(CENTER);
      textAlign(CENTER, CENTER);

      fill(col);
      if (mouseOn()) {
        strokeWeight(5);
        stroke(255, 255, 0);
        rect(x, y, wid + 10, hei + 5, 20);
        fill(textCol);
        textSize((hei + 5)*0.7);
        text(text, x, y - hei/10);
      } else {
        noStroke();
        rect(x, y, wid, hei, 20);
        fill(textCol);
        textSize(hei*0.7);
        text(text, x, y - hei/10);
      }
      rectMode(CORNER);
    }

    boolean mouseOn() {
      return mouseX > x - wid/2 && mouseX < x + wid/2 && mouseY > y - hei/2 && mouseY < y + hei/2;
    }

    void onPressed() {
    }
  }

  class RestartButton extends Button {
    {
      x = width / 2;
      y = 150;
      wid = 500;
      hei = 70;
      text = "Try Again?";
      col = color(100, 200);
      textCol = color(255, 200);
    }

    void onPressed() {
    }
  }
}
