class DoubleView extends PowerUp {
    int frames;

    DoubleView(GameScene game) {
      this.game = game;
      wid = 25;
      hei = 25;
      animateRange = 80;
      speed = 5;
      image = loadImage("assets/view.png");
      pos = spawn(game.barriers);
      frames = 120;
      sound = loadSound("view.wav");
    }

    void onPickUp() {
      if (!sound.isPlaying()) sound.start();
      ((Game) game).framesView = frames;
      extraValue = 0;
      framesIn = 0;
      pos = spawn(game.barriers);
    }
  }
