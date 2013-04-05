class Chromosome {
  char status;  // is a 1 or 0 cromosome
  float x, y;
  float velX; 
   float velY; 
  float diam;
  int dir;
  String chromoString;

  Chromosome(int nbits_) {
    x = random(width);  //positionX
    y = random(height); //position Y
    velX= random(1, 5); //velocity X
    velY= random(1, 5); //velocity Y
    if(random(0,1) < 0.5){  //seting direction;
      dir = -1 ;  
    } else {
      dir = 1;  
    }
    diam = nbits_*8; //diameter
    chromoString = doChromosomes(nbits_);
  }

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
      } else if(chromoString.charAt(0) == ' '){
          fill(180, 0); //gray
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
    ellipse(x, y, diam, diam);
    fill(0, 255);
    textAlign(CENTER);
    text(string, x, y+3);

     x = x+velX *dir;
    y = y+velY * dir;
    
    //check edges
    if(x > width ||  x < 0 ||y < 0 || y > height ){
      dir = dir * -1;  
    }
    
  }

  char statusChromosome() {
    if (random(0, 1) < 0.5) {  //assigning status
      status = '0';
    } 
    else {
      status = '1';
    }
    return status;
  }

 
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

