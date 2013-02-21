class Population {
  int row, col, params;


  Population(int nbits, int nipop, int _params) {
    col = nbits * _params;  
    row = nipop;        
    params = _params;
  }

  int[][] generate() {
    int chromosomes[][] = new int[row][col];
    //run in the array and fill with random 0,1
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        //generate random between 0 & 1
        float rand = random(0, 1);
        //if its less than 0.5 = 0; if is more than 0-5 = 1;
        if (rand < 0.5) {
          chromosomes[i][j] = 0;
        } 
        else if (rand >= 0.5) {
          chromosomes[i][j] = 1;
        }
        print(chromosomes[i][j]); //print the population
      }
      print("\n");
    }
    return chromosomes;
  }


  float[][] convertBinary(int chromosomes[][]) {  //convert binary int to decimal int and return the params
    int result = 0; // to find decimal from every binary
    int limits = nbits;
    int ponential = 0;
    float paramresults [][] = new float[nipop][(params+1)];

    for (int i = 0; i < chromosomes.length ; i++) {
      for (int j = chromosomes[0].length-1; j > -1; j--) { //read chromsomes array backwards

        if ((j > (col-limits)) && (chromosomes[i][j] == 1)) {
          result = result + int(pow(2, ponential));           // make the binary conversion
        } 

        if (j == (col-limits)) {  // check sign & send to paramresults array

          if (chromosomes[i][j] == 1) {  // if sign = 1 then result = result *-1;
            result = result *-1;
          } 
          else if (chromosomes[i][j] == 0) {
            result = result * 1;
          }

          //storing in paramresults array 
          paramresults[i][(params-1)] = result;
          params--;
          //restarting values...
          ponential = 0;
          limits = limits+nbits;
          result = 0;
        } 
        else {
          ponential ++;
        }

        if (col-limits < 0) {   // end line
          limits = nbits;
          params = paramresults[0].length-1;
          //print("Done Line");
        }
      }
      // println("\n");
    }
    return paramresults;  //return value

    /*printinr and running trough results array
     for (int i = 0; i < paramresults.length; i++) {
     for (int j = 0; j < paramresults[0].length; j++) {
     print("[" + paramresults[i][j] + "] ");
     } 
     print("\n");
     }
     */
  }
}

