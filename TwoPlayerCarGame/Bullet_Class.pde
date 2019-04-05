class Bullet {

  PVector pos = new PVector();
  float angle;
  PVector vel = new PVector(5, 5);
  boolean dead = false;
  int airTime = 0;
  boolean ricochet;
  int ricochetCount = 0;

  Bullet(float x, float y, float angle, boolean ricochet) {

    pos.set(x, y);
    this.angle = angle;
    this.ricochet = ricochet;
  }

  void updatePos() {
    pos.x += vel.x*cos(angle);
    pos.y += vel.y*sin(angle);
    circle(pos.x + 15, pos.y + 15, 3);
    airTime++;
    if (pos.x < 0 || pos.x > width - 30 || pos.y < 0 || pos.y > height - 30) {

      if (ricochet && ricochetCount < 2) {
        if (pos.x < 0 || pos.x > width - 30) {
          vel.x = -vel.x;
          ricochetCount++;
        } else if (pos.y < 0 || pos.y > height - 30) {
          vel.y = -vel.y;
          ricochetCount++;
        }
      } else

        dead = true;
    }
  }
}
