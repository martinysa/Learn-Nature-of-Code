class Mover{

  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  
  Mover(){
    location = new PVector(random(width), height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = random(0.5,4);
  }
  
  //Newton's 2nd Law with mass!!
  void applyForce(PVector force){
    //  A = F/M
    PVector f = PVector.div(force,mass);
   
  
    acceleration.add(f);
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
