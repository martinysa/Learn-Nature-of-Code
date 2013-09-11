Particle[] particleArray = new Particle[1];

void setup() {
  size(600,400);
  for(int i = 0; i < particleArray.length; i++){
    particleArray[i] = new Particle(width/2, 30); 
  }
}

void draw() {
  background(255);
  
  for(int i = 0; i < particleArray.length; i++){
    PVector gravity = new PVector(0,0.1);
    gravity.mult(particleArray[i].mass);
    particleArray[i].applyForce(gravity);
    
    if(particleArray[i].isDead())
    println("dead particle");
    
    
    particleArray[i].update();
    particleArray[i].display(); 
  }
}
