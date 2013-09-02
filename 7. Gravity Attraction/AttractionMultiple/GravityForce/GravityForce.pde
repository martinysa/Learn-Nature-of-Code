Mover[] movers = new Mover[3];
Attractor a;

void setup() {
  size(600,400);
  for(int i = 0; i < movers.length; i++){
    movers[i] = new Mover(); 
  }
  
  a = new Attractor();
}

void draw() {
  background(255);
  //a.display();
  
  //Gravity force between bodies
  // Formula:
  
  //Fgrav = (G * m1 * m2)/d^2 * ^r
  
  //G: constant gravity
  //m1: mass of bodie 1
  //m2: mass of other bodie
  //d: distance between thats bodies
  //r: normalize direction vector
  
  for(int i = 0; i < movers.length; i++){
    for (int j = 0; j < movers.length; j++){
      if (i != j){
         PVector force = movers[i].attract(movers[j]);
         movers[j].applyForce(force);
      }
    }
    
    movers[i].update();
    //movers[i].checkEdges();
    movers[i].display(); 
  }
  
  
  
}
