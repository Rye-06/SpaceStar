/****************************************
 ****
 Bullet Class
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

  /** Player Bullets **/
  int playerBulletPosX; // x position of the player's bullet
  int playerBulletPosY; // y position of the player's bullet
  int playerBulletSpeed; // player's bullet speed
  int playerBulletDamage; // damage of the player's bullet

  /** Enemy Bullets **/
  int enemyBulletPosX; // x position of the enemy's bullet
  int enemyBulletPosY; // y position of the enemy's bullet
  int enemyShootTime; // random period of time in which the enemy shoots
  int enemyBulletDamage; // damage of the enemy's bullet

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Bullet Functions (Player)
   ***
   **************************************/

  void playerCreateBullets() {

    /**********************************************
     Creates Bullets for the Player to Use
     **********************************************/

    for (int i = 0; i < 6; i++) {
      playerBullets[i] = loadImage("playerBullet.png"); // loads the player bullet
      playerBullets[i].resize(150, 150); // resizes the player bullet image
    } // 5 bullets are created to be used
  }

  void playerInitBulletPos() {

    /*******************************************
     Initial Position of the Player's Bullet
     *******************************************/

    /** Initial Coordinates (Player) **/
    playerBulletPosX = -50; // sets the initial x bullet position off the screen
    playerBulletPosY = -50; // sets the initial y bullet position off the screen

    /** Initial Bullet Speed (Player) **/
    playerBulletSpeed = 0;
  }

  void playerShootBullet() {

    /**********************************************
     Shoots the Bullet from the Player's Spaceship
     **********************************************/

    playerBulletPosX =  player.playerSpaceshipX+152; // sets the x coordinate of the bullet to the player's spaceship x
    playerBulletPosY =  player.playerSpaceshipY+20; // sets the y coordinate of the bullet to the player's spaceship y
    enemyReduceLife = true; // allowed to reduce enemy life
    currentPlayerBullet++; // increments the current bullet being used to the next one

    if (currentPlayerBullet == 5) {
      currentPlayerBullet = 0; // resets the bullets
    } // reloads the bullet
  }

  void playerSpeedBullet() {

    /**********************************************
     Moves the Bullet Up
     **********************************************/

    playerBulletSpeed--; // moves the bullet forward

    playerBullet.playerBulletPosY += playerBullet.playerBulletSpeed; // moves the bullet up (player)

    if (screens == "Play" && playerBullet.playerBulletPosY <= minPosPlayerBulletY) {
      playerBulletSpeed = 0; // resets player's bullet speed when new bullet is generated
    } // resets the speed of the bullet when a new one is shot
  }

  void playerBulletCollide() {

    /*******************************************************
     Checks for Player Bullet Collision with Enemy Spaceship
     ******************************************************/

    if ((playerBulletPosY >= 0 && playerBulletPosY <= enemy.enemySpaceshipY+200) && (playerBulletPosX >= enemy.enemySpaceshipX
      && playerBulletPosX <= enemy.enemySpaceshipX+250) && (enemyReduceLife)) {
      enemy.enemyLifeLeft-=5; // reduces enemy life
      enemyReduceLife = false; // dont reduce enemy life
    } // decreases the enemy's life left on collsion
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Bullet Functions (Enemy)
   ***
   **************************************/

  void enemyCreateBullets() {

    /**********************************************
     Creates Bullets for the Enemy to Use
     **********************************************/

    for (int s = 0; s < 5; s++) {
      enemyBullets[s] = loadImage("enemyLaser.png"); // loads the enemy laser
      enemyBullets[s].resize(5, 400); // resizes the enemy laser
    } // 5 bullets are created to be used
  }

  void enemyInitBulletPos() {

    /*******************************************
     Initial Position of the Enemy's Bullet
     *******************************************/

    /** Initial Coordinates (Enemy) **/
    enemyBulletPosX = 920; // sets the initial x bullet position off the screen
    enemyBulletPosY = 730; // sets the initial y bullet position off the screen
  }

  void updateEnemyShootTime() {

    /**********************************************
     Updates the Random Enemy Shoot Time
     **********************************************/

    enemyShootTime  = int(random(1100, 2000));
  }

  void enemyShoot() {

    /*********************************************
     Shoots the Bullet from the Enemy's Spaceship
     ********************************************/

    enemyBulletPosX =  enemy.enemySpaceshipX+127; // sets the x coordinate of the bullet to the enemy's spaceship x
    enemyBulletPosY =  enemy.enemySpaceshipY+200; // sets the y coordinate of the bullet to the enemy's spaceship y
  }

  void enemyBulletCollide() {

    /*******************************************************
     Checks for Player Bullet Collision with Enemy Spaceship
     ******************************************************/

    if ((enemyBulletPosY >= player.playerSpaceshipY-260) && (enemyBulletPosX >= player.playerSpaceshipX && enemyBulletPosX <= player.playerSpaceshipX+380)) {
      player.playerLifeLeft-=5; // reduces player life
    } // decreases the player's life left on collsion
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}
