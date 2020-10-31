class Glowstone extends PowerUp {
    int frames;

    Glowstone(GameScene game) {
      this.game = game;
      wid = 25;
      hei = 25;
      animateRange = 70;
      speed = 10;
      image = loadImage("assets/glowstone.png");
      pos = spawn(game.barriers);
      frames = 120;
      sound = new SoundFile(TeddyGame.this, "glow.wav");
    }

    void onPickUp() {
      if (!sound.isPlaying()) sound.play();
      ((Game) game).glowing = frames;
      extraValue = 0;
      framesIn = 0;
      pos = spawn(game.barriers);
    }
  }
