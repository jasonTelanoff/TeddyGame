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
    background(0);
    image(background, 0, 0, 900 * sF, 550 * sF);

    title.show();

    textAlign(CENTER, CENTER);
    textSize(40);
    fill(255);
    loadingThing = "Loading your favorite game";
    for (int d = -1; d < dotCount; d++)
      loadingThing += '.';

    text(loadingThing, 450 * sF, 250 * sF);

    textAlign(RIGHT, BOTTOM);
    textSize(15);
    text("- .. -. -.-- .-.-.- -.-. -.-. -..-. - . -.. --. .- --", 890 * sF, 540 * sF);
  }
  void update() {
    dotCount++;
    dotCount %= 3;
  }
  void onPressed() {
    title.onPressed();
  }
}
