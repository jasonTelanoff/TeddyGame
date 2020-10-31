class Button {
  String text;
  int x, y, wid, hei;
  PImage image;
  color textCol;

  void show() {
    imageMode(CENTER);
    textAlign(CENTER, CENTER);

    image(image, x * sF, y * sF, wid * sF, hei * sF);
    fill(textCol);
    textSize(hei*0.7 * sF);
    text(text, x * sF, (y - hei/10) * sF);

    imageMode(CORNER);
    rectMode(CORNER);
  }

  boolean mouseOn() {
    return (mouseX - leftPadding)/sF > x - wid/2 && (mouseX - leftPadding)/sF < x + wid/2 && mouseY/sF > y - hei/2 && mouseY/sF < y + hei/2;
  }

  void onPressed() {
  }
}
