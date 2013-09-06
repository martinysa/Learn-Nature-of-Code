Mover[] movers = new Mover[3];

// Spring object
Spring[] spring = new Spring[3];


void setup() {
  size(600,400);

  
  for(int i = 0; i < movers.length; i++){
    movers[i] = new Mover(random(50,200), 100); 
    spring[i] = new Spring(width/2, 10, 80);
  }
  
  //spring = new Spring(width/2, 10, 100);
}




void draw() {
  background(255);
  
  
  if(keyPressed){
    setup();
  }
  
  for(int i = 0; i < movers.length; i++){
    PVector gravity = new PVector(0,0.3);
    
    gravity.mult(movers[i].mass);
    movers[i].applyForce(gravity);
    
    spring[i].connect(movers[i]);
    
    
    movers[i].update();
    movers[i].drag(mouseX, mouseY);
    spring[i].displayLine(movers[i]);
    movers[i].display(); 
    spring[i].display();
    
  }
}

void mousePressed(){
   for(int i = 0; i < movers.length; i++){
      movers[i].clicked(mouseX, mouseY);
   }
}

void mouseReleased(){
   for(int i = 0; i < movers.length; i++){
      movers[i].stopDragging();
   }
}
