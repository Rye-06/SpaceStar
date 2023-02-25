/** Game Name: SpaceStar
 * Developer: Rye
 **/

/****************************************
 ****
 Main Class
 ****
 ***************************************/

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 Global Variables
 ***
 **************************************/

/** Images in the Game **/
PImage playerSpaceship; // player's spaceship
PImage backgroundPic; // background image
PImage bulletPic; // bullet image
PImage enemySpaceship; // enemy's spaceship

/** X and Y Coordinates of the Player Spaceship **/
int playerSpaceshipX;
int playerSpaceshipY;

/** Y Coordinates of the Background **/
int backgroundY; // y axis of the background image

/** Screens and Chapters of the Game **/
String screens; // screens of the game
String chapters; // chapters of the game

/** Player Bullet Variables **/
int playerBulletX; // x position of the bullet
int playerBulletY; // y position of the bullet
float speed; // speed of the bullet
Bullet bullet = new Bullet(); // bullet object
PImage[] playerBullets; // bullet images
int playerCurrentBullets = 4; // current bullet

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 Setup of the Game
 ***
 **************************************/

void setup() {

  size(870, 680); // size of the window
  background(0); // color of the background

  /** Player's Spaceship **/
  playerSpaceship = loadImage("playerSpaceship.png"); // loads the player's spaceship
  playerSpaceship.resize(380, 260); // resizes the player's spaceship

  /** Enemy's Spaceship **/
  enemySpaceship = loadImage("enemySpaceship.png"); // loads the enemy's spaceship
  enemySpaceship.resize(250, 200); // resizes the enemy's spaceship

  /** Initial Coordinates of the Player's Spaceship **/
  playerSpaceshipX = width-600;
  playerSpaceshipY = height-250;

  /** Background of the Game **/
  backgroundPic = loadImage("background.png"); // loads the background image
  backgroundY = 0; // y coordinate of the background


  /** Bullet **/
  playerInitalBulletPos(); // sets initial bullet position

  playerBullets = new PImage[5]; // initializes player bullet array
  initPlayerBullets(); // fills the mag of bullets that are available to the player at a given time

  screens = "Home"; // sets the game state to the home screen
}

/************************************
 ***
 Main Draw Loop of the Game
 ***
 **************************************/

void draw() {

  backgroundStars(); // calls the background game screen function

  if (screens == "Play") {

    playScreen(); // calls play screen function

    speedBullet(); // bullet speed function
    playerBulletY += speed; // moves the bullet forward

    image(playerBullets[playerCurrentBullets], playerBulletX, playerBulletY); // places bullet image on screen

    /** Current Chapter Display **/
    textSize(20);
    text("Current Chapter: " + chapters, 5, 25);
  } // play screen ends
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 In game Screens Functions
 ***
 **************************************/


void backgroundStars() {

  /****************************************
   Background of the Game
   ***************************************/

  /** Background Image **/
  image(backgroundPic, 0, backgroundY);  // draws first background image on screen
  image(backgroundPic, 0, backgroundY-backgroundPic.height); // places second background image on screen

  backgroundY+=10; // scrolls through the background

  if (backgroundY >= backgroundPic.height) {
    backgroundY = 0;
  } // resets background once first image is fully moved through
}

void playScreen() {

  /****************************************
   Play Screen
   ***************************************/

  image(playerSpaceship, playerSpaceshipX, playerSpaceshipY); // draws the player's spaceship
  image(enemySpaceship, width-550, height-890); // draws the enemy's spaceship

  chapters = "The Start"; // the first chapter
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 Key Press/Mouse Press Functions
 ***
 **************************************/

void keyPressed() {

  /****************************************
   Performs Action Based on a Key Pressed
   ***************************************/

  if (key == 32 && screens == "Home") {
    screens = "Play";
  } // sets the screen to play with spacebar press from the home screen

  /** Reaches the Extreme End Flags **/

  boolean atRightEndFlag = false; // flag if the player's spaceship reaches off the the screen
  boolean atLeftEndFlag = false; // flag if the player's spaceship reaches off the the screen

  /** Detect if the Player's Spaceship is Moving Extremely Right or Left **/

  if (playerSpaceshipX >= width-380) {
    atRightEndFlag = true; // reaches the end flag is true
  } // if the player's spaceship goes extremely to the right off the screen
  else if (playerSpaceshipX <= 10) {
    atLeftEndFlag = true; // reaches the end flag is true
  } // if the player's spaceship goes extremely to the left off the screen

  /** Makes sure the Player's Spaceship doesn't go off the screen **/

  if (atRightEndFlag) {
    if (key == 'd' || key == 'D') {
      playerSpaceshipX +=0;
    } else if (key == 'a' || key == 'A') {
      playerSpaceshipX -=10;
    }
  } else if (atLeftEndFlag) {
    if (key == 'a' || key == 'A') {
      playerSpaceshipX -= 0;
    } else if (key == 'd' || key == 'D') {
      playerSpaceshipX +=10;
    }
  }

  /** ONLY If the Player's Spaceship is NOT Moving to the Extreme Right or Left **/
  /** Moves the Player's Spaceship Left and Right **/

  if (playerSpaceshipX < width-380 && playerSpaceshipX > 10 && atRightEndFlag == false && atRightEndFlag == false) {
    if (key == 'a' || key == 'A') {
      playerSpaceshipX -=10;
    } else if (key == 'd' || key == 'D') {
      playerSpaceshipX += 10;
    }
  }
}

void mousePressed() {

  /****************************************
   Performs Action Based on a Mouse Press
   ***************************************/

  if (mousePressed && screens  == "Play") {
    playerShootBullet(); // function to shoot the bullet
  } // shoots the bullet, only with mouse press, and in one of the play screens (or chapters)
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 Bullet Functions (Main Program)
 ***
 **************************************/

void initPlayerBullets() {

  /**********************************************
   Creates Bullet for the Player to use At a Time
   **********************************************/

  for (int fill = 0; fill < 5; fill++) {
    playerBullets[fill] = loadImage("playerBullet.png"); // fills the array with bullet images
    playerBullets[fill].resize(150, 150); // resizes the bullet image
  } // gives the player 5 bullets to fire
}

void playerInitalBulletPos() {

  /**********************************************
   Initial Bullet Coordinates of the Player
   **********************************************/

  bullet.initBulletPos(); // calls initial bullet position function

  /** Sets the X and Y Initial Coordinates of the Bullet **/
  playerBulletX = bullet.playerBulletPosX;
  playerBulletY = bullet.playerBulletPosY;

  /** Sets the Initial Bullet's Speed **/
  speed = bullet.bulletSpeed;
}

void speedBullet() {

  /**********************************************
   Moves the Bullet Forward
   **********************************************/

  speed--; // moves the bullet forward

  if (mousePressed) {
    speed = bullet.bulletSpeed;
  } // resets the speed of the bullet when a new one is shot
}

void playerShootBullet() {

  /**********************************************
   Shoots the Bullet from the Player's Spaceship
   **********************************************/

  bullet.shoot(); // calls the place x bullet function

  /** Sets the X and Y Coordinates of the Updated Position to Shoot the Bullet **/
  playerBulletX = bullet.playerBulletPosX; // updates the bullet x position to the new one
  playerBulletY = bullet.playerBulletPosY; // updates the bullet y position to the new one
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
