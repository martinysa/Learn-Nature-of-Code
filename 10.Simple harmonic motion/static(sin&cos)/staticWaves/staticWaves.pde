
float angle = 0;
float angleVel = 0.1;

size(800,200);
background(255);
stroke(0);
strokeWeight(2);
noFill();

beginShape();
for (int x = 0; x <= width; x += 5) {
  float y = map(sin(angle),-1,1,0,height);
  vertex(x,y);
  angle +=angleVel;
} 
endShape();

stroke(200,255,0);
beginShape();
for (int x = 0; x <= width; x += 5) {
  float y = map(cos(angle),-1,1,0,height);
  vertex(x,y);
  angle +=angleVel;
} 
endShape();
