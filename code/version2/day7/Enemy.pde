/****************************************
 ****
 Enemy Class
 ****
 ***************************************/

class Enemy {

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Enemy Variables
   ***
   **************************************/

  int enemyLifeLeft; // enemy's life left
  int enemySpaceshipX; // x coordinate of the enemy's spaceship
  int enemySpaceshipY; // y coordinate of the enemy's spaceship

  int moveEnemySpaceshipX = 5; // moves the enemy spaceship x coordinate
  boolean leftBorder = false; // left border
  boolean rightBorder = false; // right border

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Enemy Constructor
   ***
   **************************************/

  public Enemy(int enemyLifeLeft, int enemySpaceshipX, int enemySpaceshipY) {
    /** Set the Variables **/
    this.enemyLifeLeft = enemyLifeLeft;
    this.enemySpaceshipX = enemySpaceshipX;
    this.enemySpaceshipY = enemySpaceshipY;
  } // enemy constructor

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Enemy Functions
   ***
   **************************************/

  void updateEnemyMovementX() {

    /*******************************************
     Moves the Enemy Spaceship
     *******************************************/

    /** Moves the Enemy Spaceship **/

    enemySpaceshipX+= moveEnemySpaceshipX; // moves the enemy spaceship

    /** Checks Enemy Spaceship Position Based on Border Touched **/
    if ((enemySpaceshipX >= 500 && enemySpaceshipX > 200) && rightBorder == false) {
      rightBorder = true; // right border is touched
      leftBorder = false; // left border is set to false
    } else if (enemySpaceshipX <= 200 && leftBorder == false) {
      leftBorder = true; // left border is touched
      rightBorder = false; // right border is set to false
    }

    /** Changes Enemy Spaceship Movement Depending on Border Touched **/
    if (rightBorder && !leftBorder) {
      moveEnemySpaceshipX = -5;
    } else if (!rightBorder && leftBorder) {
      moveEnemySpaceshipX = 5;
    }
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}
