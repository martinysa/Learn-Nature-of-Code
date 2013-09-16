class ParticleSystem{
  ArrayList<Particle> particles;
  PVector origin;
  int pCount; // particles counter
  int systemType;
  
 ParticleSystem(PVector location, int type){
    particles = new ArrayList<Particle>();
    origin = location.get();
    systemType = type;
  
 } 
  
  void addParticle(){
    if(systemType == 1){
      particles.add(new squareParticle(origin.x,origin.y));
    }else{
       particles.add(new Particle(origin.x,origin.y));
    }
    pCount++;
  }
  
  void run(){
     PVector grav = new PVector(0,.2);
     
     for (int i = particles.size()-1; i >=0 ; i--){
        Particle p = particles.get(i);
        p.applyForce(grav);
        p.run();
    
        // Check die
        if(p.isDead()){
           particles.remove(i); 
           pCount--;
        }
      }
  
  }
  
  void draw(){
    text("Particles :" + particles.size(),10,20);
  }
 
  int particlesCount(){
    return pCount; 
  }
  
}
