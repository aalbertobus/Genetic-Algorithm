int nGood,nBad,nPop;

int nbits = 4; // cols for the initial population array
int nipop =5 ;  //rows for the initial population array
int params = 3;

String sortype = "maxmin";  // sort type can be minmax or maxmin

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
//-----------------BEGIN PROCESS--------------
  //print status of every chromosome
  printBinary();
   //convert from binary to decimal,calculate & sort (sort is minmax or maxmin and use the last column(fitness result) as reference)
  calculate(bintoFloat(chromosomes),sortype);
  
}

void draw() {
  background(180);
  displayChromosomes(); //display 
   
}

