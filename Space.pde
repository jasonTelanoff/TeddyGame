String[] graves = {
  "JT",
  "TT",
  "AC",
  "EJ",
  "JG",
  "EV",
  "BS",
  "OR",
  "",
};

class Space {
  int x, y;
  boolean collision;
  PImage image;

  Space(int x, int y, boolean c) {
    this.x = x;
    this.y = y;
    collision = c;
    image = loadImage("assets/" + (random(1) < 0.5?"pumpkin":"grave" + graveSprite()) + ".png");
  }
  
  String graveSprite() {
    return(graves[(int) random(graves.length)]);
  } 

  void show() {
    if (collision) {
      image(image, x, y, 50, 50);
    }
  }
}
