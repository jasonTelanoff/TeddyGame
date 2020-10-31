class SpeedBoost extends PowerUp {
    float wid2, hei2, newSpeed = 5;
    int framesLeft;

    SpeedBoost(GameScene game) {
      this.game = game;
      wid = 30;
      hei = 30;
      pickUpRange = 100;
      animateRange = 100;
      speed = 12;
      image = loadImage("assets/speedBoost.png");
      framesLeft = 60;
      pos = spawn(game.barriers);
      wid2 = 30;
      hei2 = 30;
      sound = loadSound("speed.wav");
    }

    void onPickUp() {
      if (framesLeft > 0) {
        if (!sound.isPlaying()) sound.start();
        framesLeft--;
        wid2-= 0.2;
        hei2-= 0.2;
        wid = (int) wid2;
        hei = (int) hei2;
        game.p.speedBoost = true;
      } else {
        game.p.speedBoost = false;
        wid2 = 30;
        hei2 = 30;
        wid = (int) wid2;
        hei = (int) hei2;
        framesLeft = 60;
        extraValue = 0;
        framesIn = 0;
        pos = spawn(game.barriers);
      }
    }
  }
