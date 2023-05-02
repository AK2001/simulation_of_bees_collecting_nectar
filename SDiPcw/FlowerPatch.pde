public class FlowerPatch{
 
  PVector location; // Flower patch location
  float patchSize; // Size of flower patch
  ArrayList<Flower> flowers; // Flowers inside patch
  boolean spotted; // If true, then this patch has been spotted by a seeker bee
  boolean regrown; // IF true, then this patch has regrown
  
  FlowerPatch(){
    
    patchSize = random(100,200);
    location = setRandomLocation();
    
    flowers = new ArrayList<Flower>();
    fillFlowers();
    
    spotted = false;
    regrown = false;
  }
  
  FlowerPatch(float x, float y){
    
    patchSize = random(100,200);
    location = new PVector(x,y);
    
    flowers = new ArrayList<Flower>();
    fillFlowers();
    
    spotted = false;
    regrown = false;
  }
  
  // Sets a random location for the flower patch
  PVector setRandomLocation(){
    float x = random(patchSize,simulationWidth-patchSize);
    float y = random(patchSize,height-patchSize);
   
    while (!checkLocationIsValid(x,y)){
      x = random(patchSize,simulationWidth-patchSize);
      y = random(patchSize,height-patchSize);
    }
        
    return new PVector(x,y);
  }
  
  // Checks if random location is not within hive's boundaries
  boolean checkLocationIsValid(float x, float y){
    PVector[] hiveBoundaries = hive.getBoundaries();
    
    if (x > hiveBoundaries[0].x-patchSize && x < hiveBoundaries[1].x+patchSize
        && y > hiveBoundaries[0].y-patchSize && y < hiveBoundaries[2].y+patchSize){
      return false;
    }
    return true;
  }
  
  // Displays flower patch
  void display(){
    //stroke(0);
    //fill(green);
    //circle(location.x,location.y,patchSize);
    
    displayFlowers();
    //line(simulationWidth/2-(patchSize/2),  height/2-(patchSize/2), simulationWidth/2+(patchSize/2), height/2-(patchSize/2));
    //line(simulationWidth/2-(patchSize/2),  height/2+(patchSize/2), simulationWidth/2+(patchSize/2), height/2+(patchSize/2));
    //line(simulationWidth/2-(patchSize/2),  height/2-(patchSize/2), simulationWidth/2-(patchSize/2), height/2+(patchSize/2));
    //line(simulationWidth/2+(patchSize/2),  height/2+(patchSize/2), simulationWidth/2+(patchSize/2), height/2-(patchSize/2));
        
  }
  
  // If true then this patch can be safely removed from the simulation
  boolean remove(){
    PVector target = new PVector(mouseX,mouseY);
    PVector desired = PVector.sub(target,location);  // A vector pointing from the location to the target
    float d = desired.mag();
    boolean flag = true; // Flag holds true if all flowers have been harvested
    for (Flower f : flowers){flag = f.isHarvested();}
    if (d<patchSize/1.6 && mousePressed && flag){
      return true;
    }
    return false;
  }
  
  void regrow(){// REGROWS PATCH
    boolean flag = true; // true if all flowers have been regrown
    
    for (Flower f : flowers){flag = f.regrow();}
    
    if (flag){ // patch becomes spottable again by seeker bees
      spotted = false;
    }
  }
  
  private void fillFlowers(){
    
      float topSpot = location.y-patchSize/2+40;
      float bottomSpot = location.y+patchSize/2-40;
      float leftSpot = location.x-patchSize/2+40;
      float rightSpot = location.x+patchSize/2-40;
      
      for (float y=topSpot;y<=bottomSpot;y+=20){
        for (float x=leftSpot;x<=rightSpot;x+=20){
          if (x==y) continue;
          flowers.add(new Flower(x,y));
        }
      }
  }
  
  private void displayFlowers(){
    for (Flower f : flowers){f.display(); f.regrow();}
  }
    
  void setLocation(PVector newLocation){location = newLocation;}
  
  PVector getLocation(){return location;}
  
  float getSize(){return patchSize;}
  
  ArrayList<Flower> getFlowers(){return flowers;}
  
  boolean isSpotted(){return spotted;}
  
  void setSpotted(Boolean value){spotted = value;}
  
}
