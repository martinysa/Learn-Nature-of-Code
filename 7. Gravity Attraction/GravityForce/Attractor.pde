class Attractor {
  float mass;                //Mass of bodie
  float G;                   //Gravity constant
  PVector location;          //Localization object
  boolean dragging = false;  // is object being dragged?
  boolean rollover = false;  //is mouse over the object
  PVector dragOffset;        // holds the offset for when object is clicked on
  
  
  Attractor() {
    location = new PVector(width/2,height/2);
    mass = 40;
    G = 1;
    dragOffset = new PVector(0.0,0.0);
  }

  
  
  PVector attract (Mover m){
    // Direction of force
    PVector force = PVector.sub(location, m.location);
    float d = force.mag();
    d = constrain(d, 5.0,25.0);
    force.normalize(); 
    
    //Magnitude of that force
    float strength = (G * mass * m.mass) / (d * d);
    
    // Magnitud & direction together
    force.mult(strength);
    
    return force;
  }
  
  
  
 // Method to display
  void display() {
    ellipseMode(CENTER);
    strokeWeight(4);
    stroke(0);
    if (dragging) fill (50);
    else if (rollover) fill(100);
    else fill(175,200);
    ellipse(location.x,location.y,mass*2,mass*2);
  }
  
  
}
