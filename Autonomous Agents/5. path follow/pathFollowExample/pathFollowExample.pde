ArrayList<Vehicle> v;
Path path;
boolean debug = true;

void setup(){
  size(800, 640);
  v = new ArrayList<Vehicle>();
  for (int i=0; i<5; i++){
   // Vehicle cc = new Vehicle(width*random(1), height*random(1));
    v.add(new Vehicle(width*random(1), height*random(1)));
  }
  newPath();
}

void draw(){
    background(255);
    
    path.display();
    
    //if(mousePressed)
      //flowField.display();
   
   
    for (int i=0; i<v.size()-1; i++){
      Vehicle car = v.get(i);
      
      car.followAPath(path);
      car.update();
      car.checkEdges();
      car.display();
    }
}


void newPath() {
  // A path is a series of connected points
  // A more sophisticated path might be a curve
  // A path is a series of connected points
  // A more sophisticated path might be a curve
  path = new Path();
 // path.addPoint(10, 20);
  path.addPoint(-20, height/2);
  path.addPoint(random(0, width/2), random(0, height));
  path.addPoint(random(width/2, width), random(0, height));
  path.addPoint(width+20, height/2);
  //path.addPoint(width-20, 20);


}

void mousePressed() {

  debug = !debug;
}

public void keyPressed() {
  
    
    
    if(key == 'a'){
       v.add(new Vehicle(width*random(1), height*random(1)));
    }else{
      newPath();
    }
 
}
