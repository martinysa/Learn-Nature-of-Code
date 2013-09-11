class Particle{

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float lifespan = 255.0;
  
  
  Particle(float xPos, float yPos){
    location = new PVector(xPos, yPos);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = random(0.5,1.2);
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
    lifespan -=1;
  }
  
  void display() {
    stroke(0, lifespan);
    strokeWeight(2);
    fill(127, lifespan);
    ellipse(location.x, location.y, mass*20, mass*20);
  }

  boolean isDead(){
    if(lifespan <=0){
      return true;
    }else{
      return false;
    }  
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
