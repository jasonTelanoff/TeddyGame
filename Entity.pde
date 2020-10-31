class Entity {
  PVector pos;
  int wid, hei;
  color glowCol;
  PImage image;
  Game game;

  void update() {
  }
  void show() {
  }
  void showGlow() {
    noFill();
    stroke(glowCol);
    strokeWeight(1);
    rect(pos.x, pos.y + 50, wid, hei);
  }
}

PVector playerMovement(PVector pos, PVector vel, float speed, int wid, int hei, ArrayList<Barrier> barriers) {
  vel.setMag(constrain(vel.mag(), 0, speed));

  pos.x+= vel.x;

  for (Barrier b : barriers)
        if (pos.y + hei > b.y && pos.y < b.y + 50) 
          if (pos.x + wid > b.x && pos.x + wid < b.x + 50)
            pos.x = b.x - wid;
          else if (pos.x < b.x + 50 && pos.x + wid > b.x + 50) 
            pos.x = b.x + 50;

  pos.y+= vel.y;

  for (Barrier b : barriers)
        if (pos.x + wid > b.x && pos.x < b.x + 50) 
          if (pos.y + hei > b.y && pos.y + hei < b.y + 50) 
            pos.y = b.y - hei;
          else if (pos.y < b.y + 50 && pos.y + hei > b.y + 50) 
            pos.y = b.y + 50;

  pos.x = constrain(pos.x, 0, width - wid);
  pos.y = constrain(pos.y, 0, height - hei - 50);

  return pos;
}

float distE(Entity a, Entity b) {
  return dist(a.pos.x + a.wid/2, a.pos.y + a.hei/2, b.pos.x + b.wid/2, b.pos.y + b.hei/2);
}
