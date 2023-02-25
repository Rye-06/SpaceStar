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

    playerBulletPosX =  player.playerSpaceshipX+110; // sets the x coordinate of the bullet to the player's spaceship x
    playerBulletPosY =  player.playerSpaceshipY+20; // sets the y coordinate of the bullet to the player's spaceship y
    enemyReduceLife = true; // allowed to reduce enemy life
    currentPlayerBullet++; // increments the current bullet being used to the next one

    if (currentPlayerBullet == 5) {
      currentPlayerBullet = 0; // resets the bullets
    } // reloads the bullet
  }

  void playerSpeedBullet() {

    /**********************************************
     Speed of the Player's Bullet
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

    /** Collision Detection (Effect of Double Damage Added) **/
    if ((playerBulletPosY >= 0 && playerBulletPosY <= enemy.enemySpaceshipY+150) && (playerBulletPosX >= enemy.enemySpaceshipX
      && playerBulletPosX <= enemy.enemySpaceshipX+200) && (enemyReduceLife)) {
      if (chapters == "Start") {
        playerBulletDamage=4;
        if (doubleDmg.doubleDamageEffect) {
          playerBulletDamage=8; // player bullet's damage is doubled
        }
      } else if (chapters == "Carry on The Legacy") {
        playerBulletDamage=6;
        if (doubleDmg.doubleDamageEffect) {
          playerBulletDamage=12; // player bullet's damage is doubled
        }
      } else {
        playerBulletDamage=9;
        if (doubleDmg.doubleDamageEffect) {
          playerBulletDamage=18; // player bullet's damage is doubled
        }
      }
      enemy.enemyLifeLeft-=playerBulletDamage; // reduces enemy life
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
      enemyBullets[s].resize(5, 800); // resizes the enemy laser
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

    if (chapters == "Start") {
      enemyShootTime  = int(random(1300, 2100));
    } else if (chapters == "Carry on The Legacy") {
      enemyShootTime  = int(random(1100, 1250));
    } else {
      enemyShootTime  = int(random(800, 1100));
    }
  }

  void enemyShoot() {

    /*********************************************
     Shoots the Bullet from the Enemy's Spaceship
     ********************************************/

    enemyBulletPosX =  enemy.enemySpaceshipX+100; // sets the x coordinate of the bullet to the enemy's spaceship x
    enemyBulletPosY =  enemy.enemySpaceshipY+150; // sets the y coordinate of the bullet to the enemy's spaceship y
  }

  void enemyBulletCollide() {

    /*******************************************************
     Checks for Player Bullet Collision with Enemy Spaceship
     ******************************************************/

    /** Collision Detection (Effect of Invincibility Added) **/
    if ((enemyBulletPosY <= player.playerSpaceshipY+300) && (enemyBulletPosX >= player.playerSpaceshipX && enemyBulletPosX <= player.playerSpaceshipX+300)) {
      if (chapters == "Start") {
        enemyBulletDamage=8;
        if (invincible.invincibilityEffect) {
          enemyBulletDamage=0; // enemy's bullet now does no damage to the player
        }
      } else if (chapters == "Carry on The Legacy") {
        enemyBulletDamage=9;
        if (invincible.invincibilityEffect) {
          enemyBulletDamage=0; // enemy's bullet now does no damage to the player
        }
      } else {
        enemyBulletDamage=12;
        if (invincible.invincibilityEffect) {
          enemyBulletDamage=0; // enemy's bullet now does no damage to the player
        }
      }
      player.playerLifeLeft-=enemyBulletDamage; // reduces player life
    } // decreases the player's life left on collsion
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}
