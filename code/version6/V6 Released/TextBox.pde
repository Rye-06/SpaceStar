/****************************************
 ****
 TextBox Class
 ****
 ***************************************/

public class TextBox {

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   TextBox Variables
   ***
   **************************************/

  /** TextBox Coordinates, Width/Height **/
  public int X = 0;
  public int Y = 0;
  public int H = 35;
  public int W = 200;

  /** Colors/Styling of the Text **/
  public color background = color(140, 140, 140);
  public color foreground = color(0, 0, 0);
  public color backgroundSelected = color(160, 160, 160);
  public color border = color(30, 30, 30);
  public int textSize = 26;

  /** Border **/
  public boolean borderEnable = false;
  public int borderWeight = 1;

  /** Name **/
  public String name = ""; // name of the player
  public int textLength = 0; // text length

  private boolean selected = false;


  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   TextBox Constructors
   ***
   **************************************/

  TextBox() {
  } // default textbox constructor

  TextBox(int x, int y, int w, int h) {
    X = x;
    Y = y;
    W = w;
    H = h;
  } // textbox constructor with paramaters

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   TextBox Functions
   ***
   **************************************/

  void DRAW() {

    /*******************************************
     Draws the Text and the TextBox
     *******************************************/

    /** Draws the Background **/
    if (selected) {
      fill(backgroundSelected);
    } else {
      fill(background);
    }

    /** Draws the Border **/
    if (borderEnable) {
      strokeWeight(borderWeight);
      stroke(border);
    } else {
      noStroke();
    }

    /** Draws the TextBox Rectangle **/
    rect(X, Y, W, H);

    /** Draws the Text **/
    fill(foreground);
    textSize(textSize);
    text(name, X + (textWidth("a") / 2), Y + textSize);
  }

  boolean KEYPRESSED(char KEY, int keycode) {

    /*******************************************
     Checks Which Key is Pressed
     *******************************************/

    if (selected) {
      if (keycode == (int)BACKSPACE) {
        backspace();
      } else if (keycode == 32) {
        // SPACE
        addText(' ');
      } else if (keycode == (int)ENTER) {
        enter();
      } else {
        // CHECK IF THE KEY IS A LETTER OR A NUMBER
        boolean isKeyCapitalLetter = (KEY >= 'A' && KEY <= 'Z');
        boolean isKeySmallLetter = (KEY >= 'a' && KEY <= 'z');
        boolean isKeyNumber = (KEY >= '0' && KEY <= '9');

        if (isKeyCapitalLetter || isKeySmallLetter || isKeyNumber) {
          addText(KEY);
        }
      }
    }

    return false;
  }

  private void addText(char text) {

    /*******************************************
     Adds Text to the TextBox
     *******************************************/

    // IF THE TEXT WIDTH IS IN BOUNDARIES OF THE TEXTBOX
    if (textWidth(name + text) < W) {
      name += text;
      textLength++;
    }
  }

  private void backspace() {

    /*******************************************
     Checks to see if the Backspace Key is Pressed
     *******************************************/

    if (textLength - 1 >= 0) {
      name = name.substring(0, textLength - 1);
      textLength--;
    }
  }

  private void enter() {

    /*******************************************
     Checks to see if the Enter Key is Pressed
     *******************************************/

    if (textLength > 0) {
      Y = -500; // places the text box off the screen
      screens = "Home"; // sets the game state to the home screen
      blurredHomeWanted = false; // blurred home is not wanted anymore
      finalName = name; // saves the name
    }
  }

  private boolean overBox(int x, int y) {

    /******************************************************
     Function for testing if the mouse is over the text box
     ******************************************************/

    if (x >= X && x <= X + W) {
      if (y >= Y && y <= Y + H) {
        return true;
      }
    }

    return false;
  }

  void pressed(int x, int y) {

    /***************************************************
     Checks to see if the Textbox Region has been Pressed
     *************************************************/

    if (overBox(x, y)) {
      selected = true;
    } else {
      selected = false;
    }
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}
