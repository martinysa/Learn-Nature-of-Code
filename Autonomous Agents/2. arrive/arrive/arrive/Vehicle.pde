class Vehicle {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float renderColor;

  Vehicle(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,-2);
    location = new PVector(x,y);
    r = 6;
    maxspeed = random(3,4);
    maxforce = 0.1;
    renderColor = 127;
  }

  // Method to update location
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelerationelertion to 0 each cycle
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // A method that calculates a steering force towards a target
  // Steer = desired - velocity
  void seek(PVector target) {
    PVector desired = PVector.sub(target,location);  // A vector pointing from the location to the target
    float d = desired.mag();
    if (d < 100){
       float m = (d * maxspeed)*0.01;
       desired.normalize();
       desired.mult(m);
    }else{
       desired.normalize();
       desired.mult(maxspeed);
    }
    
   


    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    
    applyForce(steer);
  }
    
  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + PI/2;
    fill(renderColor);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
    
    
  }
}
