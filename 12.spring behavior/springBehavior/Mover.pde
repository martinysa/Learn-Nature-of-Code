class Mover{

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float damping;
  
  // For mouse interaction
  PVector dragOffset;
  boolean dragging = false;
  
  Mover(float x, float y){
    location = new PVector(x, y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = random(20,34);
    damping = random(0.97,0.999);
    dragOffset = new PVector();
    
  }
  
  //Newton's 2nd Law with mass!!
  void applyForce(PVector force){
    //  A = F/M
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update(){
  
    
    velocity.add(acceleration);
    velocity.mult(damping);
    location.add(velocity);
    acceleration.mult(0);
    //velocity.limit(5);
  }
  
  // Draw the bob
  void display() { 
    stroke(0);
    strokeWeight(2);
    fill(175);
    if (dragging) {
      fill(50);
    }
    ellipse(location.x,location.y,mass*2,mass*2);
  } 

  // The methods below are for mouse interaction

  // This checks to see if we clicked on the mover
  void clicked(int mx, int my) {
    float d = dist(mx,my,location.x,location.y);
    if (d < mass) {
      dragging = true;
      dragOffset.x = location.x-mx;
      dragOffset.y = location.y-my;
    }
  }

  void stopDragging() {
    dragging = false;
  }

  void drag(int mx, int my) {
    if (dragging) {
      location.x = mx + dragOffset.x;
      location.y = my + dragOffset.y;
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
