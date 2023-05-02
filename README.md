# Simulation of bees collecting nectar from flowers
This project is part of a university course, called Software Development in practice, where using the Processing programming language (V3), the goal was to create a simulation of an ecosystem containing a bee hive, bees, flower patches.

More specifically, the simulation includes __*3*__ main entities. __*Collector Bees*__ are bees whose only task is to collect the nectar from spotted flower patches. After collecting the nectar, they return to the bee hive, where they await until a new flower patch is found. __*Seeker Bees*__ are bees that constantly fly around inside the ecosystem and their only task is to "spot" a flower patch and then return to the bee hive to "**inform**" the others. __*Flower patch*__ is a patch of random number of flowers (depicted as circles) that bees can seek and harvest. Harvested flowers are indicated with a red tone. Harvested flowers reproducing their nectar after a couple of seconds.

---
### Demonstration:
**On the left** we see the bee hive and the collector bees (smaller bees) that fly around it waiting for a spot
**On the right** we see a flower patch (unharvested) and a seeker bee (bigger in size) landing on it as it "spots" it.
![image](https://user-images.githubusercontent.com/47693513/235554561-b62468ac-e66b-4db0-bdff-78f2eb0bd288.png)

Collector bees flying towards a spotted flower patch for harvesting.

![image](https://user-images.githubusercontent.com/47693513/235554779-6433a0dd-1807-4df0-b6cf-f938d7302214.png)

Flower patch flowers reproducing their nectar.

![image](https://user-images.githubusercontent.com/47693513/235554833-8a38a915-0759-4465-913b-357f69eb64e6.png)

---
### How to run?
  - After opening the project locally, click on the *run* button to start the simulation in Processing
  - Then, Enter the number of seeker bees and collector bees
 
After running the simulation, you are able to alter various parameters in real-time.

__For example you may change__ 
  - The number of seeker and collector bees (add and remove)
  - You may add a new flower patch
  - You may remove a flower patch only if it has been harvested
  
