class Heart extends PowerUp {
    Heart(GameScene game) {
      this.game = game;
      wid = 35;
      hei = 35;
      animateRange = 70;
      speed = 4;
      image = loadImage("assets/heart.png");
      pos = spawn(game.barriers);
      sound = loadSound("health.wav");
    }

    void onPickUp() {
      if (!sound.isPlaying()) sound.start();
      game.p.heal(9.5);
      extraValue = 0;
      framesIn = 0;
      pos = spawn(game.barriers);
    }
  }
