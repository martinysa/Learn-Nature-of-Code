Vehicle[] v = new Vehicle[5];


void setup(){
  size(640, 360);
  for (int i=0; i<v.length; i++)
    v[i] = new Vehicle(width*random(1), height*random(1));
}

void draw(){
    background(255);
    PVector mouse = new PVector(mouseX, mouseY);
    
    
    fill(200);
    stroke(0);
    strokeWeight(2);
    ellipse(mouse.x, mouse.y, 24, 24);
    
   
    for (int i=0; i<v.length; i++){
      v[i].seek(mouse);
      v[i].update();
      v[i].display();
    }
}
