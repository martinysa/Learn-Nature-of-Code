class Vehicle {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float renderColor;

  float wanderAlpha;
  float wanderRadius;
  PVector wanderOffset;
  PVector circleWanderPosition;

  Vehicle(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,-2);
    location = new PVector(x,y);
    r = 6;
    maxspeed = random(.5,1);
    maxforce = 0.1;
    renderColor = 127;
    
    wanderAlpha = 0;
    wanderRadius = 40;
    circleWanderPosition = new PVector(0,0);
    wanderOffset = new PVector(0,0);
  }

  // Method to update location
  void update() {
    
    //seek(futureLocation);
    
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
    
    
    //float d = desired.mag();
    //if (d < 100){
    //   float m = (d * maxspeed)*0.01;
    //   desired.normalize();
    //   desired.mult(m);
    //}else{
    //   desired.normalize();
    //   desired.mult(maxspeed);
    //}
    
   


    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    
    applyForce(steer);
  }
    
    
  void wander(){
    float wanderDist = 64;
    float pickvalue =  random(1);
    float change = pickvalue * .2;
    float clock = random(2);

    
    if(clock > 1.1){
      //add negative
      wanderAlpha -= change;
    }else{
      wanderAlpha += change;
    }
    
    
    PVector circleLocation = velocity.get();
    circleLocation.normalize();
    circleLocation.mult(wanderDist);
    circleLocation.add(location);
    circleWanderPosition = circleLocation.get();
    
    PVector offset = new PVector(wanderRadius * sin(wanderAlpha), wanderRadius * cos(wanderAlpha));
    wanderOffset = offset.get();
    wanderOffset.add(circleLocation);
    
    PVector target = wanderOffset.get();
    seek(target);
    
    
    
  }
  
    
  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + PI/2;
    fill(renderColor);
    stroke(0);
    strokeWeight(1);
  
  
    //Wander stuff
    if(mousePressed){
      fill(0,0);
      line(location.x,location.y,circleWanderPosition.x,circleWanderPosition.y);
      ellipse(circleWanderPosition.x,circleWanderPosition.y,wanderRadius*2,wanderRadius*2);    
      //Draw radius
      stroke(255,0,0,200);
      line(circleWanderPosition.x,circleWanderPosition.y,wanderOffset.x,wanderOffset.y);  
      ellipse(wanderOffset.x,wanderOffset.y,wanderRadius/4,wanderRadius/4);    
    }
          
    //Vehicle
    pushMatrix();
    translate(location.x,location.y);
    stroke(0);
    fill(renderColor);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
    
  }


  void checkEdges(){
     if(location.x > width)
      location.x = 0;
     
     if(location.x < 0)
      location.x = width;
      
     if(location.y > height)
      location.y = 0;
      
     if(location.y < 0)
      location.y = height;
     
     
      
  }

}


