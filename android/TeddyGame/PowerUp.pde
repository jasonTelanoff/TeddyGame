class PowerUp extends Entity {
    PVector vel = new PVector(0, 0);
    int pickUpRange = 20, animateRange, framesIn;
    float extraHeight, extraValue = 0, speed;
    boolean animating;
    SoundFile sound;

    {
      glowCol = color(255, 255, 0);
    }

    void show() {
      pushMatrix();
      translate(0, (-extraHeight - 3) * sF);
      image(image, pos.x * sF, pos.y * sF, wid * sF, hei * sF);
      popMatrix();
    }

    void update() {
      if (animating && distE(this, game.p) < pickUpRange) {
        animating = false;
        onPickUp();
      } else if (distE(this, game.p) < animateRange) {
        animating = true;
        animate();
      }

      framesIn++;
      if (framesIn == 1200) {
        extraValue = 0;
        framesIn = 0;
        pos = spawn(game.barriers);
      } else if (framesIn > 900)
        extraValue+= 0.06*map(framesIn, 900, 1200, 1, 5);
      else
        extraValue+= 0.06;
      extraHeight = 5 * sin(extraValue);
    }

    void onPickUp() {
    }

    void animate() {
      PVector acc = PVector.sub(PVector.add(game.p.pos, new PVector(game.p.wid/2, game.p.hei/2)), 
        PVector.add(pos, new PVector(wid/2, hei/2))).setMag(5);

      vel.add(acc);
      vel.setMag(constrain(vel.mag(), 0, speed));
      pos.add(vel);
    }
  }
