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

PVector playerMovement(PVector vel, float speed, Entity e, Space[][] spaces) {
  PVector pos = e.pos;
  vel.setMag(constrain(vel.mag(), 0, speed));

  pos.x+= vel.x;

  for (Space[] sArr : spaces)
    for (Space s : sArr)
      if (s.collision)
        if (pos.y + e.hei > s.y && pos.y < s.y + 50) 
          if (pos.x + e.wid > s.x && pos.x + e.wid < s.x + 50)
            pos.x = s.x - e.wid;
          else if (pos.x < s.x + 50 && pos.x + e.wid > s.x + 50) 
            pos.x = s.x + 50;

  pos.y+= vel.y;

  for (Space[] sArr : spaces)
    for (Space s : sArr)
      if (s.collision)
        if (pos.x + e.wid > s.x && pos.x < s.x + 50) 
          if (pos.y + e.hei > s.y && pos.y + e.hei < s.y + 50) 
            pos.y = s.y - e.hei;
          else if (pos.y < s.y + 50 && pos.y + e.hei > s.y + 50) 
            pos.y = s.y + 50;

  pos.x = constrain(pos.x, 0, width - e.wid);
  pos.y = constrain(pos.y, 0, height - e.hei - 50);

  return pos;
}

float distE(Entity a, Entity b) {
  return dist(a.pos.x + a.wid/2, a.pos.y + a.hei/2, b.pos.x + b.wid/2, b.pos.y + b.hei/2);
}
