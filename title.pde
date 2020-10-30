class Title {
  PVector pos;
  PImage image;
  float val;
  String text;

  {
    pos = new PVector(450, 120);
    image = loadImage("assets/title.png");
    
    text = random(100) < 1 ? "By Teddy" : "By Jason";
  }

  void show() {
    imageMode(CENTER);
    pushMatrix();
    translate(pos.x + sin(val)*10, pos.y + cos(val)*5);
    rotate(sin(val)/15);
    image(image, 0, 0, 700, 137);
    imageMode(CORNER);
    popMatrix();

    pushMatrix();
    fill(255, 255, 0);
    textSize(sin(val * 2)*2 + 20);
    translate(pos.x + 330, pos.y + 60);
    rotate(-0.3 + cos(val)/8);
    text(text, 0, 0);
    popMatrix();
  }

  void update() {
    val+= 0.03;
    if (val > TWO_PI)
      val-= TWO_PI;
  }

  boolean mouseOn() {
    return mouseX > pos.x - 350 && mouseX < pos.x + 350 && mouseY > pos.y - 66 && mouseY < pos.y + 66;
  }

  void onPressed() {
    if (mouseOn()) launchPage("https://treidex.itch.io/holloweenie");
  }
}
