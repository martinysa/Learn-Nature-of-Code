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
    r = 3;
    maxspeed = random(1,2);
    maxforce = 0.1;
    renderColor = 127;
    
    wanderAlpha = 0;
    wanderRadius = 25;
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

    
    if(clock > 1){
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
  
   void follow(FlowField flow) {
    PVector desired = flow.lookup(location);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  
  void followAPath(Path p){
    //Predict future location in 50 advance
    PVector predict = velocity.get();
    predict.normalize();
    predict.mult(50);
    PVector predictLoc = PVector.add(location, predict);
    
    
    //Get line segment  a - b
    PVector a = path.start;
    PVector b = path.end;
    
    //get normal point
    PVector normalPoint = getNormalPoint(predictLoc, a, b);
    
    //Find target 10 ahead over the normal point
    
    PVector dir = PVector.sub(b,a);
    dir.normalize();
    dir.mult(10);
    PVector target = PVector.add(normalPoint, dir);
    
    // Is predict location close to normal point?
    float distance = PVector.dist(predictLoc, normalPoint);
    
    //We're steer the vehicle only if distance is greater than the path radius
    if(distance > p.radius){
      seek(target);  
    }
    
    //show debug draws
    if (debug){
      fill(0);
      stroke(200);
      line(location.x, location.y, predictLoc.x, predictLoc.y);
      ellipse(predictLoc.x, predictLoc.y, 4, 4); 
      
      
      // Draw normal location
      fill(0);
      stroke(150,150,0);
      line(predictLoc.x, predictLoc.y, normalPoint.x, normalPoint.y);
      ellipse(normalPoint.x, normalPoint.y, 4, 4);
      stroke(0);
      if (distance > p.radius) fill(255, 0, 0);
      noStroke();
      ellipse(target.x+dir.x, target.y+dir.y, 8, 8);
      
    }
  }
  
  
  
  
  PVector getNormalPoint(PVector p, PVector a, PVector b ){
      // get vector from a to p
      PVector ap= PVector.sub(p,a);
      
      // now get vector from point a to b
      PVector ab = PVector.sub(b,a);
      //now normalize it
      ab.normalize();
      
      // get theta (angle between ap - ab)
      float theta = acos(((ap.x * ab.x + ap.y * ab.y) * ab.mag())/ap.mag());
      
      //projection ap over ab
      ab.mult(ap.mag()* cos(theta));
      ab.add(a);
      
      return ab;
  
  }
  
    
  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + PI/2;
    fill(renderColor);
    stroke(0);
    strokeWeight(1);
  
  
    
          
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


