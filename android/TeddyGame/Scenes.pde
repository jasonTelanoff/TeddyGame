abstract class Scene {
  abstract void show();
  abstract void update();
  abstract void onPressed();
  void onReleased() {}
}

class GameScene extends Scene {
  ArrayList<Entity> entities = new ArrayList<Entity>();
  ArrayList<Barrier> barriers = new ArrayList<Barrier>();
  Player p;
  
  void pAttack() {}
  
  void show() {}
  void update() {}
  void onPressed() {}
}
