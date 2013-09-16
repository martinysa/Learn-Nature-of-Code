ArrayList<ParticleSystem> systems;

void setup() {
  size(600,400);
  systems = new ArrayList<ParticleSystem>();
}

void draw() {
  background(255);
  int particles = 0;
  
   for (ParticleSystem ps: systems) {
    ps.run();
    ps.addParticle();
    particles += ps.particlesCount();  
  }
  
  
  fill(0);
  text("click mouse to add particle systems(Lbutton=circle -- RButton=square)",10,height-30);
  
  fill(175);
  text("Systems count:" + systems.size(),10,20);
  text("Particles:" + particles,10,35);
}
 
 void mousePressed() {
   int t;
   if (mouseButton == LEFT){
     t = 0;
   }else{
     t = 1; 
   }
  systems.add(new ParticleSystem(new PVector(mouseX,mouseY), t));
 }
 
