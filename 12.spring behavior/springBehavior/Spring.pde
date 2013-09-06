class Spring{
 
 PVector anchor; // anclaje
 float len; // spring Rest of length
 float K = .2; //spring constant (force coefficient)
 
 // Constructor
 Spring(float x, float y, int l){
   anchor = new PVector(x,y);
   len = l;  
 }
  
  void connect(Mover b){
    // Caculate direction and magnitud to spring
    PVector force = PVector.sub(b.location, anchor); 
    float d = force.mag(); 
    
    // Now must now if is a rest, extended or compressed
    float stretch = d-len;
    
    // Calculate force according to Hooke's Law
    // F = k * stretch
    force.normalize();
    force.mult(-1 * K * stretch);
    
    
    // Now apply force
    b.applyForce(force);
    
  }
  
  void display(){
    stroke(0);
    fill(175);
    strokeWeight(2);
    // Draw the anchor
    rectMode(CENTER);
    rect(anchor.x, anchor.y, 10, 10);
  }
  
  void displayLine(Mover b){
    strokeWeight(2);
    stroke(30);
    line(b.location.x, b.location.y, anchor.x, anchor.y);
    
  }
    
  
}
