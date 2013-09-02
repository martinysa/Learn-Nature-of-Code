// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  //----- Angular motion vars
  float angle;
  float aVelocity;
  float aAcceleration;
  

  Mover(float m, float x, float y, float z) {
    mass = m;
    location = new PVector(x,y,z);
    velocity = new PVector(1,0);
    acceleration = new PVector(0,0);
    
    angle = 0.0;
    aVelocity = 0.0;
    aAcceleration = 0.0;
  
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    
    angle += aVelocity;
    aVelocity += aAcceleration;
    
  }

  void display() {
    noStroke();
    fill(30,200,200);
    pushMatrix();
    translate(location.x,location.y,location.z);
    //sphere(mass*8);
    rotate(angle);
    box(mass*8);
    popMatrix();
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = 0;
    } 
    else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }
  }
}


