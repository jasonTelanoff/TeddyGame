class Title {
    PVector pos;
    PImage image;
    float val;

    {
      pos = new PVector(450, 120);
      image = loadImage("assets/title.png");
    }

    void show() {
      imageMode(CENTER);
      pushMatrix();
      translate(pos.x + sin(val)*10, pos.y + cos(val)*5);
      rotate(sin(val)/15);
      image(image, 0, 0, 700, 137);
      popMatrix();
      imageMode(CORNER);
    }

    void update() {
      val+= 0.03;
      if(val > TWO_PI)
        val-= TWO_PI;
    }
  }
