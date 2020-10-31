class Loading extends Scene {
  PImage background;
  Title title;
  int dotCount;
  String loadingThing;

  {
    background = loadImage("assets/startBackground.png");
    title = new Title();
    frameRate(0.75);
  }

  void show() {
    background(background);

    title.show();

    textAlign(CENTER, CENTER);
    textSize(40);
    fill(255);
    loadingThing = "Loading your favorite game";
    for (int d = -1; d < dotCount; d++)
      loadingThing += '.';

    text(loadingThing, 450, 250);
    
    textAlign(RIGHT, BOTTOM);
    textSize(15);
    text("- .. -. -.-- .-.-.- -.-. -.-. -..-. - . -.. --. .- --", 890, 540);
  }
  void update() {
    dotCount++;
    dotCount %= 3;

    if (backgroundSound != null && backgroundGameMusic != null && tutorialMusic != null) {
      frameRate(60);
      scene = new Start();
    }
  }
  void onPressed() {
    title.onPressed();
  }
}
