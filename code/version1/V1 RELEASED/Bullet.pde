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

  /** Enemy Bullets **/
  int enemyBulletPosX; // x position of the enemy's bullet
  int enemyBulletPosY; // y position of the enemy's bullet
  int enemyShootTime; // random period of time in which the enemy shoots

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
      playerBullets[i] = loadImage("playerBullet.png");
      playerBullets[i].resize(150, 150);
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

    if ((playerBullet.playerBulletPosY >= 0 && playerBullet.playerBulletPosY <= enemy.enemySpaceshipY+200) && (playerBullet.playerBulletPosX >= enemy.enemySpaceshipX
      && playerBullet.playerBulletPosX <= enemy.enemySpaceshipX+250) && (enemyReduceLife)) {
      enemy.enemyLifeLeft-=5; // decreases the enemy's life left on collsion
      enemyReduceLife = false; // dont reduce enemy life
    } // collision is seen
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
      enemyBullets[s] = loadImage("enemyLaser.png");
      enemyBullets[s].resize(5, 400);
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

    if ((enemyBullet.enemyBulletPosY >= player.playerSpaceshipY-260) && (enemyBullet.enemyBulletPosX >= player.playerSpaceshipX && enemyBullet.enemyBulletPosX <= player.playerSpaceshipX+380)) {
      player.playerLifeLeft-=10; // decreases the player's life left on collsion
    } // collision is seen
  }

  void updateEnemyShootTime() {

    /**********************************************
     Updates the Random Enemy Shoot Time
     **********************************************/

    if (chapters == "Start") {
      enemyShootTime  = int(random(1300, 2100));
    } else if (chapters == "Carry on The Legacy") {
      enemyShootTime  = int(random(1100, 1250));
    } else {
      enemyShootTime  = int(random(800, 1100));
    }
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}
