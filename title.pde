class Title {
  PVector pos;
  PImage image;
  float val;

  {
    pos = new PVector(450, 120);
    image = loadImage("assets/title.png");
  }

  void show() {
    imageMode(CENTER);
    pushMatrix();
    translate(pos.x + sin(val)*10, pos.y + cos(val)*5);
    rotate(sin(val)/15);
    image(image, 0, 0, 700, 137);
    popMatrix();
    imageMode(CORNER);
  }

  void update() {
    val+= 0.03;
    if (val > TWO_PI)
      val-= TWO_PI;
  }

  boolean mouseOn() {
    return mouseX > pos.x - image.pixelWidth/2 && mouseX < pos.x + image.pixelWidth/2 && mouseY > pos.y - image.pixelHeight/2 && mouseY < pos.y + image.pixelHeight/2;
  }

  void onPressed() {
    if (mouseOn()) {
      if (System.getProperty("os.name").startsWith("Windows")) {
        try {
          Runtime.getRuntime().exec("C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe --app=https://treidex.itch.io/holloweenie");
        } 
        catch (IOException e) {
        }
      } else if (System.getProperty("os.name").startsWith("Mac")) {
        try {
          Runtime.getRuntime().exec("~/Library/Application Support/Google/Chrome.app --app=https://treidex.itch.io/holloweenie");
        } 
        catch (IOException e) {
        }
      }
    }
  }
}
