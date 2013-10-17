class Path{
  ArrayList<PVector> points;
  
  float radius;
  
  
  Path() {
    // Arbitrary radius of 20
    radius = 20;
    points = new ArrayList<PVector>();
  }

 
  void addPoint(float x, float y){
    points.add(new PVector(x,y));
  }
  
  PVector getStart(){
    return points.get(0);
  }
   PVector getEnd(){
    return points.get(points.size()-1);
  }
  
  // Draw the path
  void display() {

    for(int i = 1; i < points.size(); i++){
      strokeWeight(radius*2);
      stroke(0,0,100,100);
      line(points.get(i-1).x,points.get(i-1).y,points.get(i).x,points.get(i).y);

      strokeWeight(1);
      stroke(0);
      line(points.get(i-1).x,points.get(i-1).y,points.get(i).x,points.get(i).y);
    }
    
  }


}
