ArrayList<Vehicle> vehicles;
Path path;
boolean debug = true;


void setup(){
  size(600, 600);
  vehicles = new ArrayList<Vehicle>();
  for (int i=0; i<10; i++)
    vehicles.add(new Vehicle(width*random(1), height*random(1)));
}

void draw(){
    background(255);
    PVector mouse = new PVector(mouseX, mouseY);
   
    for (int i=0; i<vehicles.size()-1; i++){
      Vehicle car = vehicles.get(i);
      
      PVector separateForce = car.separate(vehicles);
      separateForce.mult(2);
      
      car.applyForce(separateForce);
      car.applyForce(car.seek(mouse));
     
      car.update();
      car.checkEdges();
      car.display();
    }
}
