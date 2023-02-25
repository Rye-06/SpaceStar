/****************************************
 ****
 Boosts Class
 ****
 ***************************************/

class Boosts {

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Boosts Variables
   ***
   **************************************/

  /** Double Damage **/
  int doubleDamageX; // x coordinate of the double damage boost
  int doubleDamageY; // y coordinate of the double damage boost
  int doubleDamageTimer; // timer to appear the double damage boost
  int doubleDamageSpeed = 3; // double damage boost moving speed
  int doubleDamageEffectTimer; // how long does the double damage effect stay for
  boolean doubleDamageEffect; // double damage effect is activated or not
  int doubleDamageAppearAfter; // appear the double damage boost after a certain time

  /** Invincibility **/
  int invincibilityX; // x coordinate of the invincibility boost
  int invincibilityY; // y coordinate of the invincibility boost
  int invincibilityTimer; // timer to appear the invincibility boost
  int invincibilitySpeed = 4; // invincibility boost moving speed
  int invincibilityEffectTimer; // how long does the invincibility boost effect stay for
  boolean invincibilityEffect; // invincibility effect is activated or not
  int invincibilityAppearAfter; // appear the invincibility boost after a certain time

  /** Fueled Speed (Increases Speed) **/
  int fuelX; // x coordinate of the fuel boost
  int fuelY; // y coordinate of the fuel boost
  int fuelTimer; // timer to appear the fuel boost
  int fuelSpeed = 4; // fuel boost moving speed
  int fuelEffectTimer; // how long does the fuel boost effect stay for
  int fuelAppearAfter; // appear the fuel boost after a certain time

  /** Health **/
  int healthX; // x coordinate of the health boost
  int healthY; // y coordinate of the health boost
  int healthTimer; // timer to appear the health boost
  int healthSpeed = 4; // health boost moving speed
  int healthAppearAfter; // appear the health boost after a certain time


  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Boosts Functions (Double Damage)
   ***
   **************************************/

  void doubleDamageInitPos() {

    /*******************************************
     Initial Position of the Double Damage Boost
     *******************************************/

    /** Initial Coordinates (Double Damage) **/
    doubleDamageX = int(random(width-700, width-200)); // sets the initial x double damage boost position off the screen
    doubleDamageY = -100; // sets the initial y double damage boost position off the screen
  }

  void updateDoubleDamageAppearAfterTimer() {

    /*******************************************
     Updates Double Damage Boost Appear After Timer
     *******************************************/

    if (chapters == "Start") {
      doubleDamageAppearAfter  = int(random(1500, 2000));
    } else if (chapters == "Carry on The Legacy") {
      doubleDamageAppearAfter  = int(random(800, 1100));
    } else {
      doubleDamageAppearAfter  = int(random(500, 800));
    }
  }

  void doubleDamageAppear() {

    /**********************************************
     Makes the Double Damage Boost Appear On Screen
     **********************************************/

    doubleDamageY+=doubleDamageSpeed; // moves the double damage boost down

    if (doubleDamageY >= height) {
      doubleDamageInitPos(); // shifts the double damage boost back to its initial position
      doubleDamageTimer = millis(); // resets the double damage appear timer
      updateDoubleDamageAppearAfterTimer(); // updates the double damage boost appear after timer
    } // double damage boost disappears once it reaches the bottom

    doubleDamageCollision(); // checks for double damage boost's collision with player's spaceship
  }

  void doubleDamageCollision() {

    /***************************************************************
     Checks for Double Damage Boost Collision with Player's Spaceship
     ***************************************************************/

    if (dist(doubleDamageX, doubleDamageY, player.playerSpaceshipX+110, player.playerSpaceshipY+125) <= 125) {
      doubleDamageInitPos(); // shifts the double damage boost to its initial position
      doubleDamageEffect = true; // double damage effect is activated
      doubleDamageEffectTimer = millis(); // starts the double damage effect timer
      doubleDamageTimer = millis(); // resets the double damage boost appear timer
      updateDoubleDamageAppearAfterTimer(); // updates the double damage boost appear after timer
    } // collision is seen of double damage boost with player's spaceship

    if (millis() - doubleDmg.doubleDamageEffectTimer > 2000) {
      doubleDamageEffectTimer = 0; // resets the double damage boost appear time
      doubleDamageEffect = false; // double damage boost effect is now gone
    } // double damage effect goes away after 2 seconds
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Boosts Functions (Invincibility)
   ***
   **************************************/

  void invincibilityInitPos() {

    /*******************************************
     Initial Position of the Invincibility Boost
     *******************************************/

    /** Initial Coordinates (Invincibility) **/
    invincibilityX = int(random(width-700, width-200)); // sets the initial x invincibility boost position off the screen
    invincibilityY = -100; // sets the initial y invincibility boost position off the screen
  }

  void updateInvincibilityAfterTimer() {

    /**********************************************
     Updates Invincibility Boost Appear After Timer
     **********************************************/

    if (chapters == "Start") {
      invincibilityAppearAfter  = int(random(1500, 2000));
    } else if (chapters == "Carry on The Legacy") {
      invincibilityAppearAfter  = int(random(1100, 1300));
    } else {
      invincibilityAppearAfter  = int(random(500, 1000));
    }
  }

  void invincibilityAppear() {

    /**********************************************
     Makes the Invincibility Boost Appear On Screen
     **********************************************/

    invincibilityY+=invincibilitySpeed; // moves the invincibility boost down

    if (invincibilityY >= height) {
      invincibilityInitPos(); // shifts the invincibility boost back to its initial position
      invincibilityTimer = millis(); // resets the invincibility appear timer
      updateInvincibilityAfterTimer(); // updates the invincibility boost appear after timer
    } // invincibility boost disappears once it reaches the bottom

    invincibilityCollision(); // checks for invincibility boost's collision with player's spaceship
  }

  void invincibilityCollision() {

    /***************************************************************
     Checks for Invincibility Boost Collision with Player's Spaceship
     ***************************************************************/

    if (dist(invincibilityX, invincibilityY, player.playerSpaceshipX+110, player.playerSpaceshipY+125) <= 125) {
      invincibilityInitPos(); // shifts the invincibility boost to its initial position
      invincibilityEffect = true; // invincibility effect is activated
      invincibilityEffectTimer = millis(); // starts the invincibility effect timer
      invincibilityTimer = millis(); // resets the invincibility boost appear timer
      updateInvincibilityAfterTimer(); // updates the invincibility boost appear after timer
    } // collision is seen of invincibility boost with player's spaceship

    if (millis() - invincibilityEffectTimer > 2000) {
      invincibilityEffectTimer = 0; // resets the invincibility boost appear time
      invincibilityEffect = false; // invincibility boost effect is now gone
    } // invincibility effect goes away after 2 seconds
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Boosts Functions (Fueled)
   ***
   **************************************/

  void fuelInitPos() {

    /*******************************************
     Initial Position of the Fueled Boost
     *******************************************/

    /** Initial Coordinates (Fueled) **/
    fuelX = int(random(width-700, width-200)); // sets the initial x fuel boost position off the screen
    fuelY = -100; // sets the initial y fuel boost position off the screen
  }

  void updateFuelAfterTimer() {

    /**********************************************
     Updates Fueled Boost Appear After Timer
     **********************************************/

    if (chapters == "Start") {
      fuelAppearAfter  = int(random(1500, 2000));
    } else if (chapters == "Carry on The Legacy") {
      fuelAppearAfter  = int(random(1100, 1300));
    } else {
      fuelAppearAfter  = int(random(500, 1000));
    }
  }

  void fuelAppear() {

    /**********************************************
     Makes the Fueled Boost Appear On Screen
     **********************************************/

    fuelY+=fuelSpeed; // moves the fuel boost down

    if (fuelY >= height) {
      fuelInitPos(); // shifts the fuel boost back to its initial position
      fuelEffectTimer = millis(); // starts the fuel effect timer
      fuelTimer = millis(); // resets the fuel appear timer
      updateFuelAfterTimer(); // updates the fuel boost appear after timer
    } // fuel boost disappears once it reaches the bottom

    fuelCollision(); // checks for fuel boost's collision with player's spaceship
  }

  void fuelCollision() {

    /***************************************************************
     Checks for Fueled Boost Collision with Player's Spaceship
     ***************************************************************/

    if (dist(fuelX, fuelY, player.playerSpaceshipX+110, player.playerSpaceshipY+125) <= 125) {
      fuelInitPos(); // shifts the fuel boost to its initial position
      fuelEffectTimer = millis(); // starts the fuel effect timer
      fuelTimer = millis(); // resets the fuel boost appear timer
      updateFuelAfterTimer(); // updates the fuel boost appear after timer
      player.playerSpeed *= 2; // doubles the player speed
    } // collision is seen of fuel boost with player's spaceship

    if (millis() - fuelEffectTimer > 2000) {
      fuelEffectTimer = 0; // resets the fuel boost appear time
      player.playerSpeed = 1; // resets player speed to 1
    } // fuel effect goes away after 2 secondsw
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Boosts Functions (Health)
   ***
   **************************************/

  void healthInitPos() {

    /*******************************************
     Initial Position of the Extra Health Boost
     *******************************************/

    /** Initial Coordinates (Extra Health) **/
    healthX = int(random(width-700, width-200)); // sets the initial x health boost position off the screen
    healthY = -100; // sets the initial y health boost position off the screen
  }

  void updateHealthAfterTimer() {

    /**********************************************
     Updates Extra Health Boost Appear After Timer
     **********************************************/

    if (chapters == "Start") {
      healthAppearAfter  = int(random(1500, 2000));
    } else if (chapters == "Carry on The Legacy") {
      healthAppearAfter  = int(random(1100, 1300));
    } else {
      healthAppearAfter  = int(random(500, 1000));
    }
  }

  void healthAppear() {

    /**********************************************
     Makes the Extra Health Boost Appear On Screen
     **********************************************/

    healthY+=healthSpeed; // moves the health boost down

    if (healthY >= height) {
      healthInitPos(); // shifts the health boost back to its initial position
      healthTimer = millis(); // resets the health appear timer
      updateHealthAfterTimer(); // updates the health boost appear after timer
    } // health boost disappears once it reaches the bottom

    healthCollision(); // checks for health boost's collision with player's spaceship
  }

  void healthCollision() {

    /***************************************************************
     Checks for Extra Health Boost Collision with Player's Spaceship
     ***************************************************************/

    if (dist(healthX, healthY, player.playerSpaceshipX+110, player.playerSpaceshipY+125) <= 125) {
      healthInitPos(); // shifts the health boost to its initial position
      player.playerLifeLeft+=5; // increase player life left
      healthTimer = millis(); // resets the health boost appear timer
      updateHealthAfterTimer(); // updates the health boost appear after timer
    } // collision is seen of health boost with player's spaceship
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}
