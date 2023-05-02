public class GUI{
 
  ControlP5 cp5;
  Button addSeeker;
  Button removeSeeker;
  Button addCollector;
  Button removeCollector;
  
  GUI(PApplet thePApplet){
    cp5 = new ControlP5(thePApplet);
    
    textFont = createFont("Arial", 25);
    
    addSeeker = cp5.addButton("addSeeker").setValue(0).setPosition(simulationWidth+255,192).setSize(20,20);
    addSeeker.setFont(textFont).setCaptionLabel("+");
    addSeeker.setColorActive(green).setColorBackground(color(0));
    addSeeker.activateBy(ControlP5.PRESS);
    
    removeSeeker = cp5.addButton("removeSeeker").setValue(0).setPosition(simulationWidth+220,192).setSize(20,20);
    removeSeeker.setFont(textFont).setCaptionLabel("-");
    removeSeeker.setColorActive(green).setColorBackground(color(0));
    removeSeeker.activateBy(ControlP5.PRESS);
    
    addCollector = cp5.addButton("addCollector").setValue(0).setPosition(simulationWidth+275,222).setSize(20,20);
    addCollector.setFont(textFont).setCaptionLabel("+");
    addCollector.setColorActive(green).setColorBackground(color(0));
    addCollector.activateBy(ControlP5.PRESS);
    
    removeCollector = cp5.addButton("removeCollector").setValue(0).setPosition(simulationWidth+242,222).setSize(20,20);
    removeCollector.setFont(textFont).setCaptionLabel("-");
    removeCollector.setColorActive(green).setColorBackground(color(0));
    removeCollector.activateBy(ControlP5.PRESS);
    
    
  }
  
  
}
