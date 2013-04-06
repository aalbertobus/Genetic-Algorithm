int iteration = 0;
String infoText = "";
float convergence = 0; 


int nGood, nBad, nPop;
int nbits = 5; // cols for the initial population array
int nipop =1000;  //rows for the initial population array
int params = 1;
String displayMode = "binary";
String sortype = "minmax";  // sort type can be minmax or maxmin
int time;
//int col = nbits*params;
//int row = nipop;
Chromosome[][] chromosomes = new Chromosome [nipop][params];
String[] results = new String[chromosomes.length]; // to store results to print in txt file
void setup() {
  frameRate(1);
  size(500, 500);
  background(180);
  smooth();
  time = 0;
  //---------------Creating CHROMOSOMESGroup---------
  for (int i = 0; i < chromosomes.length; i++) {
    for (int j = 0; j < chromosomes[0].length; j++) {
      chromosomes[i][j] = new Chromosome(nbits);
    }
  }
  //print status of every chromosome

  //visualizations and saving frames and initial data
  fill(255, 255);
  text("Iteration = " + iteration, 50, 30);
  displayChromosomes(displayMode); //display
  saveFrame("initialpopulation.jpg");  //save frame for initial population
  fill(255);
  text(infoText, width/2, height/2);
  textSize(12);
  //saving initial population to a txt file
  String[] initpopu = new String[chromosomes.length+2];
  for (int i = 0; i < chromosomes.length; i++) {
    initpopu[i] = chromosomes[i][0].chromoString;
  }
  initpopu[initpopu.length-2] = (nipop + " CHROMOSOMESGROUP GENERATED OF " + nbits + " CHROMOSOMES EACH ONE"); 
  initpopu[initpopu.length-1] = ("SORTYPE = " + sortype); 
  // Save to File
  saveStrings("initialpopulation.txt", initpopu);
  printBinary();
}

void draw() {
  frameRate(60);
  fill(180, 100);
  rect(0, 0, width, height);
  displayChromosomes(displayMode); //display
  fill(255, 255);
  text("Iteration = " + iteration, 50, 30);
  text(infoText, 80, 50); 
  if ( millis() > time ) {
    time = millis() + 2; //time for every iteration
    startProcess();
  }
}



