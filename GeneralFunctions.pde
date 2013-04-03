//------------------------------BEGIN-PROCESS--------------------------------
void startProcess(){
  //convert from binary to decimal,calculate & sort (sort is minmax or maxmin and use the last column(fitness result) as reference)
  calculate(bintoFloat(chromosomes),sortype);    
}

//-------------------------------CALCULATE FUNCTION----------------------------
void calculate(float paramresults[][], String sortype_) {
  float result = 0;
  //calculating the function
  for (int i = 0; i < paramresults.length; i++) {
    float x = paramresults[i][0];
    //float y = paramresults[i][1];
    //float z = paramresults[i][2];
    result =   sin(radians(sqrt(abs(x)))) * -x;  //f(x)=-xsen( √∣x∣ )  absolute value of sqrt(x)

    paramresults[i][paramresults[0].length-2] = result;
  }
  printFloat(paramresults);
  resultSort(paramresults, sortype_);  //sorting the results array
  printFloat(paramresults);
  matingPool(paramresults);  // do the matingPool function
  pairingChamp(paramresults);  //pairing using championship technique
  floattoBin();  //converting sorted values to bin and overwrite chromosomes[][] array
}

//------------------MATINGPOOL---------------

void matingPool(float paramresults[][]) {
  nPop = (round(random(1, paramresults.length)));
  nGood = (round(random(1, nPop)));
  nBad = nPop-nGood;
  println("nPop = " + nPop + " nGood = " +nGood + " Nbad = " +nBad);
}


//-----------------PAIRING-------------------
void pairingChamp(float paramresults[][]) {

  //generate two parents (array indexes) and choose the less one (best one)
  //then move it to paramresults array
  for (int i = 0; i < nGood; i++) {
    
    //generate parents
    int parent1 = ceil((nGood*random(0, 1)));
    int parent2 = ceil((nGood*random(0, 1))); 
    float parentmin = min(parent1, parent2);  //best one parent 
    println("p1 = " +  parent1 + " p2 = " + parent2 + " min = " + parentmin);

    //copy the best parent (parentmin) in to paramresults array til nGood index
      paramresults[i][paramresults[0].length-1] = parentmin;
  }
  printFloat(paramresults);  
}




//--------------------------------DISPLAY & PRINT FUNCTIONS------------------------------------
//print 1 and 0 status from every chromosome
void printBinary() {
  for (int i = 0; i < chromosomes.length; i++) {
    for (int j = 0; j < chromosomes[0].length; j++) {
      print(chromosomes[i][j].getBinary());
    }
    print("\n");
  }
}


//print paramResults Array
void printFloat(float paramresults[][]) {
  //printinr and running trough results array
  for (int i = 0; i < paramresults.length; i++) {
    for (int j = 0; j < paramresults[0].length; j++) {
      print("[" + paramresults[i][j] + "] ");
    } 
    print("\n");
  }
}


void displayChromosomes() {
  for (int i = 0; i < chromosomes.length; i++) {
    for (int j = 0; j < chromosomes[0].length; j++) {
      chromosomes[i][j].display();

      //chromosomes[i][j].goCenter();
    }
  }
}


//--------------------------------BINARY & FLOAT CONVERTION FUNCTIONS------------------------------------

void floattoBin(){  // converts float to binary and overwrite chromosomes array with the values


  
}


float[][] bintoFloat(Chromosome chromosomes[][]) {  //converts binary to float and storeit in paramresults[][] array
  int col = nbits*params;
  int row = nipop;
  int result = 0; 
  int limits = nbits;
  int ponential = 0;
  float paramresults[][] = new float[nipop][params+2];  //params+1

  for (int i = 0; i < chromosomes.length ; i++) {
    for (int j = chromosomes[0].length-1; j > -1; j--) { //read chromsomes array backwards  //-1

      if ((j > (col-limits)) && (chromosomes[i][j].status == true)) {
        result = result + int(pow(2, ponential));           // make the binary conversion
      }

      if (j == (col-limits)) {  // check sign & send to paramresults array

        if (chromosomes[i][j].status == true) {  // if sign = 1(true) then result = result *-1;
          result = result *-1;
        } 
        else if (chromosomes[i][j].status == false) {
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
        params = paramresults[0].length-2;
      }
    }
  }
  return paramresults;  //return value
}


//--------------------------------SORTING FUNCTIONS------------------------------------

void resultSort(float paramresults[][], String sortype) {
  int row = paramresults.length;  
  int col = paramresults[0].length;
  float [] aux = new float [col];

  if (sortype == "minmax") {   //order from min to max 
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < row-1; j++) {
        if (paramresults[j][(paramresults[0].length -2)] > paramresults[j+1][(paramresults[0].length -2)]) {
          for (int k = 0; k < col; k++) {
            aux[k] = paramresults[j][k];
            paramresults[j][k] = paramresults[j+1][k];
            paramresults[j+1][k] = aux[k];
          }
        }
      }
    }
    println("sorting from min to max...");
  } 
  else if (sortype == "maxmin") {   //order from max to min
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < row-1; j++) {
        if (paramresults[j][(paramresults[0].length -2)] < paramresults[j+1][(paramresults[0].length -2)]) {
          for (int k = 0; k < col; k++) {
            aux[k] = paramresults[j][k];
            paramresults[j][k] = paramresults[j+1][k];
            paramresults[j+1][k] = aux[k];
          }
        }
      }
    }
    println("sorting from max to min...");
  }

  else {
    println("sort string needs to be 'minmax' or 'maxmin' in order to sort");
  }
}

