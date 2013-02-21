int nbits = 4; // rows for the initial population array
int nipop = 4;  //cols for the initial
int params = 3;

Population pops;


void setup() {
  size(200, 200);
  pops = new Population(nbits, nipop, params);
  calculate(pops.convertBinary(pops.generate()));  ////generate binary and convert it to decimal
}

void draw() {
}

void calculate(float paramresults[][]) {
  float result = 0;
  float results[] = new float[paramresults.length];  //arrsay to store results for the function

  //calculating the function
  for (int i = 0; i < paramresults.length; i++) {
    float x = paramresults[i][0];
    float y = paramresults[i][1];
    float z = paramresults[i][2];
    result = ((x*y)-z);
    //result = (result/((pow(x, 2))+(pow(y, 2))+(pow(z, 2))));
    paramresults[i][paramresults[0].length-1] = result;
  }

  //printinr and running trough results array
  for (int i = 0; i < paramresults.length; i++) {
    for (int j = 0; j < paramresults[0].length; j++) {
      print("[" + paramresults[i][j] + "] ");
    } 
    print("\n");
  }


  //sorting the array in base of results



  /*saving results to txt file
   String stringresults[] = new String[results.length];
   for (int i = 0; i < stringresults.length; i++) {
   stringresults[i] = results[i] + " ";
   }
   
   saveStrings("population.txt", stringresults);
   */
}



