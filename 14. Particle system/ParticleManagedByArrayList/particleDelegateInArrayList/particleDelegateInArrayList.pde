import processing.opengl.*;
ArrayList<Particle> particles;

void setup() {
  size(600,400,OPENGL);
  particles = new ArrayList<Particle>();
 //for (int i = 0; i <= 10; i ++){
 //   particles.add(new Particle(200,20));
 //}
}

void draw() {
  background(0);
  sphereDetail(10);
  lights();
  if(mousePressed){
    for(int c = 0; c < 2; c++){
      particles.add(new Particle(mouseX,mouseY));
    }
  }else{
    particles.add(new Particle(200,20));
  }
  
  
  PVector grav = new PVector(0,.1);
  //for (int i = 0; i < particles.size(); i++){
  //PERFORMANCE
  for (int i = particles.size()-1; i >=0 ; i--){
  
    Particle p = particles.get(i);
    p.applyForce(grav);
    p.update();
    p.display();
    
    // Check die
    if(p.isDead()){
       particles.remove(i); 
    }
  }
  
  fill(255);
  text("Particles :" + particles.size(),10,20);
  //println(particles.size());
  
}
