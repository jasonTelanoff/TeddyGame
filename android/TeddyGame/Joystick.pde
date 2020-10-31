class Joystick {
  PVector defPos, pos, dotPos, offset = new PVector(0, 0), vel = new PVector(0, 0);
  int size;

  Joystick(int x, int y, int size) {
    defPos = new PVector(x, y);
    pos = defPos.copy();
    dotPos = pos.copy();
    this.size = size;
  }

  void show() {
    pushMatrix();
    translate(-leftPadding, -size/2);
    ellipseMode(CENTER);
    
    fill(255, 100);
    stroke(50);
    ellipseMode(CENTER);
    circle(pos.x, pos.y, size);

    fill(0);
    circle(dotPos.x, dotPos.y, size/3);
    popMatrix();
  }

  void update() {
    if (mousePressed) {
      offset = PVector.sub(new PVector(mouseX, mouseY), pos);
      offset.setMag(constrain(offset.mag(), 0, size/3));
      dotPos = PVector.add(pos, offset);
      vel = offset.copy();
      vel.setMag(1);
    }
  }

  void reset() {
    pos = defPos.copy();
    offset = new PVector(0, 0);
    dotPos = pos.copy();
    vel = new PVector(0, 0);
  }
}
