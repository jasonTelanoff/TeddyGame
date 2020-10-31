class Title {
  PVector pos;
  PImage image;
  float val;

  {
    pos = new PVector(450 * sF, 120 * sF);
    image = loadImage("assets/title.png");
  }

  void show() {
    imageMode(CENTER);
    pushMatrix();
    translate(pos.x + sin(val)*10, pos.y + cos(val)*5);
    rotate(sin(val)/15);
    image(image, 0, 0, 700 * sF, 137 * sF);
    imageMode(CORNER);
    popMatrix();

    pushMatrix();
    fill(255, 255, 0);
    textSize(sin(val * 2)*2 + 20);
    translate(pos.x + 330 * sF, pos.y + 60 * sF);
    rotate(-0.3 + cos(val)/8);
    text("By Jason", 0, 0);
    popMatrix();
  }

  void update() {
    val+= 0.03;
    if (val > TWO_PI)
      val-= TWO_PI;
  }

  boolean mouseOn() {
    return (mouseX - leftPadding)/sF > pos.x - 350 && (mouseX - leftPadding)/sF < pos.x + 350 && mouseY/sF > pos.y - 66 && mouseY/sF < pos.y + 66;
  }

  void onPressed() {
    if (mouseOn()) launchPage("https:treidex.itch.io/holloweenie");
  }
}
