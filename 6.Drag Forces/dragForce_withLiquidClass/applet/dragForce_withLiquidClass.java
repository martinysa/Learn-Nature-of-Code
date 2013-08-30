import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class dragForce_withLiquidClass extends PApplet {

Mover[] movers = new Mover[1];
Liquid liq;

public void setup() {
  size(600,400);
  //Init movers
  for(int i = 0; i < movers.length; i++){
    movers[i] = new Mover(); 
  }
  
  //init liquid surface
  liq = new Liquid(0, height/3, width, height/3, 0.1f);
  
}

public void draw() {
  background(255);
  liq.display();
  
  if(keyPressed){
    setup();
  }
  
 
  
  for(int i = 0; i < movers.length; i++){
    PVector gravity = new PVector(0,0.3f);
    
    gravity.mult(movers[i].mass);
    movers[i].applyForce(gravity);
    
    
    //Force of DRAG
    
    // Fd= -1/2 * p * ||vel||^2 * A * Cd * v\u00eal 
    
    //-1/2 :constant opossite velocity direcction
    // p : (ro) constant of density
    // ||vel||^2 : magnitud of velocity to square
    // A: surface area of drag  =1
    // Cp: coeficient of drag
    // v\u00eal: normalize velocity vector
    
    // cleaner function
    // Fd = -Cd * ||vel||^2 * v\u00eal
   
    
    
    if (mousePressed){
     PVector drag = movers[i].velocity.get();
     drag.normalize();
     drag.mult(-1);
     
     float speed = movers[i].velocity.mag();
     float c = 0.08f; 
     
     drag.mult(c * speed * speed);
     
     
      movers[i].applyForce(drag);
      
      text("when more acceleration, more force to drag is affected to ball",10,30);
      text("then acceleration is null and compensated for drag force and only see velocity constant",10,50);
      
    }else{
     text("click",10,30); 
    }
    
    
   
 
    movers[i].update();
    movers[i].checkEdges();
    movers[i].display(); 
  }
}
class Mover{

  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  
  Mover(){
    location = new PVector(random(width), height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = random(0.5f,4);
  }
  
  //Newton's 2nd Law with mass!!
  public void applyForce(PVector force){
    //  A = F/M
    PVector f = PVector.div(force,mass);
   
  
    acceleration.add(f);
  }
  
  public void update(){
  
    
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    //velocity.limit(5);
  }
  
  public void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(location.x, location.y, mass*20, mass*20);
  }

  public void checkEdges() {

    if (location.x > width) {
      location.x = width;
      velocity.x *=-1;
    } 
    else if (location.x < 0) {
      location.x = 0; 
      velocity.x*=-1;
    }

    if (location.y > height) {
      location.y = height;
      velocity.y*=-1;
    } 
    
  }
  
}
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
 
 // Liquid class 
 class Liquid {

  
  // Liquid is a rectangle
  float x,y,w,h;
  // Coefficient of drag
  float c;

  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }
  
  // Is the Mover in the Liquid?
  public boolean contains(Mover m) {
    PVector l = m.location;
    return l.x > x && l.x < x + w && l.y > y && l.y < y + h;
  }
  
  // Calculate drag force
  public PVector drag(Mover m) {
    // Magnitude is coefficient * speed squared
    float speed = m.velocity.mag();
    float dragMagnitude = c * speed * speed;

    // Direction is inverse of velocity
    PVector dragForce = m.velocity.get();
    dragForce.mult(-1);
    
    // Scale according to magnitude
    // dragForce.setMag(dragMagnitude);
    dragForce.normalize();
    dragForce.mult(dragMagnitude);
    return dragForce;
  }
  
  public void display() {
    noStroke();
    fill(0,0,120,200);
    rect(x,y,w,h);
  }

}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#ECE9D8", "dragForce_withLiquidClass" });
  }
}
