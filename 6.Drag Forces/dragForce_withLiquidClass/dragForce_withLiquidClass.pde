Mover[] movers = new Mover[4];
Liquid liq;

void setup() {
  size(600,400);
  //Init movers
  for(int i = 0; i < movers.length; i++){
    movers[i] = new Mover(); 
  }
  
  //init liquid surface
  liq = new Liquid(0, height/2, width, height/2, 0.08);
  
}

void draw() {
  background(255);
  liq.display();
  
  if(keyPressed){
    setup();
  }
  
 
  
  for(int i = 0; i < movers.length; i++){
    PVector gravity = new PVector(0,0.1);
    
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
   
    
     if(liq.contains(movers[i])){
       //calc drag force
       PVector dragForce = liq.drag(movers[i]);
       // apply that force
       movers[i].applyForce(dragForce);
    
     }
  
    
    
   
 
    movers[i].update();
    movers[i].checkEdges();
    movers[i].display(); 
  }
}
