int iteration = 0;  // track iterations
String infoText = "";  // to display string on screen
float convergence = 0; //convergence variable
int chromosomeCounter = 0; // for mutation
String displayMode = "binary"; // string variable to set binary and decimal display
String sortype = "minmax";  // sort type can be minmax or maxmin
int time; // to use a timer in draw function
//-------SETTINGS------------------
int nGood, nBad, nPop;
int nbits = 10; // cols for the initial population array
int nipop =1000;  //rows for the initial population array
int params = 1; 

//int col = nbits*params;
//int row = nipop;
Chromosome[][] chromosomes = new Chromosome [nipop][params];
String[] results = new String[chromosomes.length]; // to store results to print in txt file

//setup only executes once
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
      chromosomeCounter ++;
    }
  }

  //visualizations and saving frames for initial data
  fill(255, 255);
  text("Iteration = " + iteration, 50, 30);
  displayChromosomes(displayMode); //display
  saveFrame("poblacionInicial..jpg");  //save frame for initial population
  fill(255);
  text(infoText, width/2, height/2); // show infotext(iterations)
  textSize(12);

  //saving initial population to a txt file
  String[] initpopu = new String[chromosomes.length+2];
  for (int i = 0; i < chromosomes.length; i++) {
    initpopu[i] = chromosomes[i][0].chromoString;
  }
  initpopu[initpopu.length-2] = (nipop + " CHROMOSOMESGROUP GENERATED OF " + nbits + " CHROMOSOMES EACH ONE"); 
  initpopu[initpopu.length-1] = ("SORTYPE = " + sortype); 
  // Save to File
  saveStrings("poblacionInicial..txt", initpopu);
  printBinary();
}


//draw is always executing
void draw() {
  frameRate(60);
  fill(180, 100);
  rect(0, 0, width, height); // blur effect

    displayChromosomes(displayMode); //display chromosomes
  fill(255, 255);
  text("Iteration = " + iteration, 50, 30);
  text(infoText, 80, 50); 
  //counter to executes iterations every fraction of time
  if ( millis() > time ) {
    time = millis() + 2; //time for every iteration

    /*start process (check GeneralFunctions.pde file)
     startProcess() method involves:
     
     -calculate fitness data
     -sort data
     -matingpool
     -pairing using championsip method
     -Crossing
     */
    startProcess();
  }
}

