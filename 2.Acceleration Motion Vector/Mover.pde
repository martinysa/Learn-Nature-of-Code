class Mover{

  PVector location;
  PVector velocity;
  PVector acceleration;
  
  Mover(){
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void update(){
    PVector mouse = new PVector(mouseX, mouseY);
    mouse.sub(location);
    mouse.mult(0.05);
    
    acceleration = mouse;
    velocity.add(acceleration);
    location.add(velocity);
    velocity.limit(5);
  }
  
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(location.x, location.y, 48, 48);
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = 0;
    } 
    else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      location.y = 0;
    } 
    else if (location.y < 0) {
      location.y = height;
    }
  }
  
}
