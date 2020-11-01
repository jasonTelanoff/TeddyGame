class Ghost extends Enemy {
    PVector vel, TEDDYISDUMB;
    float oVal;

    Ghost(GameScene game) {
      this.game = game;
      vel = new PVector(0, 0);
      TEDDYISDUMB = new PVector(0, 0);
      pos = new PVector(random(width), random(height));
      damage = 6.3;
      damDelay = 60;
      wid = 35;
      hei = 35;
      dieOnDam = false;
      size = 20;
      speed = 1.3;
      vision = 200;
      totalFramesOff = 250;
      oVal = random(TWO_PI);
      image = loadImage("assets/ghostRight.png");
      imageLeft = loadImage("assets/ghostLeft.png");
      attackSound = "ghost_attack";
    }

    void show() {
      if (framesOff > 0) tint(255, 255);
      else tint(255, 100*sin(oVal) + 80);

      if (facingRight)
        image(image, pos.x, pos.y, wid, hei);
      else
        image(imageLeft, pos.x, pos.y, wid, hei);

      noTint();

      oVal+= 0.01;
      if (oVal > TWO_PI)
        oVal-= TWO_PI;
    }

    void defMove() {
      if (target == null || framesSiceTarget == 0 || dist(pos.x, pos.y, target.x, target.y) < 100) {
        framesSiceTarget = 180;
        target = new PVector(random(width), random(height));
      } else framesSiceTarget--;
      PVector acc = PVector.sub(target, PVector.add(pos, new PVector(wid/2, hei/2))).setMag(5);
      TEDDYISDUMB.add(PVector.random2D());
      TEDDYISDUMB.setMag(speed);
      acc.add(TEDDYISDUMB);

      vel.add(acc);
      vel.setMag(constrain(vel.mag(), 0, speed));
      pos.add(vel);

      facingRight = vel.x > 0;
    }

    void move() {
      target = null;
      PVector acc = PVector.sub(PVector.add(game.p.pos, new PVector(game.p.wid/2, game.p.hei/2)), 
        PVector.add(pos, new PVector(wid/2, hei/2))).setMag(5);
      TEDDYISDUMB.add(PVector.random2D());
      TEDDYISDUMB.setMag(speed);
      acc.add(TEDDYISDUMB);

      vel.add(acc);
      vel.setMag(constrain(vel.mag(), 0, speed));
      pos.add(vel);

      facingRight = vel.x > 0;
    }
  }
