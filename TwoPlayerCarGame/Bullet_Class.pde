class Bullet {

  PVector pos = new PVector();
  float angle;
  float vel = 5;
  boolean dead = false;
  int airTime = 0;

  Bullet(float x, float y, float angle) {

    pos.set(x, y);
    this.angle = angle;
  }

  void updatePos() {
    pos.x += 5*cos(angle);
    pos.y += 5*sin(angle);
    circle(pos.x + 15, pos.y + 15, 3);
    airTime++;
    if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {

      dead = true;
    }
  }
}
