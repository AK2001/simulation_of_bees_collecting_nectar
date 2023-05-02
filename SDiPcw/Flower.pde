public class Flower{
 
  PVector location; // Flower's location
  float nectarCapacity; // Flower's nectar capacity
  boolean harvested; // True if flower has already been harvested
  boolean occupied; // True if flower is occupied by a bee
  float flowerSize; // The size of the flower
  color flowerColor = yellow; // The color of the flower
  
  int regrowTimer; // Counts from the moment the flower is harvested
  int regrowTime; // The time until a flower can regrow

  Flower(float x, float y){
    
    flowerSize = 20;
    location = new PVector(x,y);
    
    float randomNectarCapacity = random(0.41,7.7); //units in mg
    nectarCapacity = map(randomNectarCapacity,0.41,7.7,0,100);
    
    harvested = false;
    occupied = false;
    
    regrowTimer = 0;
    regrowTime = 2000;
  }
  
  boolean regrow(){// REGROW FLOWER
    if (harvested == true) regrowTimer++;
    
    if (regrowTimer == regrowTime && harvested){
       flowerColor = yellow;
       float randomNectarCapacity = random(0.41,7.7); //units in mg
       nectarCapacity = randomNectarCapacity;
       
       harvested = false;
       occupied = false;  
       regrowTimer = 0;
       return true;
    }
    return false;
  }
  
  // Displays flower as a circle
  void display(){
    stroke(0);
    fill(flowerColor);
    circle(location.x,location.y,flowerSize);
  }
  
  PVector getLocation(){return location;}
  
  void setOccupied(boolean value){occupied = value;}
  
  boolean isOccupied(){return occupied;}
  
  void setHarvested(boolean value){harvested = value;}
  
  boolean isHarvested(){return harvested;}
  
  void setColor(color value){flowerColor = value;}
  
  float getNectarCapacity(){return nectarCapacity;}
  
 
  
}
