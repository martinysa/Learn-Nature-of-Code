Vehicle v = new Vehicle(width/2, height/2);

void setup(){
  size(640, 360);
}

void draw(){
    background(255);
    PVector mouse = new PVector(mouseX, mouseY);
    
    
    fill(200);
    stroke(0);
    strokeWeight(2);
    ellipse(mouse.x, mouse.y, 24, 24);
    
    v.seek(mouse);
    v.update();
    v.display();
}
