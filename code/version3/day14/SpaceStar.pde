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

import processing.sound.*; // imports sounds library

/************************************
 ***
 Global Variables
 ***
 **************************************/

/** Images in the Game **/
PImage home; // home screen image
PImage blurredHome; // blurred home screen
PImage playerSpaceship; // player's spaceship
PImage enemySpaceship; // enemy's spaceship
PImage backgroundPic; // background image
PImage[] playerBullets; // bullet image array (player)
PImage[] enemyBullets; // bullet image array (enemy)
PImage playButton; // play button image
PImage homePlanet; // home planet's image
PImage doubleDamage; // double damage image
PImage invincibility; // invincibility image
PImage chapterPassed; // chapter passed image
PImage chapterFailed; // chapter failed image

/** Sounds **/
SoundFile mainGameSound; // main game sound
SoundFile playerBulletFire; // player bullet fire sound
SoundFile enemyLaserFire; // enemy laser sound

/** Home **/
boolean blurredHomeWanted; // checks to see if the blurred home screen is wanted or not

/** Home Planet **/
int homePlanetX; // home planet's x position
int homePlanetY; // home planet's y position

/** Player **/
Player player; // player object
boolean allowPlayerYMovement;

/** Boosts **/
Boosts doubleDmg; // boosts object- double damage
Boosts invincible; // boosts object- invincibility

/** Background **/
int backgroundY; // y axis of the background image

/** Screens and Chapters of the Game **/
String screens; // screens of the game
String chapters; // chapters of the game
boolean chapterChange; // chapter change is seen or not
String displayChapter; // the chapter to display

/** Player's Bullet **/
Bullet playerBullet; // bullet object (player)
int currentPlayerBullet; // current bullet being used by the player
int minPosPlayerBulletY; // minimum position the player's bullet must reach in order to fire the next one
int playerShootTime; // player shoot time after the play button is clicked

/** Enemy **/
Enemy enemy; // enemy object

/** Enemy's Bullet **/
Bullet enemyBullet; // bullet object (enemy)
int currentEnemyBullet; // current bullet being used by the enemy
int minPosEnemyBulletY; // minimum position the enemy's bullet must reach in order to fire the next one
int enemyCurShootTime; // current time to determine when to shoot the enemy bullet
boolean enemyReduceLife; // reduce life of enemy or not

/** Asteroid **/
Asteroid asteroidObj; // asteroid object
boolean asteroidDoDmg; // asteroids are or not allowed to do damage

/** Play Button **/
int playButtonX; // x coordinate of the button
int playButtonY; // y coordinate of the button
int playButtonW; // width of the button
int playButtonH; // height of the button

/** Fonts **/
PFont animated; // animated font
PFont regular; // regular font

/** Name Input **/
ArrayList<TextBox> textboxes = new ArrayList<TextBox>(); // array list of text boxes
boolean send;
String name = ""; // name of the player
public String finalName = ""; // final saved name

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 Setup of the Game
 ***
 **************************************/

void setup() {

  size(870, 680); // size of the window

  /** Loads Sounds **/
  mainGameSound  = new SoundFile(this, "mainGame.mp3");
  playerBulletFire = new SoundFile(this, "playerBulletFire.mp3");
  enemyLaserFire = new SoundFile(this, "enemyLaserFire.mp3");

  /** Home Screen **/
  home = loadImage("home.png"); // loads the home screen image
  blurredHome = loadImage("blurredHome.png"); // loads the blurred home screen image
  blurredHomeWanted = true; // blurred home is wanted

  /** Background of the Game **/
  backgroundPic = loadImage("background.png"); // loads the background image
  backgroundY = 0; // y coordinate of the background

  /** Home Planet **/
  homePlanet = loadImage("xenoa.png"); // loads home planet image
  homePlanet.resize(1500, 1000);
  homePlanetX = width-1200; // home planet x's initial position
  homePlanetY = -820; // home planet y's initial position

  /** Boosts **/
  doubleDamage = loadImage("doubleDamage.png"); // loads the double damage boost image
  doubleDamage.resize(50, 50); // resizes the double damage image
  doubleDmg = new Boosts(); // double damage object is initialized
  doubleDmg.doubleDamageInitPos(); // initial double damage boost position
  invincibility = loadImage("invincible.png"); // loads the invincibility boost image
  invincibility.resize(50, 50); // resizes the invincibility image
  invincible = new Boosts(); // invincibility object is initialized
  invincible.invincibilityInitPos(); // initial invincible boost position

  /** Player **/
  player = new Player(100, width-600, height-250);
  playerSpaceship = loadImage("playerSpaceship.png"); // loads the player's spaceship
  playerSpaceship.resize(380, 260); // resizes the player's spaceship
  allowPlayerYMovement = false; // player y movement isnt allowed

  /** Player's Bullet **/
  playerBullet = new Bullet(); // initializes the player bullet object
  playerBullet.playerInitBulletPos(); // sets the initial player bullet position
  currentPlayerBullet = 0; // current player bullet is 0 (first one)
  minPosPlayerBulletY = -500; // minimum position for player's bullet to reach before shooting a new one
  playerBullets = new PImage[6]; // initializes the bullet image array (player)
  playerBullet.playerCreateBullets(); // creates the bullets image array (player)

  /** Enemy **/
  enemy = new Enemy(100, width-545, height-655); // initializes the enemy object
  enemySpaceship = loadImage("enemySpaceship.png"); // loads the enemy's spaceship
  enemySpaceship.resize(250, 200); // resizes the enemy's spaceship

  /** Enemy's Bullet **/
  enemyBullet = new Bullet(); // initializes the enemy bullet object
  currentEnemyBullet = 0; // current player bullet is 0 (first one)
  minPosEnemyBulletY = 1180; // minimum position for enemy's bullet to reach before shooting a new one
  enemyBullets = new PImage[6]; // initializes the bullet image array (enemy)
  enemyBullet.enemyCreateBullets(); // creates the bullets image array (enemy)
  enemyCurShootTime = 0; // current enemy shoot time is set to 0
  enemyReduceLife = true; // allowed to reduce enemy's life

  /** Asteroid **/
  asteroidObj = new Asteroid(width-720, 5); // asteroid object is created
  asteroidObj.createAsteroids(); // creates asteroids
  asteroidObj.initAsteroidPos(); // function to randomly generate asteroid y values
  asteroidDoDmg = true; // asteroids are allowed to do damage
  
  /** Play Button **/
  playButton = loadImage("playButton.png"); // play button is loaded in
  playButton.resize(275, 55); // resizes the play button
  playButtonX = width-545; // x coordinate of the play button initialized
  playButtonY = height-250; // y coordinate of the play button initialized
  playButtonW = playButton.width; // width of the play button initialized
  playButtonH = playButton.height; // height of the play button initialized

  /** Load Fonts **/
  animated = createFont("minecraft.ttf", 30);
  regular = createFont("KURIERD.TTF", 30);

  /** Game States **/
  chapters = "Start"; // first chapter is set to "The Start"
  chapterChange = false; // no chapter change is seen
  chapterPassed = loadImage("chapterPassed.png"); // loads chapter passed image
  chapterPassed.resize(680, 530); // resizes chapter passed image
  chapterFailed = loadImage("chapterFailed.png"); // loads chapter failed image
  chapterFailed.resize(800, 650); // resizes chapter failed image

  /** Plays Main Game Sound **/
  mainGameSound.loop(); // loops main game sound

  /** Name Input **/
  textInitLayout(); // layout of the textbox
  send = false; // send is initially false
} // end setup


/************************************
 ***
 Main Draw Loop of the Game
 ***
 **************************************/

void draw() {

  textFont(regular); // regular font is selected

  if (screens == "Home" || screens == "Play") {
    backgroundStars(); // calls the background game screen function
  }
  if (blurredHomeWanted) {
    image(blurredHome, 0, 0); // places the blurred home screen

    /** Name Text **/
    textSize(50);
    fill(255);
    text("Enter Your Name: ", 150, (height/2)-100);
    for (TextBox t : textboxes) {
      t.DRAW();
    } // draws the textbox
  }

  if (screens == "Home") {
    home(); // calls home screen function
  } // home screen ends
  else if (screens == "Play") {
    playScreen(); // calls play screen function
  } // play screen ends
  else if (screens == "End") {
    if (chapters == "The Final One") {
      gameOver(); // game over screen function is called
    } else {
      displayChapter = chapters; // display chapter is set to the current chapter
      endGame(); // end game function is called
    }
  }// end screen ends
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 In game Screens Functions
 ***
 **************************************/

void home() {

  /****************************************
   Home Screen
   ***************************************/

  image(home, 0, 0); // loads home screen image

  /** Name Display **/
  textSize(18);
  text("Player: " + finalName, width-865, height-625);

  image(playButton, playButtonX, playButtonY);

  if (send) {
    text(name, (width - textWidth(name)) / 2, 260);
  }

  if (mousePressed) {
    if (mouseX>playButtonX && mouseX <playButtonX+playButtonW && mouseY>playButtonY && mouseY <playButtonY+playButtonH) {
      playerShootTime = millis(); // player shoot time starts measuring the time
      enemyCurShootTime = millis(); // enemy shoot time starts measuring the time
      doubleDmg.doubleDamageTimer = millis(); // starts the double damage appear timer
      invincible.invincibilityTimer  = millis(); // starts the invincibility appear timer
      screens = "Play"; // changes game state
    }
  } // play button is clicked

  /** Current Chapter Display **/
  text("Current Chapter: " + chapters, width-865, height-655);
}

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

  /** Current Chapter Display **/
  textSize(18);
  text("Current Chapter: " + chapters, width-865, height-655);

  /** Name Display **/
  text("Player: " + finalName, width-865, height-625);

  enemy.updateEnemyMovementX(); // updates the enemy movement x value

  /** Generate Player and Enemy Spaceships **/
  image(playerSpaceship, player.playerSpaceshipX, player.playerSpaceshipY); // draws the player's spaceship
  image(enemySpaceship, enemy.enemySpaceshipX, enemy.enemySpaceshipY); // draws the enemy's spaceship

  /** Boosts **/

  image(doubleDamage, doubleDmg.doubleDamageX, doubleDmg.doubleDamageY); // places the double damage boost on the screen

  doubleDmg.updateDoubleDamageAppearAfterTimer(); // updates the double damage boost appear after timer

  if (millis() - doubleDmg.doubleDamageTimer > doubleDmg.doubleDamageAppearAfter) {
    doubleDmg.doubleDamageAppear(); // makes the double damage boost appear
  } // places the double damage boost on the screen after random regular intervals

  image(invincibility, invincible.invincibilityX, invincible.invincibilityY); // places the invincibility boost on the screen

  invincible.updateInvincibilityAfterTimer(); // updates the invincibility boost appear after timer

  if (millis() - invincible.invincibilityTimer > invincible.invincibilityAppearAfter) {
    invincible.invincibilityAppear(); // makes the invincibility boost appear
  } // places the invincibility boost on the screen after random regular intervals

  /** Home Planet **/
  image(homePlanet, homePlanetX, homePlanetY); // places home planet on the screen
  if (allowPlayerYMovement && homePlanetY <= height-1150) {
    homePlanetY+=2;
  } // brings the home planet on the screen

  enemy.moveEnemySpaceship(); // calls the function to move the enemy spaceship

  /** Asteroids **/
  asteroidObj.asteroidMechanics(); // mechanics of the asteroid

  if (currentPlayerBullet < 6) {

    /** Moves the Player's Bullet **/
    playerBullet.playerSpeedBullet(); // bullet speed function (player)

    image(playerBullets[currentPlayerBullet], playerBullet.playerBulletPosX, playerBullet.playerBulletPosY); // places bullet image on screen (player)

    playerBullet.playerBulletCollide(); // function to see if player's bullet collides with the enemy's spaceship
  }// stop firing once mag has finished

  /** Player Life Left **/
  if (player.playerLifeLeft > 0) {
    textSize(14);
    fill(255);
    text("Player Life Left: " + player.playerLifeLeft, width-860, height-50);
  } // player is alive
  else {
    screens = "End"; // screen is changed to the end
  } // player has died

  enemyBullet.updateEnemyShootTime(); // updates the enemy shoot time

  if ((millis() - enemyCurShootTime > enemyBullet.enemyShootTime) && (player.playerLifeLeft > 0) && (enemy.enemyLifeLeft > 0)) {

    enemyBullet.enemyShoot(); // calls the shoot bullet function

    image(enemyBullets[currentEnemyBullet], enemyBullet.enemyBulletPosX, enemyBullet.enemyBulletPosY); // places bullet image on screen (enemy)

    enemyLaserFire.play(); // plays enemy laser firing sound

    enemyBullet.enemyBulletCollide(); // function to see if enemy's bullet collides with the player's spaceship

    currentEnemyBullet++; // increments the current bullet being used to the next one

    if (currentEnemyBullet == 4) {
      currentEnemyBullet = 0; // resets enemy laser
    } // reloads enemy laser

    enemyCurShootTime = millis(); // updates enemy shoot time
  } // shoot the enemy bullet after 1 second

  /** Enemy Life Left **/
  if (enemy.enemyLifeLeft > 0) {
    textSize(14);
    fill(255);
    text("Enemy Life Left: " + enemy.enemyLifeLeft, width-180, height-655);
  } // enemy is alive
  else {
    if (chapters == "Start" || chapters == "Carry on The Legacy") {
      screens = "End"; // screen is changed to end
    } else {
      textSize(17);
      text("Use Keys W and S\nto Move Towards the\nHomeplanet- Xenoa!", width-820, height-350);  // instructions text
      enemy.enemySpaceshipY = -500; // moves the enemy spaceship off the screen
      allowPlayerYMovement = true; // player y movement is allowed
      asteroidDoDmg = false; // asteroids are not allowed to do damage
    }
  } // enemy has died
}


void resetElements() {

  /********************************************
   Resets the Elements of the Game
   ********************************************/

  player.playerLifeLeft = 100;
  enemy.enemyLifeLeft = 100;
  enemy.enemySpaceshipX = width-545;
  enemy.enemySpaceshipY =  height-655;
  player.playerSpaceshipX = width-600;
  player. playerSpaceshipY =  height-250;
  playerBullet.playerBulletPosY = -50;
  asteroidDoDmg = true; // asteroids are allowed to do damage
  doubleDmg.doubleDamageInitPos(); // double damge boost is redirected to its orignal position
  invincible.invincibilityInitPos(); // invincibility boost is redirected to its orignal position
  chapterChange = true; // chapter change is seen
  if (chapters == "Start") {
    chapters = "Carry on The Legacy"; // chapter changed to carry on the legacy
  } else if (chapters == "Carry on The Legacy") {
    chapters = "The Final One"; // chapter changed to the final one
  }

  screens = "Home"; // screen is changed back to home
}

void endGame() {

  /****************************************************
   Function for the End Screen(s)
   ****************************************************/

  /** Overrides the Previous Background Images **/
  image(backgroundPic, 0, backgroundY);  // draws the new first background image on screen
  image(backgroundPic, 0, backgroundY-backgroundPic.height); // places the new second background image on screen

  backgroundY+=8; // scrolls through the new background

  if (backgroundY >= backgroundPic.height) {
    backgroundY = 0;
  } // resets the new background once first image is fully moved through

  if (player.playerLifeLeft > 0) {
    image(chapterPassed, width-750, height-680); // places chapter passed image on screen
    textFont(animated); // animated font is selected
    textSize(30);
    text("Press C to Continue\n\nN to Play a New Game", width-550, height-200); // continue text
    if (key == 'C' || key == 'c') {
      resetElements(); // calls the function to reset the elements of the game
    } // continue game key is clicked
    else if (key == 'N' || key == 'n') {
      resetElements(); // calls the function to reset the elements of the game
      chapters = "Start"; // chapter is changed
    } // new game key is clicked
    textSize(35);
    if (chapters == "Start") {
      text(displayChapter.toUpperCase(), width-485, height-410);
    } else {
      text(displayChapter.toUpperCase(), width-630, height-420);
    } // shows passed chapter text on the screen
  } else {
    image(chapterFailed, width-810, height-660);  // places chapter failed image on screen
    textFont(animated); // animated font is selected
    textSize(30);
    text("Press N to Play a New Game", width-620, height-180); // new game text
    if (key == 'N' || key == 'n') {
      resetElements(); // calls the function to reset the elements of the game
      chapters = "Start"; // chapter is changed
    } // new game key is clicked
    textSize(40);
    if (chapters == "Start") {
      text(displayChapter.toUpperCase(), width-500, height-370);
    } else if (chapters == "Carry on The Legacy") {
      text(displayChapter.toUpperCase(), width-660, height-370);
    } else {
      text(displayChapter.toUpperCase(), width-600, height-370);
    }// shows failed chapter text on the screen
  }
}

void gameOver() {

  /****************************************************
   Function for the Game Over Screen
   ****************************************************/

  background(0);
  textSize(30);
  text("YOU FINISHED THE GAME! GOOD JOB", width-700, height-400); // game finished text
  text("Press E to Exit or N to Play a New Game", width-740, height-200); // exit or not text
  if (key == 'N' || key== 'n') {
    resetElements(); // elements of the game are reset
    chapters = "Start"; // chapter is changed back to start
  } // new game
  else if (key == 'E' || key == 'e') {
    exit(); // exits the game
  } // exit the game
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
   Performs Action Based on a Key Press
   ***************************************/

  /** Name Input **/
  for (TextBox t : textboxes) {
    if (t.KEYPRESSED(key, keyCode)) {
      send = true;
      name = "Message is: " + textboxes.get(1).name;
    }
  } // records the key pressed in the textbox

  /** Reaches the Extreme End Flags **/

  boolean atRightEndFlag = false; // flag if the player's spaceship reaches off the the screen
  boolean atLeftEndFlag = false; // flag if the player's spaceship reaches off the the screen
  boolean atUpFlag = false; // flag if the player's spaceship reaches off the the screen
  boolean atDownFlag = false; // flag if the player's spaceship reaches off the the screen

  /** Detect if the Player's Spaceship is Moving Extremely Right or Left **/
  if (player.playerSpaceshipX >= width-380) {
    atRightEndFlag = true; // reaches the right end
  } // if the player's spaceship goes extremely to the right off the screen
  else if (player.playerSpaceshipX <= 10) {
    atLeftEndFlag = true; // reaches the left end
  } // if the player's spaceship goes extremely to the left off the screen

  /** Makes sure the Player's Spaceship doesn't go off the screen **/
  if (atRightEndFlag) {
    if (key == 'd' || key == 'D') {
      player.playerSpaceshipX +=0;
    } else if (key == 'a' || key == 'A') {
      player.playerSpaceshipX -=10;
    }
  } else if (atLeftEndFlag) {
    if (key == 'a' || key == 'A') {
      player.playerSpaceshipX -= 0;
    } else if (key == 'd' || key == 'D') {
      player.playerSpaceshipX +=10;
    }
  }

  /** ONLY If the Player's Spaceship is NOT Moving to the Extreme Right or Left **/
  /** Moves the Player's Spaceship Left and Right **/

  if (player.playerSpaceshipX < width-380 && player.playerSpaceshipX > 10 && !atRightEndFlag && !atRightEndFlag) {
    if (key == 'a' || key == 'A') {
      player.playerSpaceshipX -=10;
    } else if (key == 'd' || key == 'D') {
      player.playerSpaceshipX += 10;
    }
  }

  /** Detect if the Player's Spaceship is Moving Extremely Right or Left **/
  if (player.playerSpaceshipY+30 <= 0) {
    atUpFlag = true; // reaches the top
  } // if the player's spaceship goes extremely to the top off the screen
  else if (player.playerSpaceshipY+200 >= height) {
    atDownFlag = true; // reaches the bottom
  } // if the player's spaceship goes extremely to the bottom off the screen

  /** Detect if the Player's Spaceship is Moving Extremely Up or Down **/
  if (atUpFlag) {
    if (key == 'w' || key == 'W') {
      player.playerSpaceshipY -=0;
    } else if (key == 's' || key == 'S') {
      player.playerSpaceshipY +=10;
    }
  } else if (atDownFlag) {
    if (key == 'w' || key == 'W') {
      player.playerSpaceshipY -= 10;
    } else if (key == 's' || key == 'S') {
      player.playerSpaceshipY +=0;
    }
  }

  /** ONLY If the Player's Spaceship is Allowed to Move Along the Y-Axis **/
  /** Moves the Player's Spaceship Up and Down **/

  if (allowPlayerYMovement && !atUpFlag && !atDownFlag) {
    if (key == 'w' || key == 'W') {
      player.playerSpaceshipY -=10;
    } else if (key == 's' || key == 'S') {
      player.playerSpaceshipY += 10;
    }
  }

  /** Move to Game Over Screen **/
  if (dist(homePlanetX+700, homePlanetY+735, player.playerSpaceshipX+170, player.playerSpaceshipY+70) <= 185) {
    homePlanetY = -820; // home planet is shifted off the screen
    allowPlayerYMovement = false; // player y movement isnt allowed
    screens = "End"; // changes game state
  }
}

void mouseReleased() {

  /****************************************
   Performs Action Based on Mouse Release
   ***************************************/

  for (TextBox t : textboxes) {
    t.pressed(mouseX, mouseY);
  } // records if the textbox region is pressed with the mouse

  if (screens == "Play") {
    if (millis() - playerShootTime > 1000) {
      if (enemy.enemyLifeLeft > 0 && player.playerLifeLeft > 0) {
        playerBullet.playerShootBullet(); // function to shoot the player's bullet
        playerBulletFire.play(); // plays player's bullet fire sound
      } // shoot only if player and enemy life left are greater than 0
    } // fires the player's bullet only after 1 second of the play button being clicked
  } // shoots the bullet, only with mouse press, and in one of the play screens (or chapters)
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 TextBox Functions
 ***
 **************************************/

void textInitLayout() {

  /****************************************
   Layout of the TextBox
   ***************************************/

  /** Layout of the TextBox **/

  TextBox receiver = new TextBox();
  receiver.W = width-300;
  receiver.H = height-620;
  receiver.X = (width - receiver.W)/2;
  receiver.Y = (height/2)-50;
  textboxes.add(receiver);
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

// END MAIN PROGRAM
