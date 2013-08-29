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

public class ApplyFrictionForce extends PApplet {

Mover[] movers = new Mover[5];

public void setup() {
  size(600,400);
  for(int i = 0; i < movers.length; i++){
    movers[i] = new Mover(); 
  }
}

public void draw() {
  background(255);
  
  for(int i = 0; i < movers.length; i++){
    PVector gravity = new PVector(0,0.3f);
    // mass doesn\u00b4t affect gravity force
    // then add mas to acceleration
    gravity.mult(movers[i].mass);
    //then apply the force of gravity
    //now, inside applyforce will divide force by acceleration
    movers[i].applyForce(gravity);
    //result: gravity equal for anything object (independently its mass)
    
    
    
    //Wind force
    PVector wind = new PVector(0.2f,0);
   // movers[i].applyForce(wind); 
 
 
   // --- Friction force --- 
   //FORCE(friction) = -1 * u * || N || * v\u00eal
   // -1: opossite direcction to velocity
   // u: coef Friction
   // || N || : Magnitude of Normal vector from Force (=1 in our sketch)
   // v\u00eal : Velocity vector Normalized!
   
   
   PVector friction = movers[i].velocity.get();
   friction.normalize();
   friction.mult(-1);
   
   float c=0.11f;
   friction.mult(c);
   movers[i].applyForce(friction);
 
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
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#ECE9D8", "ApplyFrictionForce" });
  }
}
