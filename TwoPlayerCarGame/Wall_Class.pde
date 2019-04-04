class Wall {

  PVector pos = new PVector();
  int health = 5;
  boolean dead = false;

  Wall(float x, float y) {

    pos.set(x, y);
  }


  void drawWall() {
    noStroke();
    rect(pos.x, pos.y, 30, 30);
  }

}
