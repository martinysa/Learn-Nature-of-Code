Mover mover;

void setup() {
  size(600,400);
  mover = new Mover(); 
}

void draw() {
  
  
  PVector gravity = new PVector(0,0.3);
  mover.applyForce(gravity);
  
  if (mousePressed){
     PVector wind = new PVector(0.2,0);
    mover.applyForce(wind); 
  }
  
  background(255);
  mover.update();
  mover.checkEdges();
  mover.display(); 
}
