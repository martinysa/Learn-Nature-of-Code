class Pendulum
{
  PVector origin;
  PVector bob;
  PVector posBob = new PVector(0,0);
  float len;
  float angle = PI/4;
  float aVel = 0.0;
  float aAccel = 0.0;
  boolean slave;
  Pendulum parent;
  
  float bobRadious;
  float damping; //amortiguacion arbitraria
  boolean isDragging = false;
  
  Pendulum(PVector _origin, float _r, boolean _slave, Pendulum _p){
    origin = _origin.get();
    len=_r;
    angle = PI/4;
    slave = _slave;
    if (slave){
      parent = _p;
    }
    
   damping = 0.995;
   bobRadious = 48.0;
    
  }
  
  
  void update(){
    if(!isDragging){
      float G = 0.4;
      aAccel = (-1*G / len) * sin(angle);
      aVel += aAccel;
      println(aVel);
      aVel *= damping;
      angle += aVel;
    }
  }
  
  void display(){
    posBob = new PVector (len * sin(angle), len * cos(angle));
    posBob.add(origin);
    stroke(0);
    strokeWeight(2);
    
    //Draw arm
    if(slave){
     origin.set(parent.getPosBob().x,parent.getPosBob().y,0); 
    }
    line(origin.x, origin.y, posBob.x, posBob.y);
        
    ellipseMode(CENTER);
    fill(175);
    if (isDragging) fill(0);
      
    // draw ball
    ellipse(posBob.x, posBob.y, bobRadious, bobRadious);  
  
  }
  
  void start(){
     drag();
     update();
     display();
    
  }
  
   void clicked(int mx, int my) {
    float d = dist(mx, my, posBob.x, posBob.y);
    if (d < bobRadious) {
      isDragging = true;
    }
  }

  
  void stopDragging() {
    if(isDragging){
      aVel = 0; // reset velocity on relese
      isDragging = false;
    }
  }

  void drag() {
    // If we are draging the ball, we calculate the angle between the 
    // pendulum origin and mouse location
    // we assign that angle to the pendulum
    if (isDragging) {
      PVector diff = PVector.sub(origin, new PVector(mouseX, mouseY));      // Difference between 2 points
      angle = atan2(-1*diff.y, diff.x) - PI/2;                      // Angle relative to vertical axis
      //angle = atan(diff.x/diff.y); // calculate angle between arm and y-axis
    }
  }

  PVector getPosBob (){
    return posBob;
  }
    

  
}
