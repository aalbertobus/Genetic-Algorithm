class Chromosome {
  char status;  // is a 1 or 0 chromosome?
  float x, y;   //x & y position to locate chromosomeGroup on screen
  float velX;   //velocity x, y
  float velY; 
  float diam;  //diameter
  int dir;     //direction 
  String chromoString;//chromoString stores the whole binary number in a string

    Chromosome(int nbits_) {
    //Random positions,velocities & directions
    x = random(width);  
    y = random(height); 
    velX= random(1, 5); 
    velY= random(1, 5); 
    //seting direction
    if (random(0, 1) < 0.5) {  
      dir = -1 ;
    } 
    else {
      dir = 1;
    }
    diam = nbits_*8; //diameter
    chromoString = doChromosomes(nbits_); //doChromosomes(int nbits) function fills chromoString values
  }

  //to display chromosomeGroups
  void display(String displayMode_) {
    noStroke();
    //select color of cromosome
    String string = chromoString;
    if (displayMode_ == "binary") {
      if (chromoString.charAt(0) == '1') {
        fill(255, 0, 30, 100); // red
      } 
      else if (chromoString.charAt(0) == '0' ) {
        fill(0, 255, 30, 80); //green
      } 
      else if (chromoString.charAt(0) == ' ') {
        fill(180, 0); //gray (our background is gray to these are invisibles
      }
    }

    if (displayMode_ == "decimal") {
      if (chromoString.charAt(0) == '-') {
        fill(255, 0, 30, 100); // red
      } 
      else {
        fill(0, 255, 30, 80); //green
      }
    }
    //drawing the circle
    ellipse(x, y, diam, diam);
    fill(0, 255);
    textAlign(CENTER);
    text(string, x, y+3);

    //Adding velocity to our position
    x = x+velX *dir; 
    y = y+velY * dir;

    //check edges
    if (x > width ||  x < 0 ||y < 0 || y > height ) {
      dir = dir * -1;
    }
  }

  //define 1 or 0 with a random function
  char statusChromosome() {
    if (random(0, 1) < 0.5) {  //assigning status
      status = '0';
    } 
    else {
      status = '1';
    }
    return status;
  }


  //generate a group of 1 & 0's in a string= this is a chromosomeGroup
  String doChromosomes(int nbits_) {
    String binarytext = "";
    char status_;
    for (int i = 0; i < nbits_; i++) {
      status_ = statusChromosome();
      binarytext = binarytext + status_;
    }
    return binarytext;
  }
}

