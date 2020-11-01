class Point extends PowerUp {
  int frames;

  Point(GameScene game) {
    this.game = game;
    wid = 20;
    hei = 20;
    animateRange = 64;
    speed = 8;
    image = loadImage("assets/point.png");
    frames = 120;
    pos = spawn(game.barriers);
    sound = "time";
  }

  void onPickUp() {
    ((Game) game).framesLeft+= frames;
    if (frames > 90)
      frames-= 6;
    extraValue = 0;
    framesIn = 0;
    pos = spawn(game.barriers);
    
    if (!clips.get(sound).isRunning())
        start(clips.get(sound));
  }
}
