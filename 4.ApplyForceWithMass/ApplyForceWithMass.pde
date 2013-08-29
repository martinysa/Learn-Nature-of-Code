Mover[] movers = new Mover[5];

void setup() {
  size(600,400);
  for(int i = 0; i < movers.length; i++){
    movers[i] = new Mover(); 
  }
}

void draw() {
  background(255);
  
  for(int i = 0; i < movers.length; i++){
    PVector gravity = new PVector(0,0.3);
    // mass doesn´t affect gravity force
    // then add mas to acceleration
    gravity.mult(movers[i].mass);
    //then apply the force of gravity
    //now, inside applyforce will divide force by acceleration
    movers[i].applyForce(gravity);
    //result: gravity equal for anything object (independently its mass)
    
    
    if (mousePressed){
       PVector wind = new PVector(0.2,0);
      movers[i].applyForce(wind); 
    }
    movers[i].update();
    movers[i].checkEdges();
    movers[i].display(); 
  }
}
