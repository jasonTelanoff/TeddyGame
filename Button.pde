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

    void onPressed() {
    }
  }
