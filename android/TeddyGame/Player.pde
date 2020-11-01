class Player extends Entity {
  Joystick joystick;
  int attackRad, framesToHeal, totalHeal;
  float health, power, speed, normSpeed = 3.5, boostSpeed = 5;
  boolean attacking, facingRight, speedBoost;
  PImage imageLeft;
  SoundFile walk;

  Player(GameScene game, int x, int y) {
    joystick = new Joystick(height/4 + 20, 7*height/8 - 20, height/4);
    pos = new PVector(x, y);
    wid = 40;
    hei = 40;
    health = 100;
    power = 50;
    speed = 5;
    totalHeal = 60;
    image = loadImage("assets/playerRightHallow.png");
    imageLeft  = loadImage("assets/playerLeftHallow.png");
    this.game = game;
    walk = new SoundFile(TeddyGame.this, "walk1.wav");
  }

  void show() {
    if (facingRight)
      image(image, pos.x * sF, pos.y * sF, wid * sF, hei * sF);
    else image(imageLeft, pos.x * sF, pos.y * sF, wid * sF, hei * sF);

    if (attacking) {
      stroke(90, 170, 255, 100);
      noFill();
      strokeWeight(10 * sF);
      circle((pos.x + wid/2) * sF, (pos.y + hei/2) * sF, attackRad);
    }

    joystick.show();
  }

  void update() {
    speed = speedBoost?boostSpeed:normSpeed;
    joystick.update();

    if (attacking) {
      if (power > 0) {
        attackRad+= 22;
        power-= 4;
        game.pAttack();
      } else attacking = false;
    } else 
    power+=0.2;

    if (framesToHeal > 0)
      framesToHeal--;
    else {
      framesToHeal = totalHeal;
      health+= 1.5;
    }

    power = constrain(power, 0, 100);
    health = constrain(health, 0, 100);

    if (joystick.vel.mag() > 0) {
      if (!walk.isPlaying() && random(1) < 0.07)
        walk.play();
      facingRight = joystick.vel.x > 0;
    }
    pos = playerMovement(pos, joystick.vel.mult(speed), speed, wid, hei, game.barriers);
  }

  void attack() {
    attackRad = 0;
    attacking = true;
    framesToHeal = totalHeal;
  }

  void takeDamage(float damage) {
    health-= damage;
    framesToHeal = totalHeal;
  }

  void heal(float amount) {
    health+= amount;
    health = constrain(health, 0, 100);
  }
}
