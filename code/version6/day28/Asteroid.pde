/****************************************
 ****
 Asteroid Class
 ****
 ***************************************/

class Asteroid {

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Asteroid Variables
   ***
   **************************************/

  ArrayList<PImage> asteroids = new ArrayList<PImage>(); // asteroids's image array list
  int[] randomAsteroidXVals = new int[backgroundPic.width]; // random asteroid x values
  int[] randomAsteroidYVals = new int[backgroundPic.width]; // random asteroid y values
  int asteroidSpeed; // speed of the asteroid
  int asteroidDmg; // asteroid damage

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Asteroid Constructor
   ***
   **************************************/

  public Asteroid(int asteroidSpeed) {
    /** Set the Variables **/
    this.asteroidSpeed = asteroidSpeed;
  } // asteroid constructor

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Asteroid Functions
   ***
   **************************************/

  void createAsteroids() {

    /**********************************************
     Creates Asteroids
     **********************************************/

    for (int i = 0; i < 6; i++) {
      asteroids.add(loadImage("asteroid.png")); // adds the asteroid image to the list
      asteroids.get(i).resize(30, 30); // resizes the asteroid image
    } // generates 6 asteroids
  }

  void initAsteroidPos() {

    /**********************************************
     Initial Asteroid Position
     **********************************************/

    for (int a = 0; a < randomAsteroidYVals.length; a++) {
      randomAsteroidXVals[a] = int(random(width-700, width-200)); // random x asteroid values
      randomAsteroidYVals[a] = int(random(20, 150)); // random y asteroid values
    } // generates random positions for the asteroid
  }

  void randAsteroidValues(int asteroid) {

    /**********************************************
     Generates Random Asteroid Y Value
     **********************************************/

    randomAsteroidXVals[asteroid] = int(random(width-700, width-200)); // random x asteroid values
    randomAsteroidYVals[asteroid] = int(random(-150, -1)); // random y asteroid values
  }

  void asteroidMechanics() {

    /**********************************************
     Mechanics of the Asteroid
     **********************************************/

    for (int k = 0; k < asteroids.size(); k++) {
      image(asteroids.get(k), randomAsteroidXVals[k], randomAsteroidYVals[k]); // places asteroid image on the screen
      randomAsteroidYVals[k] += asteroidSpeed; // moves the asteroid down

      if (dist(randomAsteroidXVals[k], randomAsteroidYVals[k], player.playerSpaceshipX+135, player.playerSpaceshipY+125) <= 111) {
        if (chapters == "Start") {
          asteroidDmg = 2; // asteroid damage is changed to 2
        } else if (chapters == "Carry on The Legacy") {
          asteroidDmg = 3; // asteroid damage is changed to 3
        } else if (chapters == "The Final One") {
          asteroidDmg = 5; // asteroid damage is changed to 5
        }
        if (obstacleDoDmg) {
          player.playerLifeLeft-=asteroidDmg; // decreases the player's life left on collsion
        } // do damage only if obstacles are allowed to
        randomAsteroidYVals[k] = -100; // shifts the asteroid off the screen
      } // collision is seen of asteroid with player's spaceship

      if (randomAsteroidYVals[k] > 800) {
        randAsteroidValues(k); // generates new random asteroid y value
      } // bottom of the screen is reached

      if (chapterChange) {
        for (int s = 0; s < randomAsteroidYVals.length; s++) {
          randAsteroidValues(s);
        }
      } // resets y asteroid position if a new chapter is seen
    }
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}
