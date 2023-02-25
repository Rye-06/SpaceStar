/****************************************
 ****
 meteor Class
 ****
 ***************************************/

class Meteor {

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Meteor Variables
   ***
   **************************************/

  ArrayList<PImage> meteors = new ArrayList<PImage>(); // meteor's image array list
  int[] randomMeteorXVals = new int[backgroundPic.width]; // random meteor x values
  int[] randomMeteorYVals = new int[backgroundPic.width]; // random meteor y values
  int meteorSpeed; // speed of the meteor
  int meteorDmg; // meteor damage

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Meteor Constructor
   ***
   **************************************/

  public Meteor(int meteorSpeed) {
    /** Set the Variables **/
    this.meteorSpeed = meteorSpeed;
  } // meteor constructor

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Meteor Functions
   ***
   **************************************/

  void createMeteors() {

    /**********************************************
     Creates Meteor
     **********************************************/

    for (int i = 0; i < 3; i++) {
      meteors.add(loadImage("meteor.png")); // adds the meteor image to the list
      meteors.get(i).resize(30, 30); // resizes the meteor image
    } // generates 3 meteors
  }

  void initMeteorPos() {

    /**********************************************
     Initial Meteor Position
     **********************************************/

    for (int a = 0; a < randomMeteorYVals.length; a++) {
      randomMeteorXVals[a] = int(random(width-700, width-200)); // random x meteor values
      randomMeteorYVals[a] = int(random(20, 150)); // random y meteor values
    } // generates random positions for the meteor
  }

  void randMeteorValues(int meteor) {

    /**********************************************
     Generates Random Meteor Y Value
     **********************************************/

    randomMeteorXVals[meteor] = int(random(width-700, width-200)); // generates a new random x values for the meteor
    randomMeteorYVals[meteor] = int(random(-150, -1)); // generates a new random y value for the meteor
  }

  void meteorMechanics() {

    /**********************************************
     Mechanics of the Meteor
     **********************************************/

    for (int k = 0; k < meteors.size(); k++) {
      image(meteors.get(k), randomMeteorXVals[k], randomMeteorYVals[k]); // places meteor image on the screen
      randomMeteorYVals[k] += meteorSpeed; // moves the meteor down

      if (dist(randomMeteorXVals[k], randomMeteorYVals[k], player.playerSpaceshipX+135, player.playerSpaceshipY+125) <= 111) {
        if (chapters == "Start") {
          meteorDmg = 10; // meteor damage is changed to 10
        } else if (chapters == "Carry on The Legacy") {
          meteorDmg = 15; // meteor damage is changed to 15
        } else if (chapters == "The Final One") {
          meteorDmg = 20; // meteor damage is changed to 20
        }
        if (obstacleDoDmg) {
          player.playerLifeLeft-=meteorDmg; // decreases the player's life left on collsion
        } // do damage only if meteor is allowed to do damage
        randomMeteorYVals[k] = -100; // shifts the meteor off the screen
      } // collision is seen of meteor with player's spaceship

      if (randomMeteorYVals[k] > 800) {
        randMeteorValues(k); // generates new random meteor y value
      } // bottom of the screen is reached

      if (chapterChange) {
        for (int s = 0; s < randomMeteorYVals.length; s++) {
          randMeteorValues(s);
        }
        chapterChange = false; // chapter change is now false
      } // resets y meteor position if a new chapter is seen
    }
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}
