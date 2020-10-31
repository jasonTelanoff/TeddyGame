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

class Barrier {
  int x, y;
  PImage image;

  Barrier(int x, int y) {
    this.x = x;
    this.y = y;
    image = loadImage("assets/" + (random(1) < 0.5?"pumpkin":"grave" + graveSprite()) + ".png");
  }

  String graveSprite() {
    return(graves[(int) random(graves.length)]);
  } 

  void show() {
    image(image, x * sF, y * sF, 50 * sF, 50 * sF);
  }
}
