Vehicle[] v = new Vehicle[10];


void setup(){
  size(640, 360);
  for (int i=0; i<v.length; i++)
    v[i] = new Vehicle(width*random(1), height*random(1));
}

void draw(){
    background(255);
 
   
    for (int i=0; i<v.length; i++){
      //v[i].seek(mouse);
      v[i].wander();
      v[i].update();
      v[i].checkEdges();
      v[i].display();
    }
}
