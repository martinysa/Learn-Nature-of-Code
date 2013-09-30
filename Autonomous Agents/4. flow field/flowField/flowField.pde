Vehicle[] v = new Vehicle[50];
FlowField flowField;

void setup(){
  size(600, 320);
  for (int i=0; i<v.length; i++)
    v[i] = new Vehicle(width*random(1), height*random(1));
    
  flowField = new FlowField(10);
}

void draw(){
    background(255);
    //flowField.initField();
    if(mousePressed)
      flowField.display();
   
   
    for (int i=0; i<v.length; i++){
      //v[i].seek(mouse);
      //v[i].wander();
      v[i].follow(flowField);
      v[i].update();
      v[i].checkEdges();
      v[i].display();
    }
}

void mousePressed() {
  flowField.initField();
}

