class Chromosome {
  char status;  // is a 1 or 0 cromosome
  float x, y;
  float diam;
  String chromoString;

  Chromosome(int nbits_) {
    x = random(width);  //positionX
    y = random(height); //position Y
    diam = nbits_*8; //diameter
    chromoString = doChromosomes(nbits_);
  }

  void display() {
    noStroke();
     //select color of cromosome
     String string = chromoString;
    if(chromoString.charAt(0) == '1'){
      fill(255, 0, 30, 100); // red
    } else if(chromoString.charAt(0) == '0'){
      fill(0, 255, 30, 80); //green
    }
    ellipse(x, y, diam, diam);
    fill(0, 255);
    textAlign(CENTER);
    text(string, x, y+3);
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

