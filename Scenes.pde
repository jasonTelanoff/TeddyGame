interface Scene {
  void show();
  void update();
  void onPressed();
  void onRelease();
  void onDragged();
}

abstract class GameScene implements Scene {
  ArrayList<Entity> entities = new ArrayList<Entity>();
  ArrayList<Barrier> barriers = new ArrayList<Barrier>();
  Player p;
  
  void pAttack() {}
}
