class squareParticle extends Particle{
   
  squareParticle(float xPos, float yPos){
    super(xPos, yPos);
  }
  
  void display(){
    stroke(0, lifespan);
    fill(127, lifespan);
    rectMode(CENTER);
    rect(location.x, location.y, mass*20, mass*20);
      
    
  }
  
}
