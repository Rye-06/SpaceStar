/****************************************
 ****
 Player Class
 ****
 ***************************************/

class Player {

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Player  Variables
   ***
   **************************************/

  int playerLifeLeft; // player's life left
  int playerSpaceshipX; // x coordinate of the player's spaceship
  int playerSpaceshipY; // y coordinate of the player's spaceship
  int playerSpeed; // player speed

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Player Constructor
   ***
   **************************************/

  public Player(int playerLifeLeft, int playerSpaceshipX, int playerSpaceshipY, int playerSpeed) {
    /** Set the Variables **/
    this.playerLifeLeft = playerLifeLeft;
    this.playerSpaceshipX = playerSpaceshipX;
    this.playerSpaceshipY = playerSpaceshipY;
    this.playerSpeed = playerSpeed;
  } // player constructor

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}
