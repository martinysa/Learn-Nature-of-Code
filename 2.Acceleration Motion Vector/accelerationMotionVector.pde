Mover mover;

void setup() {
  size(400,600);
  mover = new Mover(); 
}

void draw() {
  background(255);
  mover.update();
  mover.checkEdges();
  mover.display(); 
}
