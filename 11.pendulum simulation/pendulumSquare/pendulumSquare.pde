

Pendulum p;
Pendulum p2;

void setup() {
  size(600,400);
  // Make a new Pendulum with an origin location and armlength
  p = new Pendulum(new PVector(width/2,0),175, false, null);
  p2 = new Pendulum(p.getPosBob(),175, true, p);
}

void draw() {

  background(255);
  p.start();
  p2.start();
  //p2.damping = p.aVel*.1;
}

void mousePressed() {
  p.clicked(mouseX,mouseY);
  p2.clicked(mouseX,mouseY);
}

void mouseReleased() {
  p.stopDragging();
  p2.stopDragging();
}
