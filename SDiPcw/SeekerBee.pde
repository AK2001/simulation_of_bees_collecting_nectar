public class SeekerBee extends Bee{
  
  boolean spottedPatch; // True if bee has spoted a patch
  boolean onSeek; // True if bee is on seek duties
  FlowerPatch targetPatch; // The flower patch object the bee has spoted
  
  SeekerBee(float x, float y){
    super(x,y);
    
    spottedPatch = false;
    onSeek = true;
    targetPatch = null;
  }
  
  // Finds closest flower in distance and returns it
  private FlowerPatch findClosestPatch(){
      float min = 1000000;
      FlowerPatch closestTarget = null;
      
      if (patches.size() == 1){
        closestTarget = patches.get(0);
        return closestTarget;
      }else{
        for (FlowerPatch p : patches){
            float distance = PVector.sub(p.getLocation(), location).magSq(); //changed to magSq() 6.14
            if (distance < min){
              min = distance;
              closestTarget = p;
            }
        }  
        return closestTarget;
      }
   }
   
   
   // If a bee is close to the closest flower patch to it, it lands on it
   // Only if a bee has not spoted a patch already or is on seek duties, it can search for other
   void spotPatch(){
     if (!spottedPatch && onSeek){ 
       
       FlowerPatch p = findClosestPatch();
       if (p!=null){
         PVector target = p.getLocation();
         PVector desired = PVector.sub(target,location);  // A vector pointing from the location to the target
         float d = desired.mag();
         
         // Line showing the closest flower patch to a bee
         //line(location.x,location.y,target.x,target.y); 
         //line(hiveEntrance.x,hiveEntrance.y,location.x,location.y); 
         
         if (d < fieldOfVision + p.getSize()/2 && !p.isSpotted()) {
           // Scale acceleration with arbitrary damping within fieldOfVision pixels
           float m = map(d,0,fieldOfVision,0,maxSpeed);
           desired.setMag(m);
          
           //Line showing the flower patch the bee is going to land on
           //stroke(red);
           //line(location.x,location.y,target.x,target.y);
           
           // Steering = Desired velocity minus current Velocity
           desired.sub(velocity);
           // Limit to maximum steering force
           desired.limit(maxForce);
           super.applyForce(desired);
            
           // If the distance between the bee and the flower patch is less than 0.5, the bee has spotted this
           // patch and will keep track of that patch
           if (d < 0.5) {
             targetPatch = p;
             spottedPatch=true;
             p.setSpotted(true);
           }
           
          } else{
           // Bee keeps moving randomly unless spotting a flower
           acceleration = PVector.random2D();
           acceleration.mult(0.5);
         }
         
         // The angle of the bee-shape
         angle = velocity.heading();
       }
     }
   }
   
   // Makes the bee go straight to the hive if it has spoted a patch
   void returnHome(){
     
     if (spottedPatch){
       
       PVector desired = PVector.sub(hiveEntrance, location);
       float d = desired.mag();
       
       if (d < fieldOfVision) {
         float m = map(d,0,fieldOfVision,0,maxSpeed);
         desired.setMag(m);
                
         // If bee is close to entrance, it stops and informs the others
         if (d < 1) {
           
           desired.setMag(0);
           spottedPatch = false;
           onSeek = true;
           
           // Inform collector bees of the spoted patch
           informOthers();
         }          
       } else{
         desired.setMag(maxSpeed);
       }
       // Steering force
       desired.sub(velocity);
       desired.limit(maxForce);
       super.applyForce(desired);
       angle = velocity.heading();
     }
   }
   
   // When a bee informs others, it adds the patch it spotted to the global spottedPatches ArrayList
   private void informOthers(){
     spottedPatches.add(targetPatch);
   }
   
   // collector bee methods
   void selectPatch(){}
   void checkPatch(){}
   void selectFlowerFromPatch(){}
   void goToFlower(){}
   void harvest(){}
   void bounceAroundHive(){}
  
}
