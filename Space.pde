class Space {
  int x, y;
  boolean collision;
  PImage image;

  Space(int x, int y, boolean c) {
    this.x = x;
    this.y = y;
    collision = c;
    image = loadImage("assets/wall.png");
  }

  void show() {
    if (collision) {
      image(image, x, y, 50, 50);
    }
  }
}
