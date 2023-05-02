import controlP5.*;

final color red = color(250,0,0);
final color green = color(3,250,33);
final color blue = #036FFA;
final color darkBlue =#0A08BC;
final color yellow = #ECED0C;
final color pink = #F03FE7;

ArrayList<Bee> collectorBees; // Collector bees in the simulation
ArrayList<Bee> seekerBees; // Seeker bees in the simulation
ArrayList<FlowerPatch> patches; // Flower patches in the simulation
Hive hive; // The bee hive
ArrayList<FlowerPatch> spottedPatches; // All the patches that have been spotted by seeker bees

// For removal
ArrayList<FlowerPatch> patchesToRemove;
boolean removeSeeker;
boolean removeCollector;

GUI gui;

// For visuals
PImage bg; // Background Image
PFont honeyFont;
PFont textFont;

float simulationWidth;

void setup(){
  size(1700, 900);
  frameRate(30);
  surface.setLocation(width/15, height/15);
  simulationWidth = width-300; // "Actual" simulation width is actual width-300 as the rightmost 300 pixels are for stats
  
  gui = new GUI(this);
  
  // Bee hive
  hive = new Hive();
  
  // Add the number of the seeker bees
  seekerBees = new ArrayList<Bee>();
  addSeekerBees(getInt("Enter seeker bees - Recommended number is 5."));
  
  // Add the number of the collector bees
  collectorBees = new ArrayList<Bee>();
  addCollectorBees(getInt("Enter collector bees - Recommended number is 30."));
  
  // Add the number of the flower patches
  patches = new ArrayList<FlowerPatch>();
  addPatches(1); // Cannot be 0 else NullPointerException. There must always be a flower patch in the simulation
  
  spottedPatches = new ArrayList<FlowerPatch>();
  
  patchesToRemove= new ArrayList<FlowerPatch>();
  removeSeeker = false;
  removeCollector = false;
  
  bg = loadImage("bgImg.jpg");
  honeyFont = createFont("honeyFont.otf",15);
  textFont = createFont("Arial", 20);
  
}

// BUTTON CONTROLS
public void addSeeker(){
  addSeekerBees(1);
}

public void removeSeeker(){
  if (seekerBees.size()>1){
    removeSeeker = true;
  }
}

public void addCollector(){
  addCollectorBees(1);  
}

public void removeCollector(){
  if (collectorBees.size()>1){
    removeCollector = true;
  }
}

void draw(){
  background(bg);
  
  displayInfo(); // Displays information on the right of the screen
  
  hive.displayHive(); // Displays hive
  
  for (FlowerPatch patch:patches){
    patch.display();
    patch.regrow();
    if (patch.remove()){
      patchesToRemove.add(patch);  
    }
  }
  
  // If there are patches to remove
  patches.removeAll(patchesToRemove);
  
  for (Bee bee : seekerBees){
    bee.spotPatch();
    bee.fly();
    bee.returnHome();
    bee.passEdges();
    bee.display();
  }
  
  // If user has selected to remove a seeker bee
  if (removeSeeker){
    seekerBees.remove(0);
    removeSeeker = false;
  }
  
  for (Bee bee : collectorBees){
    bee.selectPatch();
    bee.checkPatch();
    bee.selectFlowerFromPatch();
    bee.goToFlower();
    bee.fly();
    bee.harvest();
    bee.returnHome();
    bee.display(); 
  }
  
  // If user has selected to remove a collector bee
  if (removeCollector){
    collectorBees.remove(0);
    removeCollector = false;
  }
  
}

void addSeekerBees(float number){
  for(int i=0; i<number;i++){
    seekerBees.add(new SeekerBee(simulationWidth/2,height/2+60)); // Entrance of the hive
  }
}

void addCollectorBees(float number){
  for(int i=0; i<number;i++){
    collectorBees.add(new CollectorBee(simulationWidth/2,height/2+60)); // Entrance of the hive
  }
}

void addPatches(float number){
  for(int i=0; i<number;i++){
    patches.add(new FlowerPatch());
  }
}

void keyPressed() {
  if (key == 'a' || key == 'A'){
    noLoop(); // Without this, the simulation would crash when user adds one more patch
    patches.add(new FlowerPatch(mouseX,mouseY));  
    loop();
  }
}


void displayInfo(){
  
  stroke(0);
  strokeWeight(2);
  line(simulationWidth,0,simulationWidth,height);
  
  fill(255);
  rect(simulationWidth,0,width-simulationWidth,height);
    
  fill(0);
  textFont(honeyFont,50);
  textAlign(CENTER, CENTER);
  text("Welcome to\nThe Bee Simulator", simulationWidth+150,70);
  
  stroke(0);
  strokeWeight(2);
  line(simulationWidth,150,width,150);
   
  textAlign(BASELINE);
  fill(0);
  textFont(textFont,22);
  text("Total bees: " + (seekerBees.size() + collectorBees.size()), simulationWidth+10, 180);
  text("Total seeker bees: " + seekerBees.size() + "      /", simulationWidth+10, 210);
  text("Total collector bees: " + collectorBees.size() + "     /", simulationWidth+10, 240);
  text("Total flower patches: " + patches.size(), simulationWidth+10, 270);
  
  textFont(textFont,18);
  text("To add a patch, point anywhere\n in the simulation and press 'a'", simulationWidth+20, 310);
  text("To delete a patch, click on a patch\nthat has all its flowers harvested", simulationWidth+20, 365);
  fill(red);
  text("It is not recommended to delete\nbees when they are working!!", simulationWidth+20, 430);
  fill(0);
  
  textFont(textFont,22);
  text("Nectar in hive: " + hive.getNectar()/1000 + "g", simulationWidth+12,height-10);
  fill(255);  
}
