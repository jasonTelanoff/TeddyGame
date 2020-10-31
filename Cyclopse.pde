class Cyclops extends Enemy {
  PVector vel;

  Cyclops(GameScene game) {
    this.game = game;
    vel = new PVector(0, 0);
    pos = new PVector(random(width), random(height));
    damage = 46;
    damDelay = 180;
    wid = 50;
    hei = 50;
    dieOnDam = false;
    size = 30;
    speed = 0.4;
    vision = 140;
    totalFramesOff = 120;
    image = loadImage("assets/cyclopsRight.png");
    imageLeft = loadImage("assets/cyclopsLeft.png");
    attackSound = "cyclops_attack.wav";
  }

  void defMove() {
    if (target == null || framesSiceTarget == 0 || dist(pos.x, pos.y, target.x, target.y) < 100) {
      framesSiceTarget = 180;
      target = new PVector(random(width), random(height));
    } else framesSiceTarget--;
    vel = PVector.sub(target, pos);
    vel.setMag(constrain(vel.mag(), 0, speed/3));
    pos = playerMovement(pos, vel, speed, wid, hei, game.barriers);

    facingRight = vel.x > 0;
  }

  void move() {
    target = null;
    vel = PVector.sub(game.p.pos, pos);
    vel.setMag(speed);
    pos = playerMovement(pos, vel, speed, wid, hei, game.barriers);

    facingRight = vel.x > 0;
  }
}
