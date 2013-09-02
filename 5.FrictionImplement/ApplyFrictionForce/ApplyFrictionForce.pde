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
    
    
    
    //Wind force
    PVector wind = new PVector(0.2,0);
   // movers[i].applyForce(wind); 
 
 
   // --- Friction force --- 
   //FORCE(friction) = -1 * u * || N || * vêl
   // -1: opossite direcction to velocity
   // u: coef Friction
   // || N || : Magnitude of Normal vector from Force (=1 in our sketch)
   // vêl : Velocity vector Normalized!
   
   
   PVector friction = movers[i].velocity.get();
   friction.normalize();
   friction.mult(-1);
   
   float c=0.31;
   friction.mult(c);
   movers[i].applyForce(friction);
 
    movers[i].update();
    movers[i].checkEdges();
    movers[i].display(); 
  }
}
