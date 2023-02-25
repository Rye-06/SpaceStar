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
PImage backgroundPic; // background image
PImage home; // home screen image
PImage blurredHome; // blurred home screen
PImage playerSpaceship; // player's spaceship
PImage enemySpaceship; // enemy's spaceship
PImage[] playerBullets; // bullet image array (player)
PImage[] enemyBullets; // bullet image array (enemy)
PImage playButton; // play button image
PImage homePlanet; // home planet's image
PImage doubleDamage; // double damage boost image
PImage invincibility; // invincibility boost image
PImage fuelImg; // fuel boost image
PImage healthImg; // health boost image
PImage chapterPassed; // chapter passed image
PImage chapterFailed; // chapter failed image
PImage gameOver; // game over image
PImage gameOverPlayer; // game over player's spaceship
PImage helpBtn; // help button
PImage backHomeBtn; // back home button
PImage helpScreen; // help screen image
PImage cutscene1; // cutscene 1 image
PImage cutscene2; // cutscene 2 image
PImage continueBtn; // continue button

/** Sounds **/
SoundFile mainGameSound; // main game sound
SoundFile playerBulletFire; // player bullet fire sound
SoundFile enemyLaserFire; // enemy laser sound
SoundFile death; // death of player sound

/** Home **/
boolean blurredHomeWanted; // checks to see if the blurred home screen is wanted or not

/** Home Planet **/
int homePlanetX; // home planet's x position
int homePlanetY; // home planet's y position

/** Player **/
Player player; // player object
boolean allowPlayerYMovementPlanet; // movement of the player when the planet is present

/** Boosts **/
Boosts doubleDmg; // boosts object- double damage
Boosts invincible; // boosts object- invincibility
Boosts fuel; // boosts object- added speed fuel
Boosts health; // boosts object- extra health

/** Background **/
int backgroundY; // y axis of the background image

/** Screens and Chapters of the Game **/
String screens; // screens of the game
String chapters; // chapters of the game
boolean win; // player has won or not
boolean newGame; // new game key is clicked

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
boolean obstacleDoDmg; // obstacles are or not allowed to do damage

/** Meteor **/
Meteor meteor; // meteor object

/** Play Button **/
int playButtonX; // x coordinate of the button
int playButtonY; // y coordinate of the button
int playButtonW; // width of the button
int playButtonH; // height of the button

/** Help Button **/
int helpBtnX; // x coordinate of the button
int helpBtnY; // y coordinate of the button
int helpBtnW; // width of the button
int helpBtnH; // height of the button

/** Back Home Button **/
int backHomeBtnX; // x coordinate of the button
int backHomeBtnY; // y coordinate of the button
int backHomeBtnW; // width of the button
int backHomeBtnH; // height of the button

/** Continue Button **/
int continueBtnX; // x coordinate of the button
int continueBtnY; // y coordinate of the button
int continueBtnW; // width of the button
int continueBtnH; // height of the button

/** Time Taken **/
int startTimer; // start timer
int levelTimer; // level timer
int totalTimer; // total levels timer
boolean updateTime; // to update time or not

/** Fonts **/
PFont animated; // animated font
PFont regular; // regular font

/** Name Input **/
ArrayList<TextBox> textboxes = new ArrayList<TextBox>(); // array list of text boxes
boolean send;
String name = ""; // name of the player
public String finalName = ""; // final saved name

/** Health Bar **/
float maxHealth = 100;
float rectWidth = 200;

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
  //mainGameSound  = new SoundFile(this, "mainGame.mp3");
  //playerBulletFire = new SoundFile(this, "playerBulletFire.mp3");
  //enemyLaserFire = new SoundFile(this, "enemyLaserFire.mp3");
  //death = new SoundFile(this, "death.mp3");

  /** Background of the Game **/
  backgroundPic = loadImage("background.png"); // loads the background image
  backgroundY = 0; // y coordinate of the background

  /** Home Planet **/
  homePlanet = loadImage("xenoa.png"); // loads home planet image
  homePlanet.resize(1500, 1000);
  homePlanetX = width-1200; // home planet x's initial position
  homePlanetY = -820; // home planet y's initial position

  /** Player **/
  player = new Player(100, width-600, height-195, 1);
  playerSpaceship = loadImage("playerSpaceship.png"); // loads the player's spaceship
  playerSpaceship.resize(300, 200); // resizes the player's spaceship
  allowPlayerYMovementPlanet = false; // player y movement for the planet isnt allowed

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
  enemySpaceship.resize(200, 150); // resizes the enemy's spaceship

  /** Enemy's Bullet **/
  enemyBullet = new Bullet(); // initializes the enemy bullet object
  currentEnemyBullet = 0; // current player bullet is 0 (first one)
  minPosEnemyBulletY = 1180; // minimum position for enemy's bullet to reach before shooting a new one
  enemyBullets = new PImage[6]; // initializes the bullet image array (enemy)
  enemyBullet.enemyCreateBullets(); // creates the bullets image array (enemy)
  enemyCurShootTime = 0; // current enemy shoot time is set to 0
  enemyReduceLife = true; // allowed to reduce enemy's life

  /** Asteroid **/
  asteroidObj = new Asteroid(5); // asteroid object is created
  asteroidObj.createAsteroids(); // creates asteroids
  asteroidObj.initAsteroidPos(); // function to randomly generate asteroid y values
  obstacleDoDmg = true; // obstacles are allowed to do damage

  /** Meteor **/
  meteor = new Meteor(5); // meteor object is created
  meteor.createMeteors(); // creates meteors
  meteor.initMeteorPos(); // function to randomly generate meteor y values

  /** Play Button **/
  playButton = loadImage("playButton.png"); // play button is loaded in
  playButton.resize(275, 55); // resizes the play button
  playButtonX = width-545; // x coordinate of the play button initialized
  playButtonY = height-250; // y coordinate of the play button initialized
  playButtonW = playButton.width; // width of the play button initialized
  playButtonH = playButton.height; // height of the play button initialized

  /** Help Button **/
  helpBtn = loadImage("helpBtn.png"); // help button is loaded in
  helpBtn.resize(170, 40); // resizes the help button
  helpBtnX = width-485; // x coordinate of the help button initialized
  helpBtnY = height-175; // y coordinate of the help button initialized
  helpBtnW = helpBtn.width; // width of the help button initialized
  helpBtnH = helpBtn.height; // height of the help button initialized

  /** Back Home Button **/
  backHomeBtn = loadImage("backHomeBtn.png"); // back home button is loaded in
  backHomeBtn.resize(265, 55); // resizes the back home button
  backHomeBtnX = width-550; // x coordinate of the back home button initialized
  backHomeBtnY = height-75; // y coordinate of the back home button initialized
  backHomeBtnW = backHomeBtn.width; // width of the back home button initialized
  backHomeBtnH = backHomeBtn.height; // height of the back home button initialized

  /** Continue Button **/
  continueBtn = loadImage("continueBtn.png"); // continue button is loaded in
  continueBtn.resize(185, 45); // resizes the continue button
  continueBtnX = width-195; // x coordinate of the continue button initialized
  continueBtnY = height-75; // y coordinate of the continue button initialized
  continueBtnW = continueBtn.width; // width of the continue button initialized
  continueBtnH = continueBtn.height; // height of the continue button initialized

  /** Load Fonts **/
  animated = createFont("minecraft.ttf", 30);
  regular = createFont("KURIERD.TTF", 30);

  /** Game States **/
  home = loadImage("home.png"); // loads the home screen image
  blurredHome = loadImage("blurredHome.png"); // loads the blurred home screen image
  blurredHomeWanted = true; // blurred home is wanted
  chapters = "Start"; // first chapter is set to "The Start"
  chapterPassed = loadImage("chapterPassed.png"); // loads chapter passed image
  chapterPassed.resize(680, 530); // resizes chapter passed image
  chapterFailed = loadImage("chapterFailed.png"); // loads chapter failed image
  chapterFailed.resize(800, 650); // resizes chapter failed image
  helpScreen = loadImage("helpScreen.png"); // loads help screen image
  gameOver = loadImage("gameOver.png"); // loads game over image
  gameOverPlayer = loadImage("playerSpaceship.png"); // loads game over player spaceship
  gameOverPlayer.resize(200, 150); // resizes the game over player's spaceship
  win = false; // player hasnt won yet
  newGame = false;  // no new game is seen

  /** Boosts **/
  doubleDamage = loadImage("doubleDamage.png"); // loads the double damage boost image
  doubleDamage.resize(50, 50); // resizes the double damage image
  doubleDmg = new Boosts(); // double damage object is initialized
  doubleDmg.doubleDamageInitPos(); // initial double damage boost position
  doubleDmg.updateDoubleDamageAppearAfterTimer(); // updates the double damage boost appear after timer
  invincibility = loadImage("invincible.png"); // loads the invincibility boost image
  invincibility.resize(60, 60); // resizes the invincibility image
  invincible = new Boosts(); // invincibility object is initialized
  invincible.invincibilityInitPos(); // initial invincible boost position
  invincible.updateInvincibilityAfterTimer(); // updates the invincibility boost appear after timer
  healthImg = loadImage("health.png"); // loads the health boost image
  healthImg.resize(50, 50); // resizes the health image
  health = new Boosts(); // health object is initialized
  health.healthInitPos(); // initial health boost position
  health.updateHealthAfterTimer(); // updates the health boost appear after timer
  fuelImg = loadImage("fuel.png"); // loads the fuel boost image
  fuelImg.resize(50, 50); // resizes the fuel image
  fuel = new Boosts(); // fuel object is initialized
  fuel.fuelInitPos(); // initial fuel boost position
  fuel.updateFuelAfterTimer(); // updates the fuel boost appear after timer

  /** Cutscenes **/
  cutscene1 = loadImage("cutscene1.png");
  cutscene2 = loadImage("cutscene2.png");

  /** Plays Main Game Sound **/
  //mainGameSound.loop(); // loops main game sound

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

  /** Global Regular Font and Color **/
  textFont(regular); // regular font is selected
  fill(255); // white color is selected

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

  /** Game States/Screens **/
  if (screens == "Home") {
    home(); // calls home screen function
  } // home screen ends
  else if (screens == "Play") {
    playScreen(); // calls play screen function
  } // play screen ends
  else if (screens == "Help") {
    helpScreen(); // calls help screen function
  } // help screen ends
  else if (screens == "End") {
    if (player.playerLifeLeft > 0 && chapters == "The Final One") {
      gameOver(); // game over function is called
    } else {
      endGame(); // end game function is called
    }
  } // end screen ends
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

  /** Home Screen Image **/
  image(home, 0, 0);

  if (newGame) {
    chapters = "Start"; // chapters is start
    newGame = false; // no new game is seen
  } // new game is seen

  if (win) {
    if (chapters == "Start") {
      chapters = "Carry on The Legacy"; // chapter changed to carry on the legacy
      win = false; // win is now false
    } else if (chapters == "Carry on The Legacy") {
      chapters = "The Final One"; // chapter changed to the final one
      win = false; // win is now false
    }
  } // if the player has won a round

  /** Name Display **/
  textSize(18);
  text("Player: " + finalName, width-865, height-625);

  /** Buttons **/
  image(playButton, playButtonX, playButtonY);
  image(helpBtn, helpBtnX, helpBtnY);

  if (send) {
    text(name, (width - textWidth(name)) / 2, 260);
  }

  /** Button is Clicked **/
  if (mousePressed) {
    if (mouseX>playButtonX && mouseX <playButtonX+playButtonW && mouseY>playButtonY && mouseY <playButtonY+playButtonH) {
      playerShootTime = millis(); // player shoot time starts measuring the time
      enemyCurShootTime = millis(); // enemy shoot time starts measuring the time
      doubleDmg.doubleDamageTimer = millis(); // starts the double damage appear timer
      invincible.invincibilityTimer  = millis(); // starts the invincibility appear timer
      startTimer = millis(); // start timer is started
      updateTime = true; // update the time
      screens = "Play"; // changes game state
    } // play button is clicked
    else  if (mouseX>helpBtnX && mouseX <helpBtnX+helpBtnW && mouseY>helpBtnY && mouseY <helpBtnY+helpBtnH) {
      screens = "Help"; // changes game state
    } // help button is clicked
  }

  /** Current Chapter Display **/
  text("Current Chapter: " + chapters, width-865, height-655);
}

void helpScreen() {

  /****************************************
   Help Screen
   ***************************************/

  /** Help Screen Image **/
  image(helpScreen, 0, 0);

  /** Back Home Button **/
  image(backHomeBtn, backHomeBtnX, backHomeBtnY);

  /** Back Home Button is Clicked **/
  if (mousePressed) {
    if (mouseX>backHomeBtnX && mouseX <backHomeBtnX+backHomeBtnW && mouseY>backHomeBtnY && mouseY <backHomeBtnY+backHomeBtnH) {
      screens = "Home"; // changes game state
    }
  }
}

void backgroundStars() {

  /****************************************
   Background of the Game
   ***************************************/

  /** Background Image **/
  image(backgroundPic, 0, backgroundY);  // draws first background image on screen
  image(backgroundPic, 0, backgroundY-backgroundPic.height); // places second background image on screen
  backgroundY+=10; // scrolls through the backgrounds

  /** Resets Background Once First Image is Fully Moved Through **/
  if (backgroundY >= backgroundPic.height) {
    backgroundY = 0;
  }
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

  /** Player Spaceship **/
  image(playerSpaceship, player.playerSpaceshipX, player.playerSpaceshipY);

  /** Enemy Spaceship **/
  enemy.updateEnemyMovementX(); // updates the enemy movement x value
  image(enemySpaceship, enemy.enemySpaceshipX, enemy.enemySpaceshipY);
  enemy.moveEnemySpaceship(); // calls the function to move the enemy spaceship

  /** Boosts **/

  /* Double Damage Boost */
  image(doubleDamage, doubleDmg.doubleDamageX, doubleDmg.doubleDamageY);
  if (millis() - doubleDmg.doubleDamageTimer > doubleDmg.doubleDamageAppearAfter) {
    doubleDmg.doubleDamageAppear(); // makes the double damage boost appear
  } // performs this action after random intervals

  /* Invincibility Boost */
  image(invincibility, invincible.invincibilityX, invincible.invincibilityY);
  if (millis() - invincible.invincibilityTimer > invincible.invincibilityAppearAfter) {
    invincible.invincibilityAppear(); // makes the invincibility boost appear
  } // places the invincibility boost on the screen after random regular intervals

  /* Fuel Boost */
  image(fuelImg, fuel.fuelX, fuel.fuelY);
  if (millis() - fuel.fuelTimer > fuel.fuelAppearAfter) {
    fuel.fuelAppear(); // makes the fuel boost appear
  } // places the fuel boost on the screen after random regular intervals

  /* Health Boost */
  image(healthImg, health.healthX, health.healthY);
  if (millis() - health.healthTimer > health.healthAppearAfter) {
    health.healthAppear(); // makes the health boost appear
  } // places the health boost on the screen after random regular intervals

  /** Home Planet **/
  image(homePlanet, homePlanetX, homePlanetY);
  if (allowPlayerYMovementPlanet && homePlanetY <= height-1150) {
    homePlanetY+=2;
  } // brings the home planet on the screen

  /** Asteroids **/
  asteroidObj.asteroidMechanics(); // mechanics of the asteroid

  /** Meteors **/
  meteor.meteorMechanics(); // mechanics of the meteor

  if (currentPlayerBullet < 6) {

    /** Moves the Player's Bullet **/
    playerBullet.playerSpeedBullet(); // bullet speed function (player)

    image(playerBullets[currentPlayerBullet], playerBullet.playerBulletPosX, playerBullet.playerBulletPosY); // places bullet image on screen (player)

    playerBullet.playerBulletCollide(); // function to see if player's bullet collides with the enemy's spaceship
  }// stop firing once mag has finished

  /** Player Life Left **/
  if (player.playerLifeLeft > 0) {
    /** Player's Health Bar **/
    text("Player", width-860, height-60);
    if (player.playerLifeLeft < 25)
    {
      fill(255, 0, 0);
    } else if (player.playerLifeLeft < 50)
    {
      fill(255, 200, 0);
    } else
    {
      fill(0, 255, 0);
    }
    /* Draws The Health Bar */
    noStroke();
    float drawWidth = (player.playerLifeLeft / maxHealth) * rectWidth;
    rect(width-860, height-50, drawWidth, 30);

    /* Outline of The Health Bar */
    stroke(255);
    strokeWeight(5);
    noFill();
    rect(width-860, height-50, rectWidth, 30);
  } // player is alive
  else {
    //death.play(); // plays death of player sound
    screens = "End"; // changes game state
  } // player has died

  /** Enemy Firing **/

  enemyBullet.updateEnemyShootTime(); // updates the enemy shoot time

  if ((millis() - enemyCurShootTime > enemyBullet.enemyShootTime) && (player.playerLifeLeft > 0) && (enemy.enemyLifeLeft > 0)) {

    enemyBullet.enemyShoot(); // calls the shoot bullet function

    image(enemyBullets[currentEnemyBullet], enemyBullet.enemyBulletPosX, enemyBullet.enemyBulletPosY); // places bullet image on screen (enemy)

    //enemyLaserFire.play(); // plays enemy laser firing sound

    enemyBullet.enemyBulletCollide(); // function to see if enemy's bullet collides with the player's spaceship

    currentEnemyBullet++; // increments the current bullet being used to the next one

    if (currentEnemyBullet == 4) {
      currentEnemyBullet = 0; // resets enemy laser ammo
    } // reloads enemy's lasers

    enemyCurShootTime = millis(); // updates enemy shoot time
  } // shoot the enemy bullet after 1 second

  /** Enemy Life Left **/

  if (enemy.enemyLifeLeft > 0) {
    if (player.playerLifeLeft > 0) {
      /** Enemy's Health Bar **/
      fill(255);
      text("Enemy", width-205, height-640);
      if (enemy.enemyLifeLeft < 25) {
        fill(255, 0, 0);
      } else if (enemy.enemyLifeLeft < 50) {
        fill(255, 200, 0);
      } else {
        fill(0, 255, 0);
      }
      /* Draws The Health Bar */
      noStroke();
      float drawWidth = (enemy.enemyLifeLeft / maxHealth) * rectWidth;
      rect(width-205, height-630, drawWidth, 30);

      /* Outline of The Health Bar */
      stroke(255);
      strokeWeight(5);
      noFill();
      rect(width-205, height-630, rectWidth, 30);
    }
  } // enemy is alive
  else {
    if (updateTime) {
      levelTimer = millis() - startTimer; // level timer is updated
      totalTimer += millis() - startTimer; // total time is updated
      updateTime = false; // dont update time now
    } // updates timers
    if (chapters == "Start" || chapters == "Carry on The Legacy") {
      if (chapters == "Start") {
        enemy.enemySpaceshipY = -500; // moves the enemy spaceship off the screen
        image(cutscene1, player.playerSpaceshipX-130, player.playerSpaceshipY-220); // cutscene 1 image
      } else {
        enemy.enemySpaceshipY = -500; // moves the enemy spaceship off the screen
        image(cutscene2, player.playerSpaceshipX-130, player.playerSpaceshipY-220); // cutscene 2 image
      }
      obstacleDoDmg = false; // obstacles cant do damage
      image(continueBtn, continueBtnX, continueBtnY); // continue button on screen
      /** Continue Button is Clicked **/
      if (mousePressed) {
        if (mouseX>continueBtnX && mouseX <continueBtnX+continueBtnW && mouseY>continueBtnY && mouseY <continueBtnY+continueBtnH) {
          screens = "End"; // changes game state
        }
      }
    } else {
      textSize(17);
      fill(255);
      text("Use Keys W and S\nto Move Towards the\nHomeplanet- Xenoa!", width-820, height-350);  // instructions text
      enemy.enemySpaceshipY = -500; // moves the enemy spaceship off the screen
      allowPlayerYMovementPlanet = true; // player y movement for the planet is allowed
      obstacleDoDmg = false; // obstacles are not allowed to do damage
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
  player. playerSpaceshipY =  height-195;
  playerBullet.playerBulletPosY = -50;
  obstacleDoDmg = true; // obstacles are allowed to do damage
  doubleDmg.doubleDamageInitPos(); // double damge boost is redirected to its orignal position
  invincible.invincibilityInitPos(); // invincibility boost is redirected to its orignal position
  fuel.fuelInitPos(); // fuel boost is redirected to its orignal position
  health.healthInitPos(); // health boost is redirected to its orignal position
  asteroidObj.initAsteroidPos();
  meteor.initMeteorPos();
  if ((chapters == "Start" || chapters == "Carry on The Legacy") && !newGame) {
    win = true;
  } // player has won a round

  screens = "Home"; // changes game state
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
    text("Press C to Continue\n\nN to Play a New Game", width-550, height-200); // continue the game text
    textSize(25);
    text("Time Taken: " + levelTimer/1000 + " seconds", width-530, height-50); // time taken for the level text
    if (key == 'C' || key == 'c') {
      resetElements(); // calls the function to reset the elements of the game
    } // continue game key is clicked
    else if (key == 'N' || key == 'n') {
      newGame = true;
      resetElements(); // calls the function to reset the elements of the game
    } // new game key is clicked
    textSize(35);
    if (chapters == "Start") {
      text(chapters.toUpperCase(), width-485, height-410);
    } else {
      text(chapters.toUpperCase(), width-630, height-420);
    } // shows passed chapter text on the screen
  } else {
    image(chapterFailed, width-810, height-660);  // places chapter failed image on screen
    textFont(animated); // animated font is selected
    textSize(30);
    text("Press N to Play a New Game", width-620, height-180); // new game text
    if (key == 'N' || key == 'n') {
      newGame = true;
      resetElements(); // calls the function to reset the elements of the game
    } // new game key is clicked
    textSize(40);
    if (chapters == "Start") {
      text(chapters.toUpperCase(), width-500, height-370);
    } else if (chapters == "Carry on The Legacy") {
      text(chapters.toUpperCase(), width-660, height-370);
    } else {
      text(chapters.toUpperCase(), width-600, height-370);
    }// shows failed chapter text on the screen
  }
}

void gameOver() {

  /****************************************************
   Function for the Game Over Screen
   ****************************************************/

  /** Overrides the Previous Background Images **/
  image(backgroundPic, 0, backgroundY);  // draws the new first background image on screen
  image(backgroundPic, 0, backgroundY-backgroundPic.height); // places the new second background image on screen
  backgroundY+=6; // scrolls through the new backgrounds

  if (backgroundY >= backgroundPic.height) {
    backgroundY = 0;
  } // resets the new background once first image is fully moved through

  image(gameOverPlayer, 10, height-150); // player spaceship displayed bottom left
  image(gameOverPlayer, width-200, height-150); // player spaceship displayed bottom right
  image(gameOverPlayer, 10, height-680); // player spaceship displayed top left
  image(gameOverPlayer, width-200, height-680); // player spaceship displayed top right

  image(gameOver, width-700, height-600); // loads game over image
  fill(#FFFF00);
  obstacleDoDmg = false; // obstacles cant do damage now
  textSize(40);
  text("You are the Next SpaceStar..", width-730, height-300);
  text(finalName, width-450, height-250);

  textFont(animated);
  textSize(30);
  fill(#00FF00);
  text("Press N to Play a New Game", width-620, height-180); // continue the game text
  fill(#FF0000);
  text("Press E to Exit the Game", width-600, height-120); // continue the game text
  textSize(25);
  fill(#FFFF00);
  text("Total Time Taken: " + totalTimer/1000 + " seconds", width-590, height-50); // total time taken

  if (key == 'N' || key == 'n') {
    levelTimer = 0; // resets level timer
    totalTimer = 0; // resets total time
    resetElements(); // calls the function to reset the elements of the game
    chapters = "Start"; // chapter is changed
  } // new game key is clicked
  else if (key == 'E' || key == 'e') {
    exit(); // exits the game
  } // exit key is clicked
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
  } else if (player.playerSpaceshipX <= 10) {
    atLeftEndFlag = true; // reaches the left end
  }

  /** Makes sure the Player's Spaceship doesn't go off the screen **/
  if (atRightEndFlag) {
    if (key == 'd' || key == 'D') {
      player.playerSpaceshipX +=0;
    } else if (key == 'a' || key == 'A') {
      player.playerSpaceshipX -= player.playerSpeed * 10;
    }
  } else if (atLeftEndFlag) {
    if (key == 'a' || key == 'A') {
      player.playerSpaceshipX -= 0;
    } else if (key == 'd' || key == 'D') {
      player.playerSpaceshipX += player.playerSpeed * 10;
    }
  }

  /** ONLY If the Player's Spaceship is NOT Moving to the Extreme Right or Left **/
  /** Moves the Player's Spaceship Left and Right **/
  if (player.playerSpaceshipX < width-380 && player.playerSpaceshipX > 10 && !atRightEndFlag && !atRightEndFlag) {
    if (key == 'a' || key == 'A') {
      player.playerSpaceshipX -= player.playerSpeed * 10;
    } else if (key == 'd' || key == 'D') {
      player.playerSpaceshipX += player.playerSpeed * 10;
    }
  }

  /** Detect if the Player's Spaceship is Moving Extremely Up or Down- Planet **/
  if ((player.playerSpaceshipY+30 <= 0)  && allowPlayerYMovementPlanet) {
    atUpFlag = true; // reaches the top
  } // if the player's spaceship goes extremely to the top off the screen
  else if ((player.playerSpaceshipY+200 >= height) && allowPlayerYMovementPlanet) {
    atDownFlag = true; // reaches the bottom
  } // if the player's spaceship goes extremely to the bottom off the screen

  /** Detect if the Player's Spaceship is Moving Extremely Up or Down- Normal **/
  if ((player.playerSpaceshipY+30 <= height/2) && !allowPlayerYMovementPlanet) {
    atUpFlag = true; // reaches the top
  } // if the player's spaceship goes extremely to the top off the screen
  else if ((player.playerSpaceshipY+200 >= height) && !allowPlayerYMovementPlanet) {
    atDownFlag = true; // reaches the bottom
  } // if the player's spaceship goes extremely to the bottom off the screen

  /** Makes sure the Player's Spaceship doesn't go off the screen **/
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

  /** Moves the Player's Spaceship Up and Down **/
  if (!atUpFlag && !atDownFlag) {
    if (key == 'w' || key == 'W') {
      player.playerSpaceshipY -= player.playerSpeed * 10;
    } else if (key == 's' || key == 'S') {
      player.playerSpaceshipY += player.playerSpeed * 10;
    }
  }

  /** Move to Game Over Screen **/
  if (dist(homePlanetX+750, homePlanetY+735, player.playerSpaceshipX+135, player.playerSpaceshipY+125) <= 235) {
    homePlanetY = -820; // home planet is shifted off the screen
    allowPlayerYMovementPlanet = false; // player y movement for the planet isnt allowed
    screens = "End"; // changes game state
  }
}

void mouseReleased() {

  /****************************************
   Performs Action Based on Mouse Release
   ***************************************/

  /** Name TextBox **/
  for (TextBox t : textboxes) {
    t.pressed(mouseX, mouseY);
  } // records if the textbox region is pressed with the mouse

  /** Player Firing **/
  if (screens == "Play") {
    if (millis() - playerShootTime > 1000) {
      if (enemy.enemyLifeLeft > 0 && player.playerLifeLeft > 0) {
        playerBullet.playerShootBullet(); // function to shoot the player's bullet
        //playerBulletFire.play(); // plays player's bullet fire sound
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
