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
    imageMode(CORNER);
    popMatrix();
    
    pushMatrix();
    fill(255, 255, 0);
    textSize(sin(val * 2)*2 + 20);
    translate(pos.x + 330, pos.y + 60);
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
    return mouseX > pos.x - 350 && mouseX < pos.x + 350 && mouseY > pos.y - 66 && mouseY < pos.y + 66;
  }

  void onPressed() {
    if (mouseOn()) {
      if (System.getProperty("os.name").contains("Windows")) {
        try {
          Runtime.getRuntime().exec("C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe --app=https://treidex.itch.io/holloweenie");
        } 
        catch (IOException e64) {
          try {
            Runtime.getRuntime().exec("C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe --app=https://treidex.itch.io/holloweenie");
          } 
          catch (IOException e86) {
          }
        }
      } else if (System.getProperty("os.name").contains("Mac")) {
        try {
          Runtime.getRuntime().exec("~/Library/Application Support/Google/Chrome.app --app=https://treidex.itch.io/holloweenie");
        } 
        catch (IOException e) {
        }
      }
    }
  }
}
