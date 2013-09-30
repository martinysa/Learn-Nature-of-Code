class FlowField{
  PVector[][] field; // 2d array
  int cols, rows;
  int resolution;
  
  FlowField(int r){
     resolution = r;
     cols = width/resolution;
     rows = height/resolution;
     println(cols);
     println(rows);
     
     field = new PVector[cols][rows]; 
     initField();
  }
  
  void initField(){
   noiseSeed((int)random(10000));
   PVector fLine;
   for(int i=0; i<cols; i++){
     for(int j=0; j<rows; j++){
       field[i][j] = new PVector(noise(i*.1),noise(i*0.1+30));
       //field[i][j] = new PVector(random(1), random(1));
       fLine = field[i][j];
     }
   } 
  }
  
  void display(){
   PVector fLine;
   float baseX, baseY;
   stroke(178);
   for(int i=0; i<cols; i++){
     for(int j=0; j<rows; j++){
       fLine = field[i][j];
       fLine.normalize();
       baseX = resolution*i;
       baseY = resolution*j;
       line(baseX, baseY,baseX +(fLine.x*resolution), baseY +(fLine.y*resolution));
     }
   } 
  }
  
  
  PVector lookup(PVector lookup) {
    int column = int(constrain(lookup.x/resolution,0,cols-1));
    int row = int(constrain(lookup.y/resolution,0,rows-1));
    return field[column][row].get();
  }
  
}
