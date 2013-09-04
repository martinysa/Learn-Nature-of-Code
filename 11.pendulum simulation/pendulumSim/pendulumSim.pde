PVector origin;
PVector bob;
float len;
float angle = PI/4;
float aVel = 0.0;
float aAccel = 0.0;

void setup(){
  size(640,400);
  
  len = 180;
  origin = new PVector(width/2,0);
  bob = new PVector(width/2,len);
}

void draw(){
  background(255);
  
  // SOH CAH TOA
  
  bob.x = origin.x + len * sin(angle);
  bob.y = origin.y + len * cos(angle);
  
  line(origin.x, origin.y,bob.x, bob.y);
  ellipse(bob.x, bob.y, 32,32);
  
  aAccel = -0.01 * sin(angle);
  
  angle += aVel;
  aVel += aAccel;
  
  aVel *=.99;
}
