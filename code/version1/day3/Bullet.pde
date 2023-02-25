/****************************************
 ****
 Bullet Class (Player)
 ****
 ***************************************/

class Bullet {

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Bullet Variables
   ***
   **************************************/

  int playerBulletPosX; // x position of the player's bullet
  int playerBulletPosY; // y position of the player's bullet
  int bulletSpeed; // player's bullet speed

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Bullet Functions (Bullet Class)
   ***
   **************************************/

  void initBulletPos() {

    /*******************************************
     Initial Position of the Player's Bullet
     *******************************************/

    /** Initial Coordinates **/
    playerBulletPosX = 0; // sets the initial x bullet position off the screen
    playerBulletPosY = -40; // sets the initial y bullet position off the screen

    /** Initial Bullet Speed **/
    bulletSpeed = 1;
  }

  void shoot() {

    /*********************************************
     Shoots the Bullet from the Player's Spaceship
     ********************************************/

    playerBulletPosX =  playerSpaceshipX+150; // sets the x coordinate of the bullet to the player's spaceship x
    playerBulletPosY =  playerSpaceshipY-20; // sets the y coordinate of the bullet to the player's spaceship y
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}
