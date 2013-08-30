Mover[] movers = new Mover[1];
Liquid liq;

void setup() {
  size(600,400);
  //Init movers
  for(int i = 0; i < movers.length; i++){
    movers[i] = new Mover(); 
  }
  
  //init liquid surface
  liq = new Liquid(0, height/3, width, height/3, 0.1);
  
}

void draw() {
  background(255);
  liq.display();
  
  if(keyPressed){
    setup();
  }
  
 
  
  for(int i = 0; i < movers.length; i++){
    PVector gravity = new PVector(0,0.3);
    
    gravity.mult(movers[i].mass);
    movers[i].applyForce(gravity);
    
    
    //Force of DRAG
    
    // Fd= -1/2 * p * ||vel||^2 * A * Cd * vêl 
    
    //-1/2 :constant opossite velocity direcction
    // p : (ro) constant of density
    // ||vel||^2 : magnitud of velocity to square
    // A: surface area of drag  =1
    // Cp: coeficient of drag
    // vêl: normalize velocity vector
    
    // cleaner function
    // Fd = -Cd * ||vel||^2 * vêl
   
    
    
    if (mousePressed){
     PVector drag = movers[i].velocity.get();
     drag.normalize();
     drag.mult(-1);
     
     float speed = movers[i].velocity.mag();
     float c = 0.08; 
     
     drag.mult(c * speed * speed);
     
     
      movers[i].applyForce(drag);
      
      text("when more acceleration, more force to drag is affected to ball",10,30);
      text("then acceleration is null and compensated for drag force and only see velocity constant",10,50);
      
    }else{
     text("click",10,30); 
    }
    
    
   
 
    movers[i].update();
    movers[i].checkEdges();
    movers[i].display(); 
  }
}
