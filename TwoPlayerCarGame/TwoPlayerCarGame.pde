import processing.sound.*;


ArrayList<String> keyList = new ArrayList<String>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Wall> wallsList = new ArrayList<Wall>();
ArrayList<Powerup> activePowerups = new ArrayList<Powerup>();


SoundFile bulletImpact, bulletImpactTwo, death, gunshot;
PImage wall, tank, speed, ricochet;

Car carOne;
Car carTwo;


void setup() {


  activePowerups.add(new Powerup());


  textSize(40);
  size(900, 900);
  bulletImpact = new SoundFile(this, "bulletimpact.wav");
  bulletImpactTwo = new SoundFile(this, "bulletimpact2.wav");
  death = new SoundFile(this, "death.wav");
  gunshot = new SoundFile(this, "gunshot.wav");

  wall = loadImage("wall.png");
  tank = loadImage("tank.png");
  speed = loadImage("speed.png");
  ricochet = loadImage("ricochet.png");

  gunshot.amp(0.3);
  bulletImpact.amp(0.5);
  bulletImpactTwo.amp(1);
  carOne = new Car(10, 10, 0);
  carTwo = new Car(width - 40, height - 40, -PI);

  frameRate(60);

  for (int i = 0; i < 50; i++) {
    wallsList.add(new Wall(30 * int(random(2, 28)), 30 * int(random(2, 28))));
  }

  for (int i = 0; i < 12; i++) {

    keyList.add("false");
  }
}


void carOneUpdatePos() {

  if (keyList.get(0) == "true") {
    carOne.pos.x -= carOne.movementSpeed;
  } else if (keyList.get(2) == "true") {
    carOne.pos.x += carOne.movementSpeed;
  } else if (keyList.get(1) == "true") {
    carOne.pos.y += carOne.movementSpeed;
  } else if (keyList.get(3) == "true") {
    carOne.pos.y -= carOne.movementSpeed;
  } 

  if (keyList.get(8) == "true") 
    carOne.angle -= 0.05;
  else if (keyList.get(9) == "true")
    carOne.angle += 0.05;
}


void carTwoUpdatePos() {

  if (keyList.get(4) == "true") {
    carTwo.pos.x -= carTwo.movementSpeed;
  } else if (keyList.get(5) == "true") {
    carTwo.pos.y += carTwo.movementSpeed;
  } else if (keyList.get(6) == "true") {
    carTwo.pos.x += carTwo.movementSpeed;
  } else if (keyList.get(7) == "true") {
    carTwo.pos.y -= carTwo.movementSpeed;
  }

  if (keyList.get(10) == "true") 
    carTwo.angle -= 0.05;
  else if (keyList.get(11) == "true")
    carTwo.angle += 0.05;
}


void checkCollisions() {

  // Check bullet collisions
  for (int i = 0; i < bullets.size(); i++) {

    if (bullets.get(i).airTime > 12) {

      if (abs(carOne.pos.x - bullets.get(i).pos.x) < 20 && abs(carOne.pos.y - bullets.get(i).pos.y) < 20) {
        bullets.get(i).dead = true;
        carOne.health -= 1;
      }
      if (abs(carTwo.pos.x - bullets.get(i).pos.x) < 20 && abs(carTwo.pos.y - bullets.get(i).pos.y) < 20) {
        bullets.get(i).dead = true;
        carTwo.health -=1;
      }
      for (int j = 0; j < wallsList.size(); j++) {

        if ((wallsList.get(j).pos.x - bullets.get(i).pos.x > -15) && (wallsList.get(j).pos.x - bullets.get(i).pos.x < 15)) {
          if (wallsList.get(j).pos.y - bullets.get(i).pos.y > -15 && wallsList.get(j).pos.y - bullets.get(i).pos.y < 15) {
            wallsList.get(j).health -= 1;
            bullets.get(i).dead = true;

            if (wallsList.get(j).health < 1)
              wallsList.get(j).dead = true;
          }
        }
      }
    }
  }

  // Check car border collisions
  if (carOne.pos.x < 10)
    carOne.pos.x = 10;
  if (carOne.pos.x > width - 40)
    carOne.pos.x = width - 40;
  if (carOne.pos.y < 10)
    carOne.pos.y = 10;
  if (carOne.pos.y > height - 40)
    carOne.pos.y = height - 40;

  if (carTwo.pos.x < 10)
    carTwo.pos.x = 10;
  if (carTwo.pos.x > width - 40)
    carTwo.pos.x = width - 40;
  if (carTwo.pos.y < 10)
    carTwo.pos.y = 10;
  if (carTwo.pos.y > height - 40)
    carTwo.pos.y = height - 40;


  // Check car-wall collisions
  for (int i = 0; i < wallsList.size(); i++) {
    if (carOne.pos.x - wallsList.get(i).pos.x - 30 < 0 && carOne.pos.y - wallsList.get(i).pos.y - 30 < 0 && carOne.pos.y + 30 - wallsList.get(i).pos.y > 0 && carOne.pos.x - wallsList.get(i).pos.x - 30 > -10)
      carOne.pos.x = wallsList.get(i).pos.x + 30;
    if (-(carOne.pos.x + 30) + wallsList.get(i).pos.x < 0 && carOne.pos.y - wallsList.get(i).pos.y - 30 < 0 && carOne.pos.y + 30 - wallsList.get(i).pos.y > 0 && -(carOne.pos.x + 30) + wallsList.get(i).pos.x > -10)
      carOne.pos.x = wallsList.get(i).pos.x - 30;

    if (carOne.pos.y - wallsList.get(i).pos.y - 30 < 0 && carOne.pos.x - wallsList.get(i).pos.x - 30 < 0 && carOne.pos.x + 30 - wallsList.get(i).pos.x > 0 && carOne.pos.y - wallsList.get(i).pos.y - 30 > -10)
      carOne.pos.y = wallsList.get(i).pos.y + 30;
    if (-(carOne.pos.y + 30) + wallsList.get(i).pos.y < 0 && carOne.pos.x - wallsList.get(i).pos.x - 30 < 0 && carOne.pos.x + 30 - wallsList.get(i).pos.x > 0 && -(carOne.pos.y + 30) + wallsList.get(i).pos.y > -10)
      carOne.pos.y = wallsList.get(i).pos.y - 30;

    if (carTwo.pos.x - wallsList.get(i).pos.x - 30 < 0 && carTwo.pos.y - wallsList.get(i).pos.y - 30 < 0 && carTwo.pos.y + 30 - wallsList.get(i).pos.y > 0 && carTwo.pos.x - wallsList.get(i).pos.x - 30 > -10)
      carTwo.pos.x = wallsList.get(i).pos.x + 30;
    if (-(carTwo.pos.x + 30) + wallsList.get(i).pos.x < 0 && carTwo.pos.y - wallsList.get(i).pos.y - 30 < 0 && carTwo.pos.y + 30 - wallsList.get(i).pos.y > 0 && -(carTwo.pos.x + 30) + wallsList.get(i).pos.x > -10)
      carTwo.pos.x = wallsList.get(i).pos.x - 30;

    if (carTwo.pos.y - wallsList.get(i).pos.y - 30 < 0 && carTwo.pos.x - wallsList.get(i).pos.x - 30 < 0 && carTwo.pos.x + 30 - wallsList.get(i).pos.x > 0 && carTwo.pos.y - wallsList.get(i).pos.y - 30 > -10)
      carTwo.pos.y = wallsList.get(i).pos.y + 30;
    if (-(carTwo.pos.y + 30) + wallsList.get(i).pos.y < 0 && carTwo.pos.x - wallsList.get(i).pos.x - 30 < 0 && carTwo.pos.x + 30 - wallsList.get(i).pos.x > 0 && -(carTwo.pos.y + 30) + wallsList.get(i).pos.y > -10)
      carTwo.pos.y = wallsList.get(i).pos.y - 30;
  }
}


void drawHealth() {

  stroke(255);
  strokeWeight(6);

  for (int i = 1; i <= carOne.health; i++) {

    rect(10 + i*10, 20, 1, 1);
  }

  for (int i = 1; i <= carTwo.health; i++) {

    rect(width - 10 - i*10, 20, 1, 1);
  }
}


void draw() {

  background(0);
  fill(200);
  noStroke();
  rect(0, 0, width, width);
  fill(0);
  rect(10, 10, width - 20, width - 20);
  carOne.update();
  carTwo.update();
  carOne.drawBarrel();
  carTwo.drawBarrel();
  carOneUpdatePos();
  carTwoUpdatePos();

  if (frameCount % 120 == 0) {

    wallsList.add(new Wall(30 * int(random(2, 28)), 30 * int(random(2, 28))));
  }

  if (frameCount % 1350 == 0) {

    activePowerups.add(new Powerup());
  }

  for (int i = 0; i < wallsList.size(); i++) {

    wallsList.get(i).drawWall();
    if (wallsList.get(i).dead)
      wallsList.remove(i);
  }

  for (int i = 0; i < activePowerups.size(); i++) {

    activePowerups.get(i).drawPowerup();
    if (!activePowerups.get(i).checkCollide(carOne.pos.x, carOne.pos.y)) {
      carOne.buff[activePowerups.get(i).buffType] = true;
    }
    if (!activePowerups.get(i).checkCollide(carTwo.pos.x, carTwo.pos.y)) {
      carTwo.buff[activePowerups.get(i).buffType] = true;
    }
    if (!activePowerups.get(i).active) {
      activePowerups.remove(i);
    }
  }

  checkCollisions();
  drawHealth();

  for (int i = 0; i < bullets.size(); i++) {

    bullets.get(i).updatePos();
    if (bullets.get(i).dead == true) {
      noStroke();
      fill(255, 30, 0, 200);
      circle(bullets.get(i).pos.x + 15, bullets.get(i).pos.y + 15, 30);
      bullets.remove(i);
      int randomNum = round(random(0, 1));
      if (randomNum == 0)
        if (!bulletImpact.isPlaying())
          bulletImpact.play();
        else {
          bulletImpact.stop();
          bulletImpact.play();
        } else if (randomNum == 1)
        if (!bulletImpactTwo.isPlaying())
          bulletImpactTwo.play();
        else {
          bulletImpactTwo.stop();
          bulletImpactTwo.play();
        }
      fill(255);
      stroke(255);
    }
  }

  if (carOne.health < 1) {
    textAlign(CENTER, BOTTOM);
    text("Player Two Wins", width/2, height/2);
    death.play();
    noLoop();
  } else if (carTwo.health < 1) {
    textAlign(CENTER, BOTTOM);
    text("Player One Wins", width/2, height/2);
    death.play();
    noLoop();
  }
}


void keyReleased() {

  if (key == 'a')
    keyList.set(0, "false");
  if (key == 's')
    keyList.set(1, "false");
  if (key == 'd')
    keyList.set(2, "false");
  if (key == 'w')
    keyList.set(3, "false");

  if (keyCode == LEFT)
    keyList.set(4, "false");
  if (keyCode == DOWN)
    keyList.set(5, "false");
  if (keyCode == RIGHT)
    keyList.set(6, "false");
  if (keyCode == UP)
    keyList.set(7, "false");

  if (key == 'f')
    keyList.set(8, "false");
  if (key == 'g')
    keyList.set(9, "false");

  if (key == '1')
    keyList.set(10, "false");
  if (key == '2')
    keyList.set(11, "false");
}


void keyPressed() {

  // Car One Movement
  if (key == 'a')
    keyList.set(0, "true");
  if (key == 's')
    keyList.set(1, "true");
  if (key == 'd')
    keyList.set(2, "true");
  if (key == 'w')
    keyList.set(3, "true");

  // Car Two Movement
  if (keyCode == LEFT)
    keyList.set(4, "true");
  if (keyCode == DOWN)
    keyList.set(5, "true");
  if (keyCode == RIGHT)
    keyList.set(6, "true");
  if (keyCode == UP)
    keyList.set(7, "true");

  // Car One barrel
  if (key == 'f')
    keyList.set(8, "true");
  if (key == 'g')
    keyList.set(9, "true");

  // Car Two barrel
  if (key == '1')
    keyList.set(10, "true");
  if (key == '2')
    keyList.set(11, "true");

  // Car One fire
  if (key == 'h') {
    if (carOne.buff[1])
      bullets.add(new Bullet(carOne.pos.x, carOne.pos.y, carOne.angle, true));
    else
      bullets.add(new Bullet(carOne.pos.x, carOne.pos.y, carOne.angle, false));
    if (!gunshot.isPlaying()) 
      gunshot.play();
    else {
      gunshot.stop();
      gunshot.play();
    }
  }

  // Car Two fire
  if (keyCode == ENTER) {
    if (carTwo.buff[1])
      bullets.add(new Bullet(carTwo.pos.x, carTwo.pos.y, carTwo.angle, true));
    else
      bullets.add(new Bullet(carTwo.pos.x, carTwo.pos.y, carTwo.angle, false));
    if (!gunshot.isPlaying()) 
      gunshot.play();
  }
}
