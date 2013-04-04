int iteration = 0;
String infoText = "";

int nGood, nBad, nPop;
int nbits = 10; // cols for the initial population array
int nipop =500;  //rows for the initial population array
int params = 1;
String displayMode = "binary";
String sortype = "minmax";  // sort type can be minmax or maxmin

//int col = nbits*params;
//int row = nipop;
Chromosome[][] chromosomes = new Chromosome [nipop][params];

void setup(){
  frameRate(1);
  size(500, 500);
  background(180);
  smooth();
  //---------------Creating CHROMOSOMESGroup---------
  for (int i = 0; i < chromosomes.length; i++) {
    for (int j = 0; j < chromosomes[0].length; j++) {
      chromosomes[i][j] = new Chromosome(nbits);
    }
  }
  //print status of every chromosome
  iteration++;
   fill(255,255);
  text("Iteration = " + iteration, 50, 30); 
  displayChromosomes(displayMode); //display
  printBinary();

  //-----------------BEGIN PROCESS--------------
  startProcess();
}

void draw() {
  fill(180,100);
  rect(0,0,width,height);
  
  displayChromosomes(displayMode); //display
  fill(255,255);
  text("Iteration = " + iteration, 50, 30);
  text(infoText, 80, 50); 
  frameRate(60);
}

