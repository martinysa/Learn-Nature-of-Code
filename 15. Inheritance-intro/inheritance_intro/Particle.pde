class Particle{

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float lifespan = 255.0;
  
  
  Particle(float xPos, float yPos){
    location = new PVector(xPos, yPos);
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    mass = random(0.2,0.4);
  }
  
  

  void applyForce(PVector force){
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    lifespan -=4;
  }
  
  
  
  void display() {
    stroke(0, lifespan);
    strokeWeight(2);
    fill(127, lifespan);
    ellipse(location.x, location.y, mass*20, mass*20);
  }

  void run(){
    update();
    display();
  }

  boolean isDead(){
    if(lifespan <=0){
      return true;
    }else{
      return false;
    }  
  }

}
