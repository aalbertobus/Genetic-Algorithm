int nGood, nBad, nPop;

int nbits = 10; // cols for the initial population array
int nipop =10 ;  //rows for the initial population array
int params = 1;

String sortype = "minmax";  // sort type can be minmax or maxmin

//int col = nbits*params;
//int row = nipop;
Chromosome[][] chromosomes = new Chromosome[nipop][nbits*params];


void setup() {
  size(200, 200);
  smooth();
  //---------------Creating CHROMOSOMES---------
  for (int i = 0; i < chromosomes.length; i++) {
    for (int j = 0; j < chromosomes[0].length; j++) {
      chromosomes[i][j] = new Chromosome();
    }
  }
  //print status of every chromosome
  printBinary();

  //-----------------BEGIN PROCESS--------------
  startProcess();
}

void draw() {
  background(180);
  displayChromosomes(); //display
}

