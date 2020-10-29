class Information extends Scene {
  PImage background;
  boolean credits;

  {
    background = loadImage("assets/startBackground.png");
    credits = false;
  }

  void show() {
    background(background);

    textAlign(CENTER, CENTER);
    fill(255);
    noStroke();
    textSize(30);
    if (!credits)
      text("This is a game. The goal of the game is to\nsurvive as long as possible. Ghosts will try to\ntake your sole, and cyclops will bash your body.\n" + 
        "Only the bravest and strongest gamers will\nsurvive long enough to question what\nlife decisions led them to the point in their life\nwhere they're playing a game with no end\nfor minutes on end.", 450, 275);
    else text("Creditst:\nThe original idea : Teddy Telanoff\nProject Manager : Jason Telanoff\nLead developer : Jason Telanoff\nArtwork : Jason Telanoff", 450, 275);
  }

  void update() {
  }

  void onPressed() {
    if (credits)
      scene = new Start(10, 6, 3, 3, 3, 2, 2);
    else credits = true;
  }
}
