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

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Player Constructor
   ***
   **************************************/

  public Player(int playerLifeLeft, int playerSpaceshipX, int playerSpaceshipY) {
    /** Set the Variables **/
    this.playerLifeLeft = playerLifeLeft;
    this.playerSpaceshipX = playerSpaceshipX;
    this.playerSpaceshipY = playerSpaceshipY;
  } // player constructor

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}
