/****************************************
 Bullet Class
 ***************************************/

class Bullet {


  void fire() {

    /****************************************
     Fire Function
     ***************************************/

    if (mousePressed && chapters == "Play") {
      rect(playerSpaceshipX+175, playerSpaceshipY-70, 20, 100); // bullet
    }
  }
}
