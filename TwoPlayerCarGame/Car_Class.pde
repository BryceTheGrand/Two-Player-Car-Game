class Car {

  PVector pos = new PVector();
  float barrelRadius = 20;
  float angle;
  float health = 20;
  boolean[] buff;
  int[] buffTimer;
  float movementSpeed = 2;

  Car(float x, float y, float angle) {

    pos.set(x, y); 
    this.angle = angle;
    buff = new boolean[3];
    for (int i = 0; i < buff.length; i++) { 
      buff[i] = false;
    }
    buffTimer = new int[3];
  }


  void update() {

    fill(255);
    noStroke();
    image(tank, pos.x, pos.y, 30, 30);
    if (buff[0]) {
      movementSpeed = 4;
      buffTimer[0] += 1;
      if (buffTimer[0] > 900) {
        buff[0] = false;
        buffTimer[0] = 0;
      }
    } else
      movementSpeed = 2;
    if (buff[1]) {
      buffTimer[1] += 1;
      if (buffTimer[1] > 900) {
        buff[1] = false;
        buffTimer[1] = 0;
      }
    }
  }


  void drawBarrel() {

    stroke(255);
    strokeWeight(4);
    line(pos.x + 15, pos.y + 15, pos.x + 15 + barrelRadius*cos(angle), pos.y + 15 + barrelRadius*sin(angle));
  }
}
