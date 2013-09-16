ArrayList<ParticleSystem> systems;

Attractor at;

void setup() {
  size(600,400);
  systems = new ArrayList<ParticleSystem>();
  at = new Attractor();
}

void draw() {
  background(255);
  at.display();
  int particles = 0;
  
   for (ParticleSystem ps: systems) {
    ps.run();
    ps.addParticle();
    particles += ps.particlesCount();
    
    //Attract
    
    ps.attract(at);
  
    if(mousePressed){
      if(mouseButton == RIGHT){
        PVector wind = new PVector(mouseX*.001,0);
        ps.applyForce(wind);  
      }
      
    }
     
  }
  
 
  
  
  fill(0);
  text("Left click to add particle systems",10,height-45);
  text("Right click to blow",10,height-30);
  
  fill(175);
  text("Systems count:" + systems.size(),10,20);
  text("Particles:" + particles,10,35);
}
 
 void mousePressed() {
  if(mouseButton == LEFT){
     int t=0;
     systems.add(new ParticleSystem(new PVector(mouseX,mouseY), t));
  }
 }
 
