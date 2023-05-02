public class CollectorBee extends Bee{
  
  boolean harvesting; // True if bee is harvesting a flower
  boolean onHarvest; // True if bee is on harvest duties
  boolean isAtHive; // True if bee is at hive (depositing nectar)
  float countTimeToHarvest; // Starts counting by the time a bee lands on a flower. Resets after harvesting it 
  float timeToHarvest; // Iterations it takes for a bee to harvest a flower (after it has landed on one).
  Flower currentFlowerharvesting; // Current flower that the bee is harvesting.
  
  FlowerPatch targetPatch; // The patch the bee has been instructed to harvest from
  boolean hasPatch; // True if bee has been informed of a patch
  Flower targetFlower; // The flower the bee has been instructed to go to
  boolean hasFlower; // True if bee has selected a flower from patch
  
  CollectorBee(float x, float y){ 
    super(x,y);
    size = 15;
    
    harvesting = false;
    onHarvest = false;
    isAtHive = true;
    timeToHarvest = 50;
    currentFlowerharvesting= null;
    
    hasPatch = false;
    hasFlower = false;
    targetPatch = null;
    targetFlower = null;
  }
    
  void fly(){
    super.fly();
    
    countTimeToHarvest++; // Counter increments every time fly() is called
    // Note that when a bee has landed on a flower, acceleration and velocity is 0, so fly()
    // only icrements the counter
  }
      
  // Selects a patch from the spotted ones
  void selectPatch(){
    if (isAtHive && spottedPatches.size()>0 && !hasPatch){
       targetPatch = spottedPatches.get(0); 
       onHarvest = true;
       hasPatch = true;
    }
  }
  
  // Check if patch has been already harvested, if yes it is removed from spotted patches
  void checkPatch(){
    if (hasPatch){
      boolean flag = true;
      for (Flower f:targetPatch.getFlowers()){
        if (!f.isHarvested()){
          flag= false;  
          break;
        }
      }
      if (flag){
        spottedPatches.remove(targetPatch);
        targetPatch = null;
        hasPatch = false;
        onHarvest = false;//++
        targetFlower = null; //++
      }
    }
  }
   
  // Selects a flower to harvest from the selected patch
  void selectFlowerFromPatch(){
    if (targetPatch != null && !hasFlower){
      for (Flower f:targetPatch.getFlowers()){
        if (!f.isOccupied() && !f.isHarvested() && f!=targetFlower){
          f.setOccupied(true);
          targetFlower = f;
          hasFlower = true;
          break;
        }
      }
    }
  }
  
    
  // If a bee is not harvesting a flower and is given a target to go to (from a seeker bee)
  // then it will go sit and harvest on that given flower, then return to its hive.
  void goToFlower(){
     if (!harvesting && targetFlower!=null && onHarvest){
       isAtHive = false;
       PVector target = targetFlower.getLocation();
       PVector desired = PVector.sub(target,location);  // A vector pointing from the location to the target
       float d = desired.mag();
    
       // Scale acceleration with arbitrary damping within fieldOfVision pixels
       if (d < fieldOfVision && targetFlower.isHarvested() == false) {
         float m = map(d,0,fieldOfVision,0,maxSpeed);
         desired.setMag(m);
                             
         // If the distance between the bee and the flower is less than 0.5, land on it
         if (d < 0.5) {
          desired.setMag(0);
          sitOn(targetFlower);
         }
          
       } else{
         desired.setMag(maxSpeed);
       }
       // Steering = Desired velocity minus current Velocity
       desired.sub(velocity);
       // Limit to maximum steering force
       desired.limit(maxForce);
       super.applyForce(desired);
       // The angle of the bee-shape
       angle = velocity.heading();
      
      } else if (isAtHive){
        //If Bee hasn't found a flower to go to, it flies around the hive randomly
        acceleration = PVector.random2D();
        acceleration.mult(0.5);
        bounceAroundHive();
        angle = velocity.heading();
      }
   }
   
  
   // Bee sits on a flower, stops and starts harvesting it
  private void sitOn(Flower f){   
    harvesting = true;
    currentFlowerharvesting=f;
    countTimeToHarvest=0;
  }
  
  // Harvest the flower, sets its Harvested attribute to true and changes its color
  void harvest(){
    if (countTimeToHarvest==timeToHarvest && harvesting){
      currentFlowerharvesting.setHarvested(true);
      currentFlowerharvesting.setOccupied(false);
      currentFlowerharvesting.setColor(red);
      
      nectar += currentFlowerharvesting.getNectarCapacity();
      // After harvesting bee needs to return to the hive
      harvesting = false;
      onHarvest = false;
    }
  }
  
  // Makes the bee go straight to the hive if it not on harvesting duties anymore
   void returnHome(){
       
     if (!harvesting && !isAtHive && !onHarvest){
       
       PVector desired = PVector.sub(hiveEntrance, location);
       float d = desired.mag();
       
       if (d < fieldOfVision) {
         float m = map(d,0,fieldOfVision,0,maxSpeed);
         desired.setMag(m);
                
         // If bee is close to entrance, it stops and deposits its nectar
         if (d < 0.1) { 
           desired.setMag(0);
           hive.depositNectar(nectar);
           isAtHive = true;
           hasFlower = false;
           onHarvest = true;
         }
           
        } else{
          desired.setMag(maxSpeed);
        }
        // Steering = Desired velocity minus current Velocity
        desired.sub(velocity);
        // Limit to maximum steering force
        desired.limit(maxForce);
        super.applyForce(desired);
        // The angle of the bee-shape
        angle = velocity.heading();
     }
   }
   
   // Allows collector bees to bounce around hive
   void bounceAroundHive(){
    if(location.x<simulationWidth/2 - 90 + size/2 || location.x>simulationWidth/2 + 90 - size/2){
      velocity.x *= -1;
    }
    if(location.y<height/2 - 90 + size/2 || location.y>height/2 + 90 -size/2){
      velocity.y *= -1;  
    }
  }
   
  //seeker bee method
  void spotPatch(){}
  
  
}
