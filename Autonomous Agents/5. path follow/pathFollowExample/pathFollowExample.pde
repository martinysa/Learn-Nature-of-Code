Vehicle[] v = new Vehicle[5];
Path path;
boolean debug = true;

void setup(){
  size(800, 640);
  for (int i=0; i<v.length; i++)
    v[i] = new Vehicle(width*random(1), height*random(1));
    
  path = new Path();
}

void draw(){
    background(255);
    
    path.display();
    
    //if(mousePressed)
      //flowField.display();
   
   
    for (int i=0; i<v.length; i++){
      //v[i].seek(mouse);
      //v[i].wander();
      //v[i].follow(flowField);
      v[i].followAPath(path);
      v[i].update();
      v[i].checkEdges();
      v[i].display();
    }
}

void mousePressed() {

  debug = !debug;
}

