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
   TextBox  Variables
   ***
   **************************************/

  public int X = 0, Y = 0, H = 35, W = 200;
  public int TEXTSIZE = 24;

  // COLORS
  public color Background = color(140, 140, 140);
  public color Foreground = color(0, 0, 0);
  public color BackgroundSelected = color(160, 160, 160);
  public color Border = color(30, 30, 30);

  public boolean BorderEnable = false;
  public int BorderWeight = 1;

  public String name = "";
  public int TextLength = 0;

  private boolean selected = false;


  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   TextBox Constructors
   ***
   **************************************/

  TextBox() {
    // CREATE OBJECT DEFAULT TEXTBOX
  }

  TextBox(int x, int y, int w, int h) {
    X = x;
    Y = y;
    W = w;
    H = h;
  } // textbox constructor

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
      fill(BackgroundSelected);
    } else {
      fill(Background);
    }

    /** Draws the Border **/
    if (BorderEnable) {
      strokeWeight(BorderWeight);
      stroke(Border);
    } else {
      noStroke();
    }

    /** Draws the TextBox Rectangle **/
    rect(X, Y, W, H);

    /** Draws the Text **/
    fill(Foreground);
    textSize(TEXTSIZE);
    text(name, X + (textWidth("a") / 2), Y + TEXTSIZE);
  }

  boolean KEYPRESSED(char KEY, int KEYCODE) {

    /*******************************************
     Checks which Key is Pressed
     *******************************************/

    if (selected) {
      if (KEYCODE == (int)BACKSPACE) {
        backspace();
      } else if (KEYCODE == 32) {
        // SPACE
        addText(' ');
      } else if (KEYCODE == (int)ENTER) {
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
      TextLength++;
    }
  }

  private void backspace() {

    /*******************************************
     Checks to see if the Backspace Key is Pressed
     *******************************************/

    if (TextLength - 1 >= 0) {
      name = name.substring(0, TextLength - 1);
      TextLength--;
    }
  }

  private void enter() {

    /*******************************************
     Checks to see if the Enter Key is Pressed
     *******************************************/

    if (TextLength > 0) {
      Y = -500; // places the text box off the screen
      screens = "Home"; // sets the game state to the home screen
      blurredHomeWanted = false; // blurred home is not wanted anymore
      finalName = name; // saves the name
    }
  }

  private boolean overBox(int x, int y) {

    /***************************************************
     Function for testing if the mouse is over the text box
     ***************************************************/

    if (x >= X && x <= X + W) {
      if (y >= Y && y <= Y + H) {
        return true;
      }
    }

    return false;
  }

  void pressed(int x, int y) {

    /*******************************************
     Checks to see if the Textbox Region been Pressed
     *********************************************/

    if (overBox(x, y)) {
      selected = true;
    } else {
      selected = false;
    }
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}
