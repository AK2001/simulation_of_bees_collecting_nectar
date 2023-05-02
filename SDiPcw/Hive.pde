public class Hive{
 
  float x; // Hive's x value (for placement)
  float y; // Hive's y value (for placement)
  float size; // Hive's size
  PVector[] boundaries; // Holds hive's 4 corners (top-left,top-right,bottom-left,bottom-right)
  
  float totalNectar; // Nectar capacity at the beehive
  
  PShape s; // Hive image
  
  Hive(){
    size = 120;
    
    x = simulationWidth/2-(size/2); // The PShape draws from the top left corner so actual center coordinates will not work 
    y = height/2-(size/2);          // We need the -(size/2) offset to make the shape be located in the center
    
    boundaries = new PVector[4];
    
    totalNectar = 0;
    
    s = loadShape("hive.svg"); 
  }
  
  // Displays hive
  void displayHive(){
    shape(s,x,y,size,size);
    stroke(0);
    
    //display hive boundaries as 4 points
    //fill(0);
    //circle(simulationWidth/2-60,height/2-60,10);
    //fill(255);
    //circle(simulationWidth/2+60,height/2-60,10);
    //fill(red);
    //circle(simulationWidth/2-60,height/2+60,10);
    //fill(green);
    //circle(simulationWidth/2+60,height/2+60,10);
  }
  
  // Returns the four corners around the hive
  PVector[] getBoundaries(){
    PVector topLeft = new PVector(simulationWidth/2-(size/2),height/2-(size/2));
    PVector topRight = new PVector(simulationWidth/2+(size/2),height/2-(size/2));
    PVector bottomLeft = new PVector(simulationWidth/2-(size/2),height/2+(size/2));
    PVector bottomRight = new PVector(simulationWidth/2+(size/2),height/2+(size/2));
    boundaries[0] = topLeft;
    boundaries[1] = topRight;
    boundaries[2] = bottomLeft;
    boundaries[3] = bottomRight;
    return boundaries;
  }
  
  void depositNectar(float nectar){totalNectar+=nectar;}
  float getNectar(){return totalNectar;}
  
}
