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

  int asteroidX; // asteroid x coordinate
  int asteroidSpeed; // speed of the asteroid

  ArrayList<PImage> asteroids = new ArrayList<PImage>(); // asteroids's image array list
  int[] randomAsteroidYVals = new int[backgroundPic.width]; // random asteroid y values

  int asteroidDmg; // asteroid damage

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Asteroid Constructor
   ***
   **************************************/

  public Asteroid(int asteroidX, int asteroidSpeed) {
    /** Set the Variables **/
    this.asteroidX = asteroidX;
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

    for (int i = 0; i < 7; i++) {
      asteroids.add(loadImage("asteroid.png")); // adds the asteroid image to the list
      asteroids.get(i).resize(30, 30); // resizes the asteroid image
    } // generates 7 asteroids
  }

  void initAsteroidPos() {

    /**********************************************
     Initial Asteroid Position
     **********************************************/

    for (int a = 0; a < randomAsteroidYVals.length; a++) {
      randomAsteroidYVals[a] = int(random(20, 150)); // random y asteroid values
    } // generates random positions for the asteroid
  }

  void randAsteroidY(int asteroid) {

    /**********************************************
     Generates Random Asteroid Y Value
     **********************************************/

    randomAsteroidYVals[asteroid] = int(random(-150, -1)); // generates a new random y value for the asteroid
  }

   void asteroidMechanics() {

    /**********************************************
     Mechanics of the Asteroid
     **********************************************/

    for (int k = 0; k < asteroids.size(); k++) {
      image(asteroids.get(k), asteroidX+(k*100), randomAsteroidYVals[k]); // places asteroid image on the screen
      randomAsteroidYVals[k] += asteroidSpeed; // moves the asteroid down

      if (dist(asteroidX+(k*100), randomAsteroidYVals[k], player.playerSpaceshipX+185, player.playerSpaceshipY+185) <= 138) {
        asteroidDmg = 5; // asteroid damage is 5
        player.playerLifeLeft-=asteroidDmg; // decreases the player's life left on collsion
        randomAsteroidYVals[k] = -100; // shifts the asteroid off the screen
      } // collision is seen of asteroid with player's spaceship

      if (randomAsteroidYVals[k] > 800) {
        randAsteroidY(k); // generates new random asteroid y value
      } // edge of screen is reached
    } // resets y asteroid position if a new chapter is seen
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}
