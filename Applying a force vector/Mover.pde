class Mover{

  PVector location;
  PVector velocity;
  PVector acceleration;
  
  Mover(){
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void applyForce(PVector force){
   //suppose mass=1  --> Force=Acceleration
   //F=M*A
   //F=1*A -- > F=A
   //Accumulate forces 
   // acceleration = 0 ; every frame
   //add force to acceleration.
    acceleration.add(force);
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
    ellipse(location.x, location.y, 48, 48);
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
