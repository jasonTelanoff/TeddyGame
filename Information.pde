class Information extends GameScene {
  PImage background;
  boolean credits, shown = false, animating, yt;
  ArrayList<Entity> entities = new ArrayList<Entity>();
  Button backButton;
  float ang;
  int clicks, frames, maxEntities = 30;
  String name1 = "Teddy Telanoff", name2 = "Jason Telanoff", name3 = "Benjamin Telanoff", yt1 = "Treidex Semextetry", yt2 = "BlahFromAbove", yt3 = "Benramen";

  {
    background = loadImage("assets/startBackground.png");
    backButton = new BackButton();
  }

  void show() {
    background(background);

    for (Entity e : entities)
      e.show();

    textAlign(CENTER, CENTER);
    fill(255);
    noStroke();
    textSize(30);
    if (!credits)
      text("This is a game. The goal of the game is to\nsurvive as long as possible. Ghosts will try to\ntake your soul, and Cyclops will bash your body.\n" + 
        "Only the bravest and strongest gamers will\nsurvive long enough to question what\nlife decisions led them to the point in their life\nwhere they're playing a game with no end\nfor minutes on end.", 450, 275);
    else {
      text("Credits:\nThe original idea : " + (yt?yt1:name1) + "\nProject Manager : " + (yt?yt2:name2) + "\nLead developer :               \nArtwork : " + (yt?yt2:name2) + "\nGame Tester : " + (yt?yt3:name3), 450, 275);
      pushMatrix();
      translate((yt?620:610), 300);
      if (animating)
        rotate(ang);
      text((yt?yt2:name2), 0, 0);
      popMatrix();
    }
    
    fill(255);
    textSize(20);
    textAlign(RIGHT, BOTTOM);
    text("Click anywhere to continue", 890, 540);

    backButton.show();
  }

  void update() {
    for (Entity e : entities)
      e.update();

    if (animating)
      if (frames > 0) {
        frames--;
        ang+= 0.105;
      } else {
        clicks = 0;
        animating = false;
      }
    if (shown)
      scene = new Start();
  }

  void onPressed() {
    if (backButton.mouseOn())
      backButton.onPressed();
    else if (credits) {
      if (!yt && mouseX > 500 && mouseX < 720 && mouseY > 275 && mouseY < 325) {
        if (animating) {
          if (clicks < 3)
            clicks++;
          else
            yt = true;
        } else {
          frames = 60;
          animating = true;
        }
      } else {
        if (keyPressed && !shown) {
          textAlign(RIGHT, BOTTOM);
          textSize(12);
          text("heh, nerd", 900, 550);
          shown = true;
        } else
          scene = new Start();
      }
    } else if (mouseX > 530 && mouseX < 640 && mouseY > 145 && mouseY < 185) {
      if (entities.size() < maxEntities)
        entities.add(new Ghost(this));
    } else if (mouseX > 385 && mouseX < 500 && mouseY > 190 && mouseY < 230) {
      if (entities.size() < maxEntities)
        entities.add(new Cyclops(this));
    } else credits = true;
  }
  
  void onRelease() {}
    
    void onDragged() {}

  class BackButton extends Button {
    {
      x = 45;
      y = 525;
      hei = 30;
      wid = 70;
      text = "Back";
      image = loadImage("assets/startButton.png");
      textCol = color(255);
    }

    void onPressed() {
      if (credits)
        credits = false;
      else
        scene = new Start();
    }
  }
}
