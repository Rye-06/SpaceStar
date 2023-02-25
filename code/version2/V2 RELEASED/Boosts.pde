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

  /** Extra Health **/
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

    if (dist(doubleDamageX, doubleDamageY, player.playerSpaceshipX+185, player.playerSpaceshipY+185) <= 170) {
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

    if (dist(invincibilityX, invincibilityY, player.playerSpaceshipX+185, player.playerSpaceshipY+185) <= 170) {
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
}
