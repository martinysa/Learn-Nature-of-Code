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
     // Predict location 50 (arbitrary choice) frames ahead
    // This could be based on speed 
    PVector predict = velocity.get();
    predict.normalize();
    predict.mult(50);
    PVector predictLoc = PVector.add(location, predict);

    // Now we must find the normal to the path from the predicted location
    // We look at the normal for each line segment and pick out the closest one

    PVector normal = null;
    PVector target = null;
    float worldRecord = 1000000;  // Start with a very high record distance that can easily be beaten

    // Loop through all points of the path
    for (int i = 0; i < p.points.size()-1; i++) {

      // Look at a line segment
      PVector a = p.points.get(i);
      PVector b = p.points.get(i+1);

      // Get the normal point to that line
      PVector normalPoint = getNormalPoint(predictLoc, a, b);
      // This only works because we know our path goes from left to right
      // We could have a more sophisticated test to tell if the point is in the line segment or not
      if (normalPoint.x < a.x || normalPoint.x > b.x) {
        // This is something of a hacky solution, but if it's not within the line segment
        // consider the normal to just be the end of the line segment (point b)
        normalPoint = b.get();
      }

      // How far away are we from the path?
      float distance = PVector.dist(predictLoc, normalPoint);
      // Did we beat the record and find the closest line segment?
      if (distance < worldRecord) {
        worldRecord = distance;
        // If so the target we want to steer towards is the normal
        normal = normalPoint;

        // Look at the direction of the line segment so we can seek a little bit ahead of the normal
        PVector dir = PVector.sub(b, a);
        dir.normalize();
        // This is an oversimplification
        // Should be based on distance to path & velocity
        dir.mult(10);
        target = normalPoint.get();
        target.add(dir);
      }
    }

    // Only if the distance is greater than the path's radius do we bother to steer
    if (worldRecord > p.radius) {
      seek(target);
    }


    // Draw the debugging stuff
    if (debug) {
      // Draw predicted future location
      stroke(0);
      fill(0);
      line(location.x, location.y, predictLoc.x, predictLoc.y);
      ellipse(predictLoc.x, predictLoc.y, 4, 4);

      // Draw normal location
      stroke(0);
      fill(0);
      ellipse(normal.x, normal.y, 4, 4);
      // Draw actual target (red if steering towards it)
      line(predictLoc.x, predictLoc.y, normal.x, normal.y);
      if (worldRecord > p.radius) fill(255, 0, 0);
      noStroke();
      ellipse(target.x, target.y, 8, 8);
    }
  }
  
  
  
  
  PVector getNormalPoint(PVector p, PVector a, PVector b ){
      // get vector from a to p
      PVector ap= PVector.sub(p,a);
      
      // now get vector from point a to b
      PVector ab = PVector.sub(b,a);
      //now normalize it
      ab.normalize();
      
      //Use phytagoras
      // get theta (angle between ap - ab)
      //float theta = acos(((ap.x * ab.x + ap.y * ab.y) * ab.mag())/ap.mag());
      
      //using DOT product --> is a escalar with means the proyection A vector over B vector
      float s = ap.dot(ab);
     
      //projection ap over ab
      ab.mult(s);
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


