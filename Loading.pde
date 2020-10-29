class Loading extends Scene {
  PImage background;
  Title title;
  
  {
    background = loadImage("assets/startBackground.png");
    title = new Title();
  }
  
  void show() {
    background(background);
    title.show();
    textAlign(CENTER, CENTER);
    textSize(40);
    text("Loading...", 450, 250);
  }
  void update() {
    scene = new Start();
  }
  void onPressed() {}
}
