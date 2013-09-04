

Pendulum p;

void setup() {
  size(600,400);
  // Make a new Pendulum with an origin location and armlength
  p = new Pendulum(new PVector(width/2,0),175);

}

void draw() {

  background(255);
  p.start();
}

void mousePressed() {
  p.clicked(mouseX,mouseY);
}

void mouseReleased() {
  p.stopDragging();
}
