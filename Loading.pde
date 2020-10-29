class Loading extends Scene {
  PImage background;
  Title title;
  int dotCount;
  String loadingThing = "Loading your favorite game";

  {
    background = loadImage("assets/startBackground.png");
    title = new Title();
  }

  void show() {
    background(background);
    title.show();
    textAlign(CENTER, CENTER);
    textSize(40);

    loadingThing = "Loading your favorite game";
    for (int d = 0; d < dotCount / 50; d++)
      loadingThing += '.';
    text(loadingThing, 450, 250);

    dotCount++;
    dotCount %= 150;
  }
  void update() {
    title.update();
    
    if (backgroundSound != null) {
      frameRate(60);
      scene = new Start();
    }
  }
  void onPressed() {
    title.onPressed();
  }
}
