class Enemy extends Entity {
    PVector target;
    float damage, speed, vision;
    int damDelay, frFromLast = 0, size, framesOff = 60, totalFramesOff, framesSiceTarget = 0;
    boolean dieOnDam, facingRight;
    PImage imageLeft;
    GameScene game;
    String attackSound;

    {
      glowCol = color(255, 0, 0);
    }

    void show() {
      if (facingRight)
        image(image, pos.x, pos.y, wid, hei);
      else
        image(imageLeft, pos.x, pos.y, wid, hei);
    }

    void update() {
      if (framesOff > 0)
        framesOff--;
      else {
        if (distE(this, game.p) < vision)
          move();
        else
          defMove();

        pos.x = constrain(pos.x, 0, width - wid);
        pos.y = constrain(pos.y, 0, height - hei - 50);

        if (distE(this, game.p) < size) collided();

        if (frFromLast < damDelay)
          frFromLast++;
      }
    }

    void collided() {
      if (dieOnDam)
        game.entities.remove(this);
      else if (frFromLast == damDelay) {
        start(clips.get(attackSound));
        playSound();
        game.p.takeDamage(damage);
        frFromLast = 0;
      }
    }

    void hit(int rad) {
      framesOff = (int) map(rad, 0, 300, totalFramesOff, totalFramesOff/2);
    }

    void defMove() {
    }

    void move() {
    }
  }
