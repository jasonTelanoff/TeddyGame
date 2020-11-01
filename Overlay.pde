interface Overlay {
  void show();
  boolean update();
  boolean onPressed();
  boolean onRelease();
  boolean onDragged();
  void close();
}

void remove(Overlay o) {
  o.close();
  overlaysToDelete.add(o);
}
