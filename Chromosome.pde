class Chromosome {
  boolean status;  // is a 1 or 0 cromosome
  float x, y;
  float diam;


  Chromosome() {
    x = random(width);  //positionX
    y = random(height); //position Y
    diam = 50; //diameter
    if (random(0, 1) < 0.5) {  //assigning status
      status = false;
    } 
    else {
      status = true;
    }
  }

  void display() {
    noStroke();
    String string;
    //select color of cromosome
    if (status == true) {
      fill(0, 255, 30, 80); //green
      string = "1";
    } 
    else {
      fill(255, 0, 30, 100); // red
      string = "0";
    }

    ellipse(x, y, diam, diam);
    fill(0, 255);
    textAlign(CENTER);
    text(string, x, y+3);
  }

  String getBinary() {
    String binarytext;
    if (status == true) {
      binarytext = "1";
    } 
    else {
      binarytext = "0";
    }
    return binarytext;
  }
}

