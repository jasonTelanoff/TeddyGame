class Player extends Entity {
  int attackRad, framesToHeal, totalHeal;
  float health, power, speed, normSpeed = 3.5, boostSpeed = 5;
  boolean attacking, facingRight, speedBoost;
  PImage imageLeft;
  String walk;
  
  boolean godMode;

  Player(GameScene game, int x, int y) {
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
    walk = "walk1.wav";
    
    godMode = debug && true;
  }

  void show() {
    if (facingRight)
      image(image, pos.x, pos.y, wid, hei);
    else image(imageLeft, pos.x, pos.y, wid, hei);

    if (attacking) {
      stroke(90, 170, 255, 100);
      noFill();
      strokeWeight(10);
      circle(pos.x + wid/2, pos.y + hei/2, attackRad);
    }
  }

  void update() {
    speed = speedBoost ? boostSpeed : normSpeed;
    
    if (godMode) {
      health = 100;
      power = 200;
    }

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

    PVector vel = new PVector(0, 0);
    if (w) vel.y-= speed;
    if (a) {
      vel.x-= speed;
      facingRight = false;
    }
    if (s) vel.y+= speed;
    if (d) {
      vel.x+= speed;
      facingRight = true;
    }
    if (sp && power == 100) attack();

    if (vel.mag() > 0)
      if (random(1) < 0.07) {
        playSound(walk);
        playSound();
      }
    pos = playerMovement(pos, vel, speed, wid, hei, game.barriers);
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
