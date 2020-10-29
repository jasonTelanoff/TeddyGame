class Information extends Scene {
  PImage background;
  boolean credits, shown, animating, yt;
  float ang;
  int clicks, frames;
  String name1 = "Teddy Telanoff", name2 = "Jason Telanoff", yt1 = "Treidex Semextetry", yt2 = "BlahFromAbove";

  {
    background = loadImage("assets/startBackground.png");
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
    else {
      text("Creditst:\nThe original idea : " + (yt?yt1:name1) + "\nProject Manager : " + (yt?yt2:name2) + "\nLead developer :               \nArtwork : " + (yt?yt2:name2), 450, 275);
      pushMatrix();
      translate((yt?620:610), 320);
      if (animating)
        rotate(ang);
      text((yt?yt2:name2), 0, 0);
      popMatrix();
    }
  }

  void update() {
    if (animating)
      if (frames > 0) {
        frames--;
        ang+= 0.105;
      } else {
        clicks = 0;
        animating = false;
      }
    if (shown)
      scene = new Start(10, 6, 3, 3, 3, 2, 2);
  }

  void onPressed() {
    if (credits) {
      if (!yt && mouseX > 500 && mouseX < 720 && mouseY > 300 && mouseY < 350) {
        if (animating) {
          if (clicks < 3)
            clicks++;
          else
            yt = true;
        } else {
          frames = 60;
          animating = true;
        }
      } else if (sp && !shown) {
        textAlign(RIGHT, BOTTOM);
        textSize(12);
        text("heh, nerd", 900, 550);
        shown = true;
      } else
        scene = new Start(10, 6, 3, 3, 3, 2, 2);
    } else credits = true;
  }
}
