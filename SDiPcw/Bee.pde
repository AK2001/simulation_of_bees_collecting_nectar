public abstract class Bee{
  
  PVector location; // Bee's location vector
  PVector hiveEntrance; //Entrance of the hive
  PVector velocity; // Bee's velocity vector
  PVector acceleration; // Bee's acceleration vector
  float size; // Bee's size (size) for display
  float angle; // Used to rotate the bee-shape (to simulate direction)
  float maxSpeed; // Max speed that a bee can have
  float maxForce; // Maximum steering force
  float mass; // Bee's mass
  float fieldOfVision; // Bee's field of view
  float nectar; // The nectar the bee has harvested
  
  PShape s; // The bee image
  
  Bee(float x, float y){
    location = new PVector(x, y);
    hiveEntrance = location.copy(); // Every bee's initial location is at the entrance of the hive (set in SDiPcw.pde)
    
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    size = 20;
    angle = 0;
    maxSpeed = 4;
    maxForce = 0.5;
    mass = 1;
    fieldOfVision = 30;
    nectar = 0;
    s = loadShape("bee.svg"); 
  }
  
  // Motion 101
  void fly(){   
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity); 
    acceleration.mult(0);
  }
             
  private void applyForce(PVector force){
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  // Displays the bee
  void display(){
    
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle + PI/2);
    
    shape(s, 0-size/2, 0-size*1.1/2, size, size*1.1);
    
    // Under construction :: Will enable user to see stats for a selected bee
    PVector target = new PVector(mouseX,mouseY);
    PVector desired = PVector.sub(target,location);  // A vector pointing from the location to the target
    float d = desired.mag();
    if (d<size/1.6 && mousePressed){
      fill(0);
      circle(0,0,20);
    }
  
    popMatrix();
    
  }
   
  void bounceOnEdges(){
    if(location.x<size/2 || location.x>simulationWidth-size/2){
      velocity.x *= -1;
    }
    if(location.y<size/2 || location.y>simulationWidth-size/2){
      velocity.y *= -1;  
    }
  }
  
  void passEdges(){
    if(location.x < 0) location.x = simulationWidth;
    if(location.x > simulationWidth) location.x = 0;
    if(location.y < 0) location.y = height;
    if(location.y > height) location.y = 0;
  }
  
  
  float getNectar(){return nectar;}
  
  // Abstract methods
  abstract void selectPatch(); // Collector bees select a patch from the spotted ones
  abstract void checkPatch(); // (in collector bees) patch is checked to see if it has no more flowers to harvest
  abstract void selectFlowerFromPatch(); // Collector bees select a flower from the selected patch
  abstract void harvest(); // Collector bees can harvest flowers
  abstract void goToFlower(); // Collector bees go to flowers they have selected
  abstract void bounceAroundHive(); // When collector bees dont have a flower to go to, they fly around the hive
  abstract void spotPatch(); // Seeker bees can only see flower patches
  abstract void returnHome(); // All bees can return home
  
}
