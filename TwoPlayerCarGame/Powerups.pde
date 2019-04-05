class Powerup {

  PVector pos;
  boolean active = true;
  int buffType;

  Powerup() {

    pos = new PVector(30 * int(random(2, 28)), 30 * int(random(2, 28)));
    buffType = floor(random(0, 2) - 0.000000001);
  }

  void drawPowerup() {
    stroke(255);
    noFill();
    strokeWeight(2);
    circle(pos.x + 15, pos.y + 15, 20);
    if (buffType == 0)
      image(speed, pos.x + 10, pos.y + 10);
    if (buffType == 1)
      image(ricochet, pos.x + 10, pos.y + 10);
  }

  boolean checkCollide(float x, float y) {

    if (abs(x - pos.x) < 20 && abs(y - pos.y) < 20) {
      active = false;
    }

    return active;
  }
}
