class Car {

  PVector pos = new PVector();
  float barrelRadius = 30;
  float angle;
  float health = 20;

  Car(float x, float y, float angle) {

    pos.set(x, y); 
    this.angle = angle;
  }


  void update() {

    fill(255);
    noStroke();
    rect(pos.x, pos.y, 30, 30);
  }


  void drawBarrel() {

    stroke(255);
    strokeWeight(8);
    line(pos.x + 15, pos.y + 15, pos.x + 15 + barrelRadius*cos(angle), pos.y + 15 + barrelRadius*sin(angle));
  }
}
