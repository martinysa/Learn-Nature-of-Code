class Mover{

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float G;
  
  Mover(){
    location = new PVector(random(20,200), 100);
    velocity = new PVector(1,0);
    acceleration = new PVector(0,0);
    mass = random(0.2,1.5);
    G = 1;
  }
  
  void applyForce(PVector force){
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  
  PVector attract (Mover m){
    // Direction of force
    PVector force = PVector.sub(location, m.location);
    float d = force.mag();
    d = constrain(d, 5.0,25.0);
    force.normalize(); 
    
    //Magnitude of that force
    float strength = (G * mass * m.mass) / (d * d);
    
    // Magnitud & direction together
    force.mult(strength);
    
    return force;
  }
  
  
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    //velocity.limit(5);
  }
  
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(location.x, location.y, mass*20, mass*20);
    text("m",location.x-(mass*20)*.5,location.y-13);
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = width;
      velocity.x *=-1;
    } 
    else if (location.x < 0) {
      location.x = 0; 
      velocity.x*=-1;
    }

    if (location.y > height) {
      location.y = height;
      velocity.y*=-1;
    } 
    
  }
  
}
